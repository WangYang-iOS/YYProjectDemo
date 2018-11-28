//
//  FXSegment.m
//  FXQL
//
//  Created by yons on 2018/10/19.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXSegment.h"
#define segmentH 45

@interface FXSegment ()
@property(strong, nonatomic) NSArray *titles;
@property(strong, nonatomic) UIView *bottomView;
@property(strong, nonatomic) UIButton *selectedButton;
@end

@implementation FXSegment

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles delegate:(id<FXSegmentDelegate>)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.normalColor = [UIColor colorWithHexString:@"#2B3343"];
        self.selectedColor = [UIColor colorWithHexString:@"#1E6DFF"];
        self.font = PingFangSCRegular(14);
        self.normalImage = @"ic_segment_down";
        self.selectedImage = @"ic_segment_up";
        self.lineColor = MAINRGB;
        self.titles = titles;
        self.delegate = delegate;
    }
    return self;
}

- (void)clickButton:(UIButton *)button {
//    if (self.showBottomLine) {
//        self.bottomView.center = POINT(button.center.x, self.bottomView.center.y);
//    }
    if (button != self.selectedButton) {
        button.selected = !button.selected;
        self.selectedButton.selected = !self.selectedButton.selected;
        self.selectedButton = button;
    }
    
    if ([self.delegate respondsToSelector:@selector(segment:didSelectedAtIndex:)]) {
        [self.delegate segment:self didSelectedAtIndex:button.tag - 1000];
    }
}

- (void)selectedAtIndex:(NSInteger)index {
    UIButton *button = [self viewWithTag:1000 + index];
    [self clickButton:button];
}

- (void)moveBottomViewWithContentOffset:(CGPoint)contentOffset {
    CGFloat width = [self getWidth] / self.titles.count;
    if (self.showBottomLine) {
        self.bottomView.center = POINT(width / 2.0 + contentOffset.x * (width / [self getWidth]), self.bottomView.center.y);
    }
    NSInteger index = (contentOffset.x + [self getWidth] * 0.5)/[self getWidth];
    UIButton *button = [self viewWithTag: 1000 + index];
    if (button != self.selectedButton) {
        button.selected = !button.selected;
        self.selectedButton.selected = !self.selectedButton.selected;
        self.selectedButton = button;
    }
}

#pragma mark
#pragma mark -- UI

- (void)layoutViews {
    CGFloat width = [self getWidth] / self.titles.count;
    CGFloat height = segmentH - 1;
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = RECT(width * i, 0, width, height);
        button.titleLabel.font = self.font;
        button.tag = 1000 + i;
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:self.normalColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedColor forState:UIControlStateSelected];
        [button setImage:IMAGE(self.normalImage) forState:UIControlStateNormal];
        [button setImage:IMAGE(self.selectedImage) forState:UIControlStateSelected];
        [self addSubview:button];
        if (i == 0) {
            button.selected = YES;
            self.selectedButton = button;
            if (self.showBottomLine) {
                self.bottomView.center = POINT(button.center.x, self.bottomView.center.y);
            }
        }
        if (self.normalImage.length > 0) {
            [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        }
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:RECT(0, segmentH - LINE_H, [self getWidth], LINE_H)];
    lineView.backgroundColor = color_line;
    [self addSubview:lineView];
}

#pragma mark
#pragma mark -- setter
- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self layoutViews];
}
- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    [self layoutViews];
}
- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    [self layoutViews];
}
- (void)setNormalImage:(NSString *)normalImage {
    _normalImage = normalImage;
    [self layoutViews];
}
- (void)setSelectedImage:(NSString *)selectedImage {
    _selectedImage = selectedImage;
    [self layoutViews];
}
- (void)setFont:(UIFont *)font {
    _font = font;
    [self layoutViews];
}
- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    [self layoutViews];
}


#pragma mark
#pragma mark -- lazy

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:RECT(0, [self getHeight] - 3 - LINE_H, 20, 3)];
        _bottomView.backgroundColor = self.lineColor;
        [self addSubview:_bottomView];
        [_bottomView cornerWithRadius:1.5];
    }
    return _bottomView;
}

@end

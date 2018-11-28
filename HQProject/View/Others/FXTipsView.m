//
//  FXTipsView.m
//  FXQL
//
//  Created by yons on 2018/10/26.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXTipsView.h"

@interface FXTipsView ()
@property(strong, nonatomic) UIView *contentView;
@property(strong, nonatomic) NSArray *titles;
@property(strong, nonatomic) NSArray *images;
@property(copy, nonatomic) void(^complete)(NSInteger index);
@end

@implementation FXTipsView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                       images:(NSArray *)images
                     complete:(void(^)(NSInteger index))complete {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        [self addSubview:self.contentView];
        self.titles = titles;
        self.images = images;
        self.complete = complete;
        [self layoutContentView];
    }
    return self;
}

- (void)layoutContentView {
    
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *button = [UIButton buttonWithTitle:self.titles[i] titleColor:@"2B3343" font:PingFangSCRegular(15)];
        if (self.images.count > 0) {
            [button setImage:IMAGE(self.images[i]) forState:UIControlStateNormal];
            [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        }
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000 + i;
        [self.contentView addSubview:button];
    }
    for (int i = 1; i < self.titles.count; i++) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = color_line;
        lineView.tag = 2000 + i;
        [self.contentView addSubview:lineView];
    }
}

- (void)clickButton:(UIButton *)button {
    if (self.complete) {
        self.complete(button.tag - 1000);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = RECT(0, 8, [self getWidth], [self getHeight] - 8);
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *button = [self.contentView viewWithTag:1000 + i];
        button.frame = RECT(0, 44 * i, [self getWidth], 44);
    }
    for (int i = 1; i < self.titles.count; i++) {
        UIView *lineView = [self.contentView viewWithTag:2000 + i];
        lineView.frame = RECT(10, 44 * i, [self getWidth] - 20, 0.5);
    }
}

- (void)drawRect:(CGRect)rect {
    //设置线条颜色
    [self.contentView.backgroundColor set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0f;
    CGFloat X = [self getWidth] - 15 - 14;
    [path moveToPoint:CGPointMake(X, 8)];
    [path addLineToPoint:CGPointMake(X + 14/2.0, 0)];
    [path addLineToPoint:CGPointMake(X + 14, 8)];
    [path fill];
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [_contentView cornerWithRadius:5];
    }
    return _contentView;
}
@end

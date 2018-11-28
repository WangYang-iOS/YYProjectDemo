//
//  FXNavigationBar.m
//  FXQL
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXNavigationBar.h"

@interface FXNavigationBar ()
@property(strong, nonatomic) UIView *lineView;
@property(strong, nonatomic) UIView *contentView;
@property(strong, nonatomic) UILabel *titleLabel;

@end

@implementation FXNavigationBar

- (instancetype)init {
    if (self = [super init]) {
        self.frame = RECT(0, 0, SCREENW, NAVIH);
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.leftButton];
    }
    return self;
}

#pragma mark
#pragma mark -- pravate methods

- (void)removeNavigationBarBottomLine:(BOOL)hidden {
    self.lineView.hidden = hidden;
}

#pragma mark
#pragma mark -- setter

- (void)setHiddenLeftButton:(BOOL)hiddenLeftButton {
    _hiddenLeftButton = hiddenLeftButton;
    self.leftButton.hidden = hiddenLeftButton;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    _rightButtonTitle = rightButtonTitle;
    
    CGFloat width = [rightButtonTitle widthWithFont:PingFangSCRegular(15)];
    if (self.rightButton) {
        [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    }else {
        self.rightButton = [UIButton buttonWithTitle:rightButtonTitle titleColor:@"#2B3343" font:PingFangSCRegular(15)];
        [self.contentView addSubview:self.rightButton];
    }

    self.rightButton.frame = RECT(SCREENW - width - 10, 0, width, 44);
}

- (void)setRightButtonImage:(NSString *)rightButtonImage {
    _rightButtonImage = rightButtonImage;    
    if (self.rightButton) {
        [self.rightButton setImage:IMAGE(rightButtonImage) forState:UIControlStateNormal];
    }else {
        self.rightButton = [UIButton buttonWithImage:rightButtonImage];
        self.rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
        self.rightButton.frame = RECT(SCREENW - 60, 0, 60, 44);
        [self.contentView addSubview:self.rightButton];
    }
}

- (void)setTitleView:(UIView *)titleView {
    _titleView = titleView;
    [self.contentView addSubview:self.titleView];
    CGFloat leftWidth = self.leftButton.hidden ? 0 : 32;
    CGFloat centerX = SCREENW / 2.0;
    if (self.rightButton) {
        centerX = (self.rightButton.hidden ? (SCREENW - leftWidth) / 2.0 : (SCREENW - leftWidth - [self.rightButton getWidth]) / 2.0) + leftWidth;
        NSLog(@"%f",centerX);
    }
    self.titleView.center = POINT(centerX, 22);
}

#pragma mark
#pragma mark -- UI

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:RECT(0, [self getHeight] - 44, SCREENW, 44)];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:RECT(0, [self.contentView getHeight] - LINE_H, SCREENW, LINE_H)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFont:PingFangSCBold(18) textColor:@"#2B3343" textAlignment:NSTextAlignmentCenter];
        _titleLabel.frame = RECT(0, 0, SCREENW - 60 * 2, 44);
        _titleLabel.center = POINT(SCREENW / 2.0, 22);
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithImage:@"ic_back"];
        _leftButton.frame = RECT(0, 0, 32, 44);
    }
    return _leftButton;
}

@end

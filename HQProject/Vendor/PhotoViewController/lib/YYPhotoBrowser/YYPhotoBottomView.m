//
//  YYPhotoBottomView.m
//  FXQL
//
//  Created by yons on 2018/10/30.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "YYPhotoBottomView.h"

@interface YYPhotoBottomView ()
@property(strong, nonatomic) UIButton *sureButton;
@end

@implementation YYPhotoBottomView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:self.sureButton];
    }
    return self;
}

- (void)clickButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(didClickSureAtBottomView:)]) {
        [self.delegate didClickSureAtBottomView:self];
    }
}

- (UIButton *)sureButton {
    if(!_sureButton) {
        _sureButton = [UIButton buttonWithTitle:@"确定" titleColor:@"ffffff" font:FONT(14)];
        _sureButton.backgroundColor = [UIColor colorWithHexString:@"D81B24"];
        _sureButton.frame = RECT(SCREENW - 70 - 15, 0, 70, 33);
        _sureButton.center = POINT(_sureButton.center.x, [self getHeight] / 2.0);
        [_sureButton cornerWithRadius:3];
        [_sureButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
    return _sureButton;
}

@end

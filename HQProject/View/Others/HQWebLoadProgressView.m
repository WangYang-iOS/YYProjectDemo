//
//  HQWebLoadProgressView.m
//  Chengqu
//
//  Created by wangyang on 2018/9/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "HQWebLoadProgressView.h"

@interface HQWebLoadProgressView ()
@property (nonatomic, assign) CGFloat width;
@end

@implementation HQWebLoadProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.width = 0.0;
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.backgroundColor = lineColor;
}

- (void)setWidth:(CGFloat)width {
    _width = width;
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.hidden = NO;
    self.alpha = 1;
    
    self.width = SCREENW * progress;
    
    if (progress == 1) {
        [UIView animateWithDuration:0.2 animations:^{
            self.width = SCREENW;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)startLoadingAnimation {
    self.hidden = NO;
    self.alpha = 1;
    if (self.width > 0.6 * SCREENW) {
        return;
    }
    [UIView animateWithDuration:0.4 animations:^{
        self.width = SCREENW * 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.width = SCREENW * 0.8;
        }];
    }];
}

- (void)endLoadingAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        self.width = SCREENW;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

@end

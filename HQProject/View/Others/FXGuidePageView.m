//
//  FXGuidePageView.m
//  FXQL
//
//  Created by yons on 2018/11/16.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXGuidePageView.h"

@interface FXGuidePageView ()
@property (strong, nonatomic) UIScrollView *scrollView;
@end

@implementation FXGuidePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self layoutGuidePageView];
    }
    return self;
}

- (void)layoutGuidePageView {
    for (int i = 1; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:RECT(SCREENW * (i - 1), 0, SCREENW, SCREENH)];
        NSString *img = [NSString stringWithFormat:@"img_leader_%d",i];
        imageView.image = IMAGE(img);
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        if (i == 3) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = RECT(0, 3 * SCREENH / 4.0, SCREENW, SCREENH / 4.0);
            [imageView addSubview:button];
            @weakify(self)
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self)
                [HQCommenMethods saveValue:@1 key:FXFirstLaunch];
                if (self.callback) {
                    self.callback();
                }
                [UIView animateWithDuration:0.25 animations:^{
                    self.alpha = 0;
                } completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }];
            }];
        }
        
    }
    self.scrollView.contentSize = SIZE(SCREENW * 3, 0);
}

#pragma mark
#pragma mark -- lazy

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

@end

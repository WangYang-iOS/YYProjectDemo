//
//  FXToolTip.m
//  FXQL
//
//  Created by yons on 2018/10/26.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXToolTip.h"
#import "FXTipsView.h"

@interface FXToolTip ()
@property(strong, nonatomic) FXTipsView *tipsView;
@end

@implementation FXToolTip

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = RECT(0, 0, SCREENW, SCREENH);
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTipsView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)removeTipsView:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0];
        self.tipsView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.tipsView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

+ (void)showTipsViewWithComplete:(void(^)(NSInteger index))complete {
    FXToolTip *shadowView = [[FXToolTip alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [MainWindow addSubview:shadowView];
    
    FXTipsView *tipsView = [[FXTipsView alloc] initWithFrame:RECT(SCREENW - 128 - 6, NAVIH + 2, 128, 96) titles:@[@"创建群   ",@"多群聊天"] images:@[@"ic_add_group",@"ic_add_chat"] complete:^(NSInteger index) {
        [shadowView removeTipsView:nil];
        if (complete) {
            complete(index);
        }
    }];
    tipsView.alpha = 0;
    [shadowView addSubview:tipsView];
    shadowView.tipsView = tipsView;
    
    [UIView animateWithDuration:0.25 animations:^{
        shadowView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
        tipsView.alpha = 1;
    }];
}


@end

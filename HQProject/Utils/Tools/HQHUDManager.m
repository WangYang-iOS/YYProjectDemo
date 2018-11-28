//
//  HQHUDManager.m
//  Chengqu
//
//  Created by wangyang on 2018/3/19.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "HQHUDManager.h"
#import <MBProgressHUD.h>

static MBProgressHUD *_myHUD;
static NSTimer *_timer;

@implementation HQHUDManager

/**
 *  文字提示 显示时间为1.5妙
 */
+ (void)hudWithText:(NSString *)text {
    [HQHUDManager hidden];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    _myHUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    _myHUD.mode = MBProgressHUDModeText;
    _myHUD.detailsLabelText = text;
    _myHUD.margin = 10.f;
    _myHUD.yOffset = 150.f;
    _myHUD.removeFromSuperViewOnHide = YES;
    [_myHUD hide:YES afterDelay:1.5];
}

/**
 *  请求提示
 */
+ (void)showProgress {
    [HQHUDManager hidden];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    _myHUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:_myHUD];
    _myHUD.mode = MBProgressHUDModeIndeterminate;
    [_myHUD show:YES];
    [_timer invalidate];
    _timer = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(hidden) userInfo:nil repeats:NO];
}

/**
 *  请求提示
 */
+ (void)showProgressWithText:(NSString *)text {
    [HQHUDManager hidden];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    _myHUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:_myHUD];
    _myHUD.mode = MBProgressHUDModeIndeterminate;
    _myHUD.detailsLabelText = text;
    [_myHUD show:YES];
    [_timer invalidate];
    _timer = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(hidden) userInfo:nil repeats:NO];
}
/**
 *  移除
 */
+ (void)hidden {
    [_timer invalidate];
    _timer = nil;
    [_myHUD hide:YES];
    [_myHUD removeFromSuperview];
    _myHUD = nil;
}

@end

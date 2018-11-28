//
//  HQHUDManager.h
//  Chengqu
//
//  Created by wangyang on 2018/3/19.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQHUDManager : NSObject

/**
 *  文字提示 显示时间为1.5妙
 */
+ (void)hudWithText:(NSString *)text;

/**
 *  请求提示
 */
+ (void)showProgress;

/**
 *  请求提示
 */
+ (void)showProgressWithText:(NSString *)text;

/**
 *  移除
 */
+ (void)hidden;

@end

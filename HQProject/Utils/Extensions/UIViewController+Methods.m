//
//  UIViewController+Methods.m
//  Chengqu
//
//  Created by WY的七色花 on 2018/4/12.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UIViewController+Methods.h"

@implementation UIViewController (Methods)

/**
 是否使用IQKeyboardManager
 
 @param enable enable description
 */
- (void)keyBorderEnable:(BOOL)enable {
    [[IQKeyboardManager sharedManager] setEnable:enable];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

@end

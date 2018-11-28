//
//  UIViewController+Nav.h
//  Chengqu
//
//  Created by wangyang on 2018/3/20.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Nav)

/**
 去除导航栏下面那条黑线
 */
- (void)removeNavigationBarDownline;
- (void)showNavigationBarDownline;
- (void)setNavigationBarColor:(NSString *)color alpha:(CGFloat)alpha;

/**
 设置导航左边按钮

 @param img img description
 */
- (void)backButton:(NSString *)img;

/**
 根据title设置右按钮

 @param title title description
 */
- (void)rightBarButtonWithTitle:(NSString *)title;

/**
 根据图片设置左按钮

 @param image image description
 */
- (void)leftBarButtonWithImage:(NSString *)image;

/**
 返回按钮点击事件
 */
- (void)clickBackButton;

/**
 导航又按钮点击事件
 */
- (void)clickRightButton;

@end

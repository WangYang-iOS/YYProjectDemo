//
//  UIButton+Chained.h
//  链式
//
//  Created by wangyang on 2018/3/28.
//  Copyright © 2018年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 链式语法初涉及
 */
@interface UIButton (Chained)

/**
 创建button
 */
+ (UIButton *(^)(void))initButton;

/**
 设置button常规状态下的文字
 */
- (UIButton *(^)(NSString *))normalTitle;

/**
 设置button选中状态下文字
 */
- (UIButton *(^)(NSString *))selectedTitle;

/**
 设置button常规状态下文字颜色
 */
- (UIButton *(^)(UIColor *))normalTitleColor;

/**
 设置button选中状态下颜色
 */
- (UIButton *(^)(UIColor *))selectedTitleColor;

/**
 设置字体颜色
 */
- (UIButton *(^)(CGFloat))titleFont;

/**
 设置按钮常规图片
 */
- (UIButton *(^)(UIImage *))normalImage;

/**
 设置按钮选中图片
 */
- (UIButton *(^)(UIImage *))selectedImage;
@end

//
//  NSMutableAttributedString+AttributedString.h
//  链式
//
//  Created by wangyang on 2018/3/28.
//  Copyright © 2018年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 链式语法初涉及
 */
@interface NSMutableAttributedString (AttributedString)

/**
 初始化创建一个AttributedString
 */
+ (NSMutableAttributedString *(^)(NSString *))initAttributedString;

/**
 设置AttributedString字体大小
 */
- (NSMutableAttributedString *(^)(CGFloat))attributedFont;

/**
 设置AttributedString字体颜色
 */
- (NSMutableAttributedString *(^)(UIColor *))attributedColor;

/**
 设置AttributedString字体行间距
 */
- (NSMutableAttributedString *(^)(CGFloat))attributedSpace;

/**
 设置指定位置字体颜色
 */
- (NSMutableAttributedString *(^)(UIColor *,NSRange))attributedRangeColor;

/**
 设置指定位置字体大小
 */
- (NSMutableAttributedString *(^)(CGFloat,NSRange))attributedRangeFont;

- (NSMutableAttributedString *(^)(CGFloat,NSRange))attributedRangeBoldFont;
@end

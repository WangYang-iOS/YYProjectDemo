//
//  UIView+Category.h
//  wangyang
//
//  Created by wangyang on 16/1/6.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

#pragma mark -
#pragma mark - 关于位置

/**
 * 获取视图 x 坐标
 *
 *  @return x 坐标
 */
- (CGFloat)getX;
/**
 * 获取视图 y 坐标
 *
 *  @return y 坐标
 */
- (CGFloat)getY;
/**
 * 获取视图 宽度
 *
 *  @return 宽度
 */
- (CGFloat)getWidth;
/**
 * 获取视图 高度
 *
 *  @return 高度
 */
- (CGFloat)getHeight;
/**
 * 获取视图 最右边 距 父视图左边 距离
 *
 *  @return 距离
 */
- (CGFloat)getMaxX;
/**
 * 获取视图 最下边 距 父视图上边 距离
 *
 *  @return 距离
 */
- (CGFloat)getMaxY;
/**
 *  获取视图 中心点 X
 *
 *  @return center.x
 */
- (CGFloat)getMidX;
/**
 *  获取视图 中心点 Y
 *
 *  @return center.y
 */
- (CGFloat)getMidY;

#pragma mark -
#pragma mark - 关于设置圆角

/**
 *  切圆
 */
- (void)fillCorner;
/**
 *  切指定圆角
 *
 *  @param radius 圆角半径
 */
- (void)cornerWithRadius:(CGFloat)radius;
/**
 *  设置边框
 *
 *  @param radius      半径
 *  @param borderWidth 边框宽度
 *  @param colorString 边框颜色 6位16进制字符串
 */
- (void)borderWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(NSString *)colorString;

#pragma mark -
#pragma mark - 关于画线

/**
 *  画线
 *
 *  @param top   居上
 *  @param left  居左
 *  @param right 居右
 */
- (void)lineFromTop:(float)top left:(float)left toRight:(float)right;
/**
 *  上部横线
 */
- (void)topLine;
/**
 *  下部横线
 */
- (void)bottomLine;

/**
 颜色 透明度 半径 偏移

 @param colorString 1
 @param opacity 1
 @param radius 1
 @param offset 1
 */
- (void)shadowColorString:(NSString *)colorString opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

#pragma mark
#pragma mark -- XIB

@property(assign, nonatomic) IBInspectable CGFloat fx_radius;
@property(assign, nonatomic) IBInspectable CGFloat fx_borderWidth;
@property(strong, nonatomic) IBInspectable UIColor *fx_borderColor;

@property(assign, nonatomic) IBInspectable CGFloat fx_shadowRadius;
@property(strong, nonatomic) IBInspectable UIColor *fx_shadowColor;
@property(assign, nonatomic) IBInspectable CGFloat fx_shadowOpacity;
@property(assign, nonatomic) IBInspectable CGSize fx_shadowOffset;

@end



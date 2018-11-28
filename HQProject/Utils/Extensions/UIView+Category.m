//
//  UIView+Category.m
//  wangyang
//
//  Created by wangyang on 16/1/6.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

#pragma mark -
#pragma mark - 拓展方法 (私有)

- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}
- (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1];
}


#pragma mark -
#pragma mark - 关于位置

/**
 * 获取视图 x 坐标
 *
 *  @return x 坐标
 */
- (CGFloat)getX {
    return self.frame.origin.x;
}
/**
 * 获取视图 y 坐标
 *
 *  @return y 坐标
 */
- (CGFloat)getY {
    return self.frame.origin.y;
}
/**
 * 获取视图 宽度
 *
 *  @return 宽度
 */
- (CGFloat)getWidth {
    return self.frame.size.width;
}
/**
 * 获取视图 高度
 *
 *  @return 高度
 */
- (CGFloat)getHeight {
    return self.frame.size.height;
}
/**
 * 获取视图 最右边距屏幕左边的距离
 *
 *  @return 距离
 */
- (CGFloat)getMaxX {
    return CGRectGetMaxX(self.frame);
}
/**
 * 获取视图 最下边距屏幕左边的距离
 *
 *  @return 距离
 */
- (CGFloat)getMaxY {
    return CGRectGetMaxY(self.frame);
}
/**
 *  获取视图 中心点 X
 *
 *  @return center.x
 */
- (CGFloat)getMidX {
    return self.center.x;
}
/**
 *  获取视图 中心点 Y
 *
 *  @return center.y
 */
- (CGFloat)getMidY {
    return self.center.y;
}

#pragma mark -
#pragma mark - 关于设置圆角

/**
 *  切圆
 */
- (void)fillCorner {
    self.layer.cornerRadius = self.frame.size.width / 2.0;
    self.clipsToBounds = YES;
}
/**
 *  切指定圆角
 *
 *  @param radius 圆角半径
 */
- (void)cornerWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
/**
 *  设置边框
 *
 *  @param radius      半径
 *  @param borderWidth 边框宽度
 *  @param colorString 边框颜色 6位16进制字符串
 */
- (void)borderWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(NSString *)colorString {
    self.layer.borderColor = [self colorWithHexString:colorString].CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

#pragma mark -
#pragma mark - 关于画线

/**
 *  画线
 *
 *  @param top   居上
 *  @param left  居左
 *  @param right 居右
 */
- (void)lineFromTop:(float)top left:(float)left toRight:(float)right {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [self colorWithHexString:@"e5e5e5"].CGColor;
    layer.frame = CGRectMake(left, top, [self getWidth] - left - right, 0.5);
    [self.layer addSublayer:layer];
}
/**
 *  上部横线
 */
- (void)topLine {
    [self lineFromTop:0 left:0 toRight:0];
}
/**
 *  下部横线
 */
- (void)bottomLine {
    [self lineFromTop:[self getHeight] - 0.5  left:0 toRight:0];
}
- (void)shadowColorString:(NSString *)colorString opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    self.layer.shadowColor = [self colorWithHexString:colorString].CGColor; /// 阴影颜色
    self.layer.shadowOpacity = opacity; /// 阴影透明度
    self.layer.shadowRadius = radius; /// 阴影半径 默认 3
    self.layer.shadowOffset = offset; /// 向右 向下 偏移
}

#pragma mark
#pragma mark -- XIB

- (void)setFx_radius:(CGFloat)fx_radius {
    self.layer.cornerRadius = fx_radius;
    self.layer.masksToBounds = YES;
}
- (CGFloat)fx_radius {
    return self.layer.cornerRadius;
}
- (void)setFx_borderWidth:(CGFloat)fx_borderWidth {
    self.layer.borderWidth = fx_borderWidth;
}
- (CGFloat)fx_borderWidth {
    return self.layer.borderWidth;
}
- (void)setFx_borderColor:(UIColor *)fx_borderColor {
    self.layer.borderColor = fx_borderColor.CGColor;
    self.layer.masksToBounds = YES;
}
- (UIColor *)fx_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setFx_shadowRadius:(CGFloat)fx_shadowRadius {
    self.layer.shadowRadius = fx_shadowRadius;
}
- (CGFloat)fx_shadowRadius {
    return self.layer.shadowRadius;
}
- (void)setFx_shadowColor:(UIColor *)fx_shadowColor {
    self.layer.shadowColor = fx_shadowColor.CGColor;
}
- (UIColor *)fx_shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
- (void)setFx_shadowOffset:(CGSize)fx_shadowOffset {
    self.layer.shadowOffset = fx_shadowOffset;
}
- (CGSize)fx_shadowOffset {
    return self.layer.shadowOffset;
}
- (void)setFx_shadowOpacity:(CGFloat)fx_shadowOpacity {
    self.layer.shadowOpacity = fx_shadowOpacity;
}
- (CGFloat)fx_shadowOpacity {
    return self.layer.shadowOpacity;
}



@end

//
//  UIImage+Methods.h
//  Chengqu
//
//  Created by wangyang on 2018/4/26.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Methods)

#pragma mark - Image Effect

- (nullable UIImage *)hq_imageByTintColor:(UIColor *_Nullable)color;

- (nullable UIImage *)hq_imageByGrayscale;

- (nullable UIImage *)hq_imageByBlurSoft;

- (nullable UIImage *)hq_imageByBlurLight;

- (nullable UIImage *)hq_imageByBlurExtraLight;

- (nullable UIImage *)hq_imageByBlurDark;

- (nullable UIImage *)hq_imageByBlurWithTint:(UIColor *_Nullable)tintColor;

- (nullable UIImage *)hq_imageByBlurRadius:(CGFloat)blurRadius
                                 tintColor:(nullable UIColor *)tintColor
                                  tintMode:(CGBlendMode)tintBlendMode
                                saturation:(CGFloat)saturation
                                 maskImage:(nullable UIImage *)maskImage;

+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;

@end

//
//  UIImage+Compress.m
//  FXQL
//
//  Created by yons on 2018/11/2.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UIImage+Compress.h"

@implementation UIImage (Compress)

/*!
 *
 *  压缩图片至目标尺寸
 *
 *  @param targetWidth 图片最终尺寸的宽
 *
 *  @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 */
- (UIImage *)compressImageToTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = self.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    targetWidth = floor(targetWidth);
    targetHeight = floor(targetHeight);
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*!
 *
 *  压缩图片至目标尺寸
 *
 *  @param targetH 图片最终尺寸的高
 *
 *  @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 */
- (UIImage *)compressImageToTargetHeight:(CGFloat)targetH {
    CGSize imageSize = self.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetW = (targetH / height) * width;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetW, targetH));
    [self drawInRect:CGRectMake(0, 0, targetW, targetH)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)compressImageToTargetSize:(CGSize)targetSize {
    CGRect rect=CGRectMake(0,60,targetSize.width, targetSize.height);//创建要剪切的矩形框这里你可以自己修改
    UIImage *res = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([self CGImage],rect)];
    return res;
}

@end

//
//  UIImage+Compress.h
//  FXQL
//
//  Created by yons on 2018/11/2.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)

/*!
 *
 *  压缩图片至目标尺寸
 *
 *  @param targetWidth 图片最终尺寸的宽
 *
 *  @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 */
- (UIImage *)compressImageToTargetWidth:(CGFloat)targetWidth;
/*!
 *
 *  压缩图片至目标尺寸
 *
 *  @param targetH 图片最终尺寸的高
 *
 *  @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 */
- (UIImage *)compressImageToTargetHeight:(CGFloat)targetH;
- (UIImage *)compressImageToTargetSize:(CGSize)targetSize;

@end

//
//  YYImagePickerController.h
//  FXQL
//
//  Created by yons on 2018/10/30.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEnumeration.h"

@interface YYImagePickerController : UIImagePickerController

/**
 调取照相机
 
 @param viewController 视图控制器
 @param complete 确定
 */
+ (YYImagePickerController *)showPhotoAlbumInViewController:(UIViewController *)viewController complete:(void(^)(UIImage *image))complete;

/**
 弹出自定义相册 默认到所有照片中 (无视频)
 默认不裁剪
 @param count 选择数量
 */
+ (void)showImagesWithCount:(NSInteger)count complete:(void(^)(NSArray *result))complete;

/**
 弹出自定义相册 默认到所有视频中(无照片)
 
 @param complete complete
 */
+ (void)showVideosWithCount:(NSInteger)count complete:(void(^)(NSArray *result))complete;

/**
 弹出相册 （默认到第一个分组）
 
 @param count 选择数量
 @param mediaType mediaType description
 @param complete complete description
 */
+ (void)showAssetWithCount:(NSInteger)count
                 mediaType:(SelectMediaType)mediaType
                  isCamera:(BOOL)isCamera
                  complete:(void(^)(NSArray *result))complete;
@end

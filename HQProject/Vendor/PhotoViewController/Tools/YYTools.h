//
//  YYTools.h
//  YYImagePickerController
//
//  Created by wangyang on 2018/6/5.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEnumeration.h"

@interface YYTools : NSObject

/**
 调取照相机和摄像机 单张
 
 @param viewController 试图控制器
 @param sure 确定
 @param cancel 取消
 */
+ (void)showCameraInViewController:(UIViewController *)viewController cameraType:(CameraType)cameraType sure:(void(^)(id result))sure cancel:(void(^)(void))cancel dismiss:(void(^)(void))dismiss;
/**
 调取照相机 单张 方形切割
 
 @param viewController 试图控制器
 @param sure 确定
 @param cancel 取消
 */
+ (void)showCameraWithCropInViewController:(UIViewController *)viewController sure:(void(^)(id result))sure cancel:(void(^)(void))cancel dismiss:(void(^)(void))dismiss;
/**
 调取照相机
 
 @param viewController 视图控制器
 @param sure 确定
 @param cancel 取消
 */
+ (void)showPhotoCameraInViewController:(UIViewController *)viewController sure:(void(^)(UIImage *image))sure cancel:(void(^)(void))cancel dismiss:(void(^)(void))dismiss;

/**
 调取摄像机拍摄视频
 
 @param viewController 视图控制器
 @param sure 确定
 @param cancel 取消
 */
+ (void)showVideoCameraInViewController:(UIViewController *)viewController sure:(void(^)(NSURL *videoUrl))sure cancel:(void(^)(void))cancel dismiss:(void(^)(void))dismiss;

/**
 弹出相册 （默认到第一个分组）
 mediaType:
 0.AllMediaType   图片和视频
 1.OnlyPhotosType 图片
 2.OnlyVideosType 视频
 
 @param count 选择数量
 @param mediaType mediaType description
 @param isCropping 是否裁剪（mediaType = OnlyPhotoType 有效）
 @param isCamera 是否有拍照功能
 @param complete complete description
 */
+ (void)showAssetWithCount:(NSInteger)count
                 mediaType:(SelectMediaType)mediaType
                  isCamera:(BOOL)isCamera
                isCropping:(BOOL)isCropping
                  complete:(void(^)(NSArray *result))complete;

/**
 弹出自定义相册 默认到所有照片中 (无视频)
 默认不裁剪
 @param count 选择数量
 */
+ (void)showImagesWithCount:(NSInteger)count complete:(void(^)(NSArray *result))complete;

/**
 弹出自定义相册 默认到所有照片中 (无视频)
 @param count 选择数量
 @param isCropping 是否裁剪（count == 1有效）
 */
+ (void)showImagesWithCount:(NSInteger)count isCropping:(BOOL)isCropping complete:(void(^)(NSArray *result))complete;

/**
 弹出自定义相册 默认到所有视频中(无照片)
 
 @param complete complete
 */
+ (void)showVideosWithCount:(NSInteger)count complete:(void(^)(NSArray *result))complete;

/**
 弹出自定义相册 包含视频和图片
 
 @param count count description
 @param complete complete description
 */
+ (void)showAllAssetWithCount:(NSInteger)count complete:(void(^)(NSArray *result))complete;

@end

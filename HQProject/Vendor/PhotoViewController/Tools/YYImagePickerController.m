//
//  YYImagePickerController.m
//  FXQL
//
//  Created by yons on 2018/10/30.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "YYImagePickerController.h"
#import "YYGroupViewController.h"

@interface YYImagePickerController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (copy, nonatomic) void(^sureBlock)(UIImage *image);
@property (copy, nonatomic) void(^cropBlock)(UIImage *image);
@property (copy, nonatomic) void(^cancelBlock)(void);
@end

@implementation YYImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 调取照相机
 
 @param viewController 视图控制器
 @param complete 确定
 */
+ (YYImagePickerController *)showPhotoAlbumInViewController:(UIViewController *)viewController complete:(void(^)(UIImage *image))complete {
    YYImagePickerController *pickerController = [[YYImagePickerController alloc] init];
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
    switch (AVstatus) {
            case AVAuthorizationStatusAuthorized:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                pickerController.sureBlock = complete;
                pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickerController.mediaTypes = @[(NSString *)kUTTypeImage];
                pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;//设置相机后摄像头
                pickerController.allowsEditing = NO;//是否可编辑
                pickerController.delegate = pickerController;
                [viewController presentViewController:pickerController animated:YES completion:nil];
            }else {
                NSLog(@"该设备无摄像头");
            }
        }
            break;
            case AVAuthorizationStatusDenied:
        {
            //被拒绝 弹出提示
            [HQCommenMethods showAlertViewWithTitle:[NSString stringWithFormat:@"%@没有权限访问您的相机",APPNAME] message:[NSString stringWithFormat:@"请进入系统 设置 > 隐私 > 相机 允许“%@”访问您的相机",APPNAME] cancelButtonTitle:@"知道了" sureButtonTitle:nil cancelBlock:nil sureBlock:nil];
        }
            break;
            case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
                if (granted) {
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                        pickerController.sureBlock = complete;
                        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                        pickerController.mediaTypes = @[(NSString *)kUTTypeImage];
                        pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;//设置相机后摄像头
                        pickerController.allowsEditing = NO;//是否可编辑
                        pickerController.delegate = pickerController;
                        [viewController presentViewController:pickerController animated:YES completion:nil];
                    }else {
                        NSLog(@"该设备无摄像头");
                    }
                }else{
                    //被拒绝 弹出提示
                    [HQCommenMethods showAlertViewWithTitle:[NSString stringWithFormat:@"%@没有权限访问您的相机",APPNAME] message:[NSString stringWithFormat:@"请进入系统 设置 > 隐私 > 相机 允许“%@”访问您的相机",APPNAME] cancelButtonTitle:@"知道了" sureButtonTitle:nil cancelBlock:nil sureBlock:nil];
                }
            }];
        }
            break;
            case AVAuthorizationStatusRestricted:
            //受限制 例如家长模式
            break;
        default:
            break;
    }
    return pickerController;
}


#pragma mark -
#pragma mark - PRIVATE METHOD <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
        UIImage *image;
        //如果允许编辑则获得编辑后的照片，否则获取原始照片
        if (picker.allowsEditing) {
            image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
        }else{
            image=[info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相簿
        WeakSelf
        [picker dismissViewControllerAnimated:YES completion:^{
            if (weakSelf.sureBlock) {
                weakSelf.sureBlock(image);
            }
        }];
    }
}

/**
 弹出自定义相册 默认到所有照片中 (无视频)
 默认不裁剪
 @param count 选择数量
 */
+ (void)showImagesWithCount:(NSInteger)count complete:(void(^)(NSArray *result))complete {
    [self showAssetWithCount:count mediaType:OnlyPhotosType isCamera:YES complete:complete];
}

/**
 弹出自定义相册 默认到所有视频中(无照片)
 
 @param complete complete
 */
+ (void)showVideosWithCount:(NSInteger)count complete:(void(^)(NSArray *result))complete {
    [self showAssetWithCount:count mediaType:OnlyVideosType isCamera:NO complete:complete];
}

/**
 弹出自定义相册 包含视频和图片
 
 @param count count description
 @param complete complete description
 */
+ (void)showAllAssetWithCount:(NSInteger)count complete:(void(^)(NSArray *result))complete {
    [self showAssetWithCount:count mediaType:AllMediaType isCamera:NO complete:complete];
}

/**
 弹出相册 （默认到第一个分组）
 
 @param count 选择数量
 @param mediaType mediaType description
 @param complete complete description
 */
+ (void)showAssetWithCount:(NSInteger)count
                 mediaType:(SelectMediaType)mediaType
                  isCamera:(BOOL)isCamera
                  complete:(void(^)(NSArray *result))complete {
    YYGroupViewController *vc = [[YYGroupViewController alloc] init];
    vc.maxCount = count;
    vc.mediaType = mediaType;
    vc.isCamera = isCamera;
    vc.callBack = complete;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end

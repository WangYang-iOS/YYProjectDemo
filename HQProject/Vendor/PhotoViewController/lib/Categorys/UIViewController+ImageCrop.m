//
//  UIViewController+ImageCrop.m
//  FXQL
//
//  Created by yons on 2018/10/30.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UIViewController+ImageCrop.h"
static char CropRect;
static char CompleteS;

@implementation UIViewController (ImageCrop)
- (void)setCropRect:(CGRect)cropRect {
    objc_setAssociatedObject(self, &CropRect, NSStringFromCGRect(cropRect), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGRect)cropRect {
    return CGRectFromString(objc_getAssociatedObject(self, &CropRect));
}
- (void)setComplete:(Complete)complete {
    objc_setAssociatedObject(self, &CompleteS, complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (Complete)complete {
    return objc_getAssociatedObject(self, &CompleteS);
}

- (void)cropImage:(UIImage *)image cropSize:(CGSize)cropSize complete:(Complete)complete; {
    if (image) {
        self.complete =  complete;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        CGFloat x = (screenSize.width - cropSize.width) *0.5;
        CGFloat y = (screenSize.height - cropSize.height) * 0.5;
        self.cropRect = CGRectMake(x, y, cropSize.width, cropSize.height);
        
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeCustom];
        imageCropVC.avoidEmptySpaceAroundImage = YES;
        imageCropVC.delegate = self;
        imageCropVC.dataSource = self;
        imageCropVC.maskLayerColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        imageCropVC.maskLayerStrokeColor = [UIColor lightGrayColor];
        
        if (self.presentedViewController) {
            [self.presentedViewController dismissViewControllerAnimated:false completion:^{
                [self presentViewController:imageCropVC animated:true completion:nil];
            }];
        }else {
            [self presentViewController:imageCropVC animated:true completion:nil];
        }
    }
}

#pragma mark
#pragma mark -- RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect {
    __weak typeof(self) weakSelf = self;
    [controller dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.complete) {
            weakSelf.complete(croppedImage);
        }
    }];
}

#pragma mark
#pragma mark -- RSKImageCropViewControllerDataSource

- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller {
    return [UIScreen mainScreen].bounds;
}

- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.cropRect];
    return path;
}

- (CGRect)imageCropViewControllerCustomMovementRect:(RSKImageCropViewController *)controller {
    return self.cropRect;
}

@end

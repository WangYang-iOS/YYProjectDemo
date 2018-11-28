//
//  UIViewController+ImageCrop.h
//  FXQL
//
//  Created by yons on 2018/10/30.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSKImageCropViewController.h"

typedef void(^Complete)(UIImage *image);

@interface UIViewController (ImageCrop)<RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource>

@property(assign, nonatomic) CGRect cropRect;
@property(copy, nonatomic) Complete complete;

- (void)cropImage:(UIImage *)image cropSize:(CGSize)cropSize complete:(Complete)complete;

@end

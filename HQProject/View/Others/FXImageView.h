//
//  FXImageView.h
//  FXQL
//
//  Created by yons on 2018/11/2.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQUploadManager.h"

@interface FXImageView : UIImageView

@property(copy, nonatomic) NSString *imagePath;
@property(assign, nonatomic) BOOL isUploading;

- (void)uploadImage:(UIImage *)image type:(FXUploadImgType)type;

@end

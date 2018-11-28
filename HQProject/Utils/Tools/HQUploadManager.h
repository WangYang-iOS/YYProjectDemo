//
//  HQUploadManager.h
//  Chengqu
//
//  Created by wangyang on 2018/5/16.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    FXUploadAvatarType = 0,
    FXUploadCompanyType,
    FXUploadCircleType,
    FXUploadGroupType,
    FXUploadCerType,
} FXUploadImgType;// 0头像 1公司logo 2圈子图片 3群图片 4身份认证

typedef void (^UploadEngineBlock)(BOOL success, NSString *imgPath, NSString *key);
typedef void (^UploadProgressBlock)(CGFloat progress);

@interface HQUploadManager : NSObject

/**
 上传图片
 
 @param img img description
 @param keyStr keyStr description
 @param type type description
 @param progress progress description
 @param callback callback description
 
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)uploadImg:(UIImage *)img
              key:(NSString *)keyStr
             type:(FXUploadImgType)type
         progress:(UploadProgressBlock)progress
         callback:(UploadEngineBlock)callback;

@end

//
//  HQUploadManager.m
//  Chengqu
//
//  Created by wangyang on 2018/5/16.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "HQUploadManager.h"

@implementation HQUploadManager

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
                           callback:(UploadEngineBlock)callback {
    if (img.size.width > 1000) {
        img = [img compressImageToTargetWidth:1000];
    }
    NSData *imageData = nil;
    CGFloat qulity = 1.0;
    imageData = UIImageJPEGRepresentation(img, qulity);
    NSLog(@"imageData111- %lfKB", imageData.length/1024.0);

    if (type == FXUploadAvatarType) {
        if (imageData.length > 50*1000) {
            imageData = UIImageJPEGRepresentation(img, 0.8);
        }
    }
    if (imageData.length > 200*1024) {
        imageData = UIImageJPEGRepresentation(img, 0.5);
    }
    if (imageData.length > 200*1024*1024) {
        imageData = UIImageJPEGRepresentation(img, 0.01);
    }
    NSLog(@"imageData222- %lfKB", imageData.length/1024.0);

    NSData *postData = [imageData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *imgDataStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"%ld KB", postData.length/1024);
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:keyStr forKey:@"key"];
    [params setObject:imgDataStr forKey:@"serializedData"];
    [params setObject:@(type) forKey:@"type"];
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
    security.allowInvalidCertificates = YES;
    security.validatesDomainName = NO;
    sessionManager.securityPolicy = security;
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@", kDOMAIN, @"api/V1/Image/UploadImg"];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:params error:nil];
    [HQNetworkManager configuerdRequestHeader:request];
    
    NSURLSessionDataTask *task = [sessionManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress) {
                progress(uploadProgress.fractionCompleted);
            }
        });
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {} completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (callback) {
                    callback(NO,@"",@"");
                }
            }else {
                if (callback) {
                    callback(YES,responseObject[@"data"][@"url"],responseObject[@"data"][@"key"]);
                }
            }
        });
    }];
    [task resume];
    
    return task;
}

@end

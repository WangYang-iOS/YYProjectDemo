//
//  HQNetworkManager.h
//  Chengqu
//
//  Created by wangyang on 2018/3/19.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkBlock.h"

typedef void (^RequestEngineBlock)(BOOL success, ResponseMessage *responseMessage);
typedef void (^RequestEngineCheckIsSuccess)(BOOL success);

@interface HQNetworkManager : NSObject
/**
 检测请求是否请求成功
 
 @param responseMessage 返回请求参数
 @param success success
 */
+ (void)checkResponseMessage:(ResponseMessage *)responseMessage success:(RequestEngineCheckIsSuccess)success;

/**
 post请求
 
 @param dictionary 请求参数
 @param url        url
 @param block      回调
 */
+ (void)postRequestWithDitionary:(NSDictionary *)dictionary url:(NSString *)url block:(RequestEngineBlock)block;

/**
 get请求
 
 @param dictionary 请求参数
 @param url        url
 @param block      回调
 */
+ (void)getRequestWithDitionary:(NSDictionary *)dictionary url:(NSString *)url block:(RequestEngineBlock)block;

/**
 配置请求头
 
 @param request request description
 */
+ (void)configuerdRequestHeader:(NSMutableURLRequest *)request;

@end

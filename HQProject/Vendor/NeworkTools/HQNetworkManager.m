//
//  HQNetworkManager.m
//  Chengqu
//
//  Created by wangyang on 2018/3/19.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "HQNetworkManager.h"
#define TIMEOUTSETTING      30

@implementation HQNetworkManager

/**
 检测请求是否请求成功
 
 @param responseMessage 返回请求参数
 @param success success
 */
+ (void)checkResponseMessage:(ResponseMessage *)responseMessage success:(RequestEngineCheckIsSuccess)success {
    if (responseMessage.responseState == ResponseSuccessFinished) {
        ///  请求成功
        if ([responseMessage.retCode integerValue] == 0) {
            success(YES);
        }else {
            /// 请求成功并且返回错误的参数
            success(NO);
            NSLog(@"出错接口 == %@ 出错码 == %@",responseMessage.requestUrl, responseMessage.retCode);
        }
    }else if (responseMessage.responseState == ResponseFailureFinished) {
        ///  请求失败
        success(NO);
        NSLog(@"出错接口 == %@",responseMessage.requestUrl);
    }
}

/**
 post请求
 
 @param dictionary 请求参数
 @param url        url
 @param block      回调
 */
+ (void)postRequestWithDitionary:(NSDictionary *)dictionary url:(NSString *)url block:(RequestEngineBlock)block {
    RequestMessage *message = [RequestMessage messageWithMethod:POST url:url args:dictionary];
    [self doRequest:message callbackBlock:^(ResponseMessage *responseMessage) {
        [self checkResponseMessage:responseMessage success:^(BOOL success) {
            if (block) {
                block(success,responseMessage);
            }
        }];
    }];
}

/**
 get请求
 
 @param dictionary 请求参数
 @param url        url
 @param block      回调
 */
+ (void)getRequestWithDitionary:(NSDictionary *)dictionary url:(NSString *)url block:(RequestEngineBlock)block {
    RequestMessage *message = [RequestMessage messageWithMethod:GET url:url args:dictionary];
    message.isMultipart = YES;
    [self doRequest:message callbackBlock:^(ResponseMessage *responseMessage) {
        [self checkResponseMessage:responseMessage success:^(BOOL success) {
            if (block) {
                block(success,responseMessage);
            }
        }];
    }];
}

/**
 发送请求

 @param message message description
 @param callbackBlock callbackBlock description
 */
+ (void)doRequest:(RequestMessage *)message callbackBlock:(NetworkResponseCallback)callbackBlock {
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if (message.args) {
        [params setValuesForKeysWithDictionary:message.args];
    }
    NSString *URLString = [NSString stringWithFormat:@"%@%@", kDOMAIN, message.url];
    NSLog(@"请求的URL ==== %@\n请求的参数 ==== %@",URLString,params);
    
    NSString *method = @"POST";
    if (message.method == POST) {
        method = @"POST";
    }else {
        method = @"GET";
    }

    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
    security.allowInvalidCertificates = YES;
    security.validatesDomainName = NO;
    sessionManager.securityPolicy = security;
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:URLString parameters:params error:nil];
    [HQNetworkManager configuerdRequestHeader:request];

    NSURLSessionDataTask *task = [sessionManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {} downloadProgress:^(NSProgress * _Nonnull downloadProgress) {} completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [HQNetworkManager proccessResponse:message response:response responseObject:responseObject error:error callbackBlock:callbackBlock];
    }];

    [task resume];
}

/**
 处理数据

 @param message message description
 @param response operation response
 @param responseObject responseObject description
 @param error error description
 @param callbackBlock callbackBlock description
 */
+ (void)proccessResponse:(RequestMessage *)message
               response:(NSURLResponse *)response
          responseObject:(id)responseObject
                   error:(NSError *)error
           callbackBlock:(NetworkResponseCallback)callbackBlock {
    ResponseMessage *responseMessage = [[ResponseMessage alloc] initWithRequestUrl:message.url requestArgs:message.args];
    responseMessage.responseString = [NSString stringWithFormat:@"%@",response];
    if (error) {
        NSLog(@"请求出错:%@ + responseString : %@",error.userInfo,response);
        responseMessage.responseState = ResponseFailureFinished;
        if (!responseMessage.errorMessage.length) {
//            responseMessage.errorMessage = @"网络错误";
        }
    }else {
        responseMessage.responseState = ResponseSuccessFinished;
        if (responseObject && [responseObject isKindOfClass:NSDictionary.class]) {
            NSLog(@"%@请求成功！responseObject : %@",message.url,responseObject);
            responseMessage.responseObject = responseObject;
            responseMessage.retCode = responseObject[@"code"];
            responseMessage.bussinessData = responseObject[@"data"];
            responseMessage.errorMessage = responseObject[@"msg"];
            responseMessage.pageNum = responseObject [@"page"];
            responseMessage.totalPage = responseObject [@"page_size"];
        }
    }
    if (callbackBlock) {
        callbackBlock(responseMessage);
    }
}

/**
 配置请求头

 @param request request description
 */
+ (void)configuerdRequestHeader:(NSMutableURLRequest *)request {
    request.timeoutInterval = TIMEOUTSETTING;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:[FXUser shareUser].uuid forHTTPHeaderField:@"uuid"];
    [request setValue:APPVERSION forHTTPHeaderField:@"version"];
    [request setValue:@"1" forHTTPHeaderField:@"device_type"]; // 1 IOS  2 Android
    [request setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"sysVersion"];//手机系统版本
    [request setValue:[NSString stringWithFormat:@"%lf", [NSDate date].timeIntervalSince1970] forHTTPHeaderField:@"ts"];
//    [request setValue:[FXUser shareUser].token forHTTPHeaderField:@"token"];
    
//    [request setValue:[Commen getDeviceId:[CQUser shareCQUser].phoneStr] forHTTPHeaderField:@"device_code"];
//    [request setValue:[CQUser shareCQUser].phoneModel forHTTPHeaderField:@"deviceName"];//手机型号
//    [request setValue:[CQUser shareCQUser].memberId forHTTPHeaderField:@"uid"];
//    [request setValue:[CQUser shareCQUser].netStatusText forHTTPHeaderField:@"netType"];
//    [request setValue:[CQUser shareCQUser].gps forHTTPHeaderField:@"gps"];
}

@end

//
//  ResponseMessage.h
//  Chengqu
//
//  Created by WY的七色花 on 2018/4/3.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ResponseNotFinish,
    ResponseSuccessFinished,
    ResponseFailureFinished
} ResponseState;

@interface ResponseMessage : NSObject

@property(strong, nonatomic) NSString *requestUrl;//请求的url,返回方便调试
@property(strong, nonatomic) NSDictionary *requestArgs;//请求时的参数,返回方便调试
@property(strong, nonatomic) NSString *responseString;//返回的原始字符串
@property(assign, nonatomic) NSInteger statusCode;//请求响应状态
@property(assign, nonatomic) ResponseState responseState;//请求响应状态
@property(strong, nonatomic) id responseObject;//返回处理后的对象，一般为json格式

@property(strong, nonatomic) NSString *retCode;//服务端返回的状态码，0表示成功，其他为失败
@property(strong, nonatomic) NSString *errorMessage;//服务端处理失败时，返回的错误消息
@property(strong, nonatomic) id bussinessData;//在处理成功时服务端返回的的业务数据对象，根据接口的定义确定具体的类型
@property (copy, nonatomic) NSString *pageNum;
@property (copy, nonatomic) NSString *pageSize;
@property (copy, nonatomic) NSString *totalPage;

- (instancetype)initWithRequestUrl:(NSString *)requestUrl requestArgs:(NSDictionary *)requestArgs;

@end

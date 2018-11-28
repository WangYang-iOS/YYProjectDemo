//
//  RequestMessage.h
//  Chengqu
//
//  Created by WY的七色花 on 2018/4/3.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    POST,
    GET
} HttpMethod;

@interface RequestMessage : NSObject

@property(strong, nonatomic) NSString *url;//请求的url
@property(assign, nonatomic) HttpMethod method;//请求method,默认post
@property(strong, nonatomic) NSDictionary *args;//请求时的参数
@property(assign, nonatomic) BOOL isMultipart;//是否是上传请求

- (id)initWithUrl:(NSString *)url args:(NSDictionary *)args;

- (id)initWithUrl:(NSString *)url method:(HttpMethod)method args:(NSDictionary *)args;

- (id)initMutipartRequestWithUrl:(NSString *)url args:(NSDictionary *)args;

+ (RequestMessage *)messageWithMethod:(HttpMethod)method url:(NSString *)url args:(NSDictionary *)args;

@end

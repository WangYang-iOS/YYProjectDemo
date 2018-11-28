//
//  RequestMessage.m
//  Chengqu
//
//  Created by WY的七色花 on 2018/4/3.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "RequestMessage.h"

@implementation RequestMessage

- (instancetype)init {
    self = [super init];
    if (self) {
        //do something
    }
    return self;
}

- (instancetype)initWithUrl:(NSString *)url args:(NSDictionary *)args {
    self = [super init];
    if (self) {
        _url = url;
        _args = args;
    }
    return self;
}

- (instancetype)initWithUrl:(NSString *)url
                     method:(HttpMethod)method
                       args:(NSDictionary *)args {
    self = [self initWithUrl:url args:args];
    _method = method;
    return self;
}

- (instancetype)initMutipartRequestWithUrl:(NSString *)url args:(NSDictionary *)args {
    self = [self initWithUrl:url args:args];
    _method = POST;
    _isMultipart = YES;
    return self;
}

+ (RequestMessage *)messageWithMethod:(HttpMethod)method
                                  url:(NSString *)url
                                 args:(NSDictionary *)args {
    RequestMessage *message = [[RequestMessage alloc] initWithUrl:url method:method args:args];
    return message;
}

@end

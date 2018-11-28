//
//  ResponseMessage.m
//  Chengqu
//
//  Created by WY的七色花 on 2018/4/3.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "ResponseMessage.h"

@implementation ResponseMessage

- (instancetype)init {
    self = [super init];
    if (self) {
        _responseState = ResponseNotFinish;
    }
    return self;
}

- (instancetype)initWithRequestUrl:(NSString *)requestUrl requestArgs:(NSDictionary *)requestArgs {
    self = [super init];
    if (self) {
        _requestUrl = requestUrl;
        _requestArgs = requestArgs;
        _responseState = ResponseNotFinish;
    }
    return self;
}

@end

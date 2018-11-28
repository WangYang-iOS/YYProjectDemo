//
//  NetworkBlock.h
//  Chengqu
//
//  Created by WY的七色花 on 2018/4/3.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#ifndef NetworkBlock_h
#define NetworkBlock_h

#import "ResponseMessage.h"
#import "RequestMessage.h"
#import "HQNetworkManager.h"

typedef void (^NetworkResponseCallback)(ResponseMessage *responseMessage);

typedef void (^NetworkProgressCallback)(long long bytesWritten,long long totalBytesWritten,long long totalBytesExpectedToWrite);

typedef void (^NetworkSingleProgressCallback)(CGFloat progress);


#endif /* NetworkBlock_h */

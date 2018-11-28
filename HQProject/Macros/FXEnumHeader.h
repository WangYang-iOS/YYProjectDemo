//
//  FXEnumHeader.h
//  FXQL
//
//  Created by yons on 2018/11/7.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#ifndef FXEnumHeader_h
#define FXEnumHeader_h


typedef void(^FXConfiguerdCellBlock)(id cell, id obj);

typedef enum : NSUInteger {
    FXNetworkErrorType,
    FXNoHistoryType,
    FXNoDataType,
    FXNoMessageType,
    FXNoSearchContentType,
} FXEmptyPageType;//空页面

#endif /* FXEnumHeader_h */

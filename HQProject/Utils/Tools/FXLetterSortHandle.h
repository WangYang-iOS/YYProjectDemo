//
//  FXLetterSortHandle.h
//  FXQL
//
//  Created by yons on 2018/10/25.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXLetterSortHandle : NSObject

+ (void)getLetterSortDic:(NSArray *)letterArray handleComplete:(void(^)(NSDictionary *dic, NSArray *keysArray))handleComplete;

@end

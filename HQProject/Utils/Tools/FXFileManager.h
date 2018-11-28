//
//  FXFileManager.h
//  FXQL
//
//  Created by yons on 2018/11/5.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXFileManager : NSObject

+ (id)getCustomModels:(NSString *)key;
+ (void)saveCustomModels:(id)data key:(NSString *)key;
+ (void)deleteCustomModels:(NSString *)key;
@end

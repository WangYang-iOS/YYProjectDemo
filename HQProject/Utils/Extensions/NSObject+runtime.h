//
//  NSObject+runtime.h
//  Chengqu
//
//  Created by wangyang on 2018/3/29.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (runtime)

/**
 获取对象所有属性

 @return return value description
 */
- (NSArray *)getAllProperties;

/**
 获取对象所有方法

 @return return value description
 */
- (NSArray *)getAllMethods;

/**
 获取对象的所有属性和属性内容

 @param obj obj description
 @return return value description
 */
+ (NSDictionary *)getAllPropertiesAndVaules:(NSObject *)obj;

@end

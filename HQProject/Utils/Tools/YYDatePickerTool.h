//
//  YYDatePickerTool.h
//  KeLeiDeng
//
//  Created by wangyang on 2018/2/1.
//  Copyright © 2018年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYDatePickerTool : NSObject

/**
 当前年份
 
 @return return value description
 */
+ (NSInteger)currentYear;
/**
 当前月份
 
 @return return value description
 */
+ (NSInteger)currentMonth;
/**
 当前日
 
 @return return value description
 */
+ (NSInteger)currentDay;

/**
 获取从1970到当前时间的年
 
 @return return value description
 */
+ (NSMutableArray *)years;
/**
 获取每年月份（截止当前时间）
 
 @return return value description
 */
+ (NSMutableArray *)months:(NSInteger)year;
/**
 根据年月获取天数数组(截止当前时间)
 
 @param year 年
 @param month 月
 @return 获取当月天数
 */
+ (NSMutableArray *)dayStopNowWithYear:(NSInteger)year month:(NSInteger)month;
/**
 根据年月获取天数数组
 
 @param year 年
 @param month 月
 @return 获取当月天数
 */
+ (NSMutableArray *)dayWithYear:(NSInteger)year month:(NSInteger)month;
@end

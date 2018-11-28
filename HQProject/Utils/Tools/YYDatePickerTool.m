//
//  YYDatePickerTool.m
//  KeLeiDeng
//
//  Created by wangyang on 2018/2/1.
//  Copyright © 2018年 DemoKing. All rights reserved.
//

#import "YYDatePickerTool.h"

@implementation YYDatePickerTool

/**
 date 转 固定格式时间
 
 @param date date
 @param formatter 格式
 @return 字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date
                   formatter:(NSString *)formatter {
    if (!formatter) {
        return nil;
    }
    if (!date) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
/**
 当前年份
 
 @return return value description
 */
+ (NSInteger)currentYear {
    NSDate *date = [NSDate date];
    return [[YYDatePickerTool stringWithDate:date formatter:@"yyyy"] integerValue];
}
/**
 当前月份

 @return return value description
 */
+ (NSInteger)currentMonth {
    NSDate *date = [NSDate date];
    return [[YYDatePickerTool stringWithDate:date formatter:@"MM"] integerValue];
}
/**
 当前日
 
 @return return value description
 */
+ (NSInteger)currentDay {
    NSDate *date = [NSDate date];
    return [[YYDatePickerTool stringWithDate:date formatter:@"dd"] integerValue];
}
/**
 获取从1970到当前时间的年

 @return return value description
 */
+ (NSMutableArray *)years {
    NSMutableArray *yearArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 1949; i < [YYDatePickerTool currentYear] + 1; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    return (NSMutableArray *)[[yearArray reverseObjectEnumerator] allObjects];
}

/**
 获取每年月份（截止当前时间）
 
 @return return value description
 */
+ (NSMutableArray *)months:(NSInteger)year {
    NSMutableArray *yearArray = [NSMutableArray arrayWithCapacity:0];
    if ([YYDatePickerTool currentYear] == year) {
        for (int i = 1; i < [YYDatePickerTool currentMonth] + 1; i++) {
            [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }else {
        for (int i = 1; i < 13; i++) {
            [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return yearArray;
}


/**
 根据年月获取天数数组
 
 @param year 年
 @param month 月
 @return 获取当月天数
 */
+ (NSMutableArray *)dayWithYear:(NSInteger)year month:(NSInteger)month {
    NSInteger days = 0;
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12)) {
        days = 31;
    }else if((month == 4) || (month == 6) || (month == 9) || (month == 11)) {
        days = 30;
    }else {
        days = 28;
    }
    if(year % 4 == 0) {
        days = 29;
    }
    if(year % 400 == 0) {
        days = 29;
    }
    if(year % 100 == 0) {
        days = 28;
    }
    NSMutableArray *dayArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < days; i++) {
        NSString *string = [NSString stringWithFormat:@"%d",i + 1];
        [dayArray addObject:string];
    }
    return dayArray;
}

/**
 根据年月获取天数数组(截止当前时间)
 
 @param year 年
 @param month 月
 @return 获取当月天数
 */
+ (NSMutableArray *)dayStopNowWithYear:(NSInteger)year month:(NSInteger)month {
    NSInteger days = 0;
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12)) {
        days = 31;
    }else if((month == 4) || (month == 6) || (month == 9) || (month == 11)) {
        days = 30;
    }else {
        days = 28;
    }
    if(year % 4 == 0) {
        days = 29;
    }
    if(year % 400 == 0) {
        days = 29;
    }
    if(year % 100 == 0) {
        days = 28;
    }
    NSMutableArray *dayArray = [NSMutableArray arrayWithCapacity:0];
    if (year == [YYDatePickerTool currentYear] && month == [YYDatePickerTool currentMonth]) {
        if ([YYDatePickerTool currentDay] < days) {
            days = [YYDatePickerTool currentDay];
        }
    }
    for (int i = 0; i < days; i++) {
        NSString *string = [NSString stringWithFormat:@"%d",i + 1];
        [dayArray addObject:string];
    }
    return dayArray;
}

@end

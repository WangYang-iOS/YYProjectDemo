//
//  FXDatePickerView.h
//  FXQL
//
//  Created by yons on 2018/11/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXDatePickerView : UIView
@property(strong, nonatomic) UIPickerView *pickerView;
@property(copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger lastYear;
@property (assign, nonatomic) NSInteger lastMonth;
@property (assign, nonatomic) NSInteger lastDay;

+ (FXDatePickerView *)showPickerViewWithTime:(NSString *)time complete:(void(^)(NSString *title))complete;
@end

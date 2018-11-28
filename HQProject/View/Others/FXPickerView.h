//
//  FXPickerView.h
//  FXQL
//
//  Created by yons on 2018/10/22.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXPickerView : UIView
@property(strong, nonatomic) UIPickerView *pickerView;
@property(strong, nonatomic) NSArray *dataArray;
@property(copy, nonatomic) NSString *title;

+ (FXPickerView *)showPickerView:(NSArray *)dataArray title:(NSString *)title selectedIndex:(NSInteger)selectedIndex complete:(void(^)(NSString *title))complete;

@end

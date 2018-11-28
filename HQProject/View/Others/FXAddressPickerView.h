//
//  FXAddressPickerView.h
//  FXQL
//
//  Created by yons on 2018/11/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXAddressPickerView : UIView
@property(strong, nonatomic) UIPickerView *pickerView;
@property(copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger lastArea;
@property (assign, nonatomic) NSInteger lastCity;

+ (FXAddressPickerView *)showAddressPickerViewComplete:(void(^)(NSString *area, NSString *code))complete;
@end

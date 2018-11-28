//
//  FXShareView.h
//  FXQL
//
//  Created by yons on 2018/11/20.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXShareView : UIView
@property(strong, nonatomic) UIPickerView *pickerView;
+ (void)showShareView:(void(^)(NSInteger index))callback;
@end

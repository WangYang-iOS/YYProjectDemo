//
//  UILabel+Shortcut.h
//  FXQL
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Shortcut)

+ (UILabel *)labelWithFont:(UIFont *)font textColor:(NSString *)textColor;
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(NSString *)textColor textAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(NSString *)textColor textAlignment:(NSTextAlignment)textAlignment;
@end

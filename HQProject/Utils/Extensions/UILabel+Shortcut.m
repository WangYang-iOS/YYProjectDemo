//
//  UILabel+Shortcut.m
//  FXQL
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UILabel+Shortcut.h"

@implementation UILabel (Shortcut)

+ (UILabel *)labelWithFont:(UIFont *)font textColor:(NSString *)textColor {
    return [UILabel labelWithFont:font textColor:textColor textAlignment:NSTextAlignmentLeft];
}
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(NSString *)textColor textAlignment:(NSTextAlignment)textAlignment {
    return [UILabel labelWithText:nil font:font textColor:textColor textAlignment:textAlignment];
}
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(NSString *)textColor textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = [UIColor colorWithHexString:textColor];
    label.textAlignment = textAlignment;
    label.text = text;
    return label;
}
@end

//
//  UIButton+Shortcut.m
//  FXQL
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UIButton+Shortcut.h"

@implementation UIButton (Shortcut)
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(NSString *)titleColor font:(UIFont *)font {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:titleColor] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}
+ (UIButton *)buttonWithImage:(NSString *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:IMAGE(image) forState:UIControlStateNormal];
    return button;
}
@end

//
//  UIButton+Shortcut.h
//  FXQL
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Shortcut)

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(NSString *)titleColor font:(UIFont *)font;
+ (UIButton *)buttonWithImage:(NSString *)image;

@end

//
//  UIViewController+Nav.m
//  Chengqu
//
//  Created by wangyang on 2018/3/20.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UIViewController+Nav.h"
#define button_font  15
@implementation UIViewController (Nav)

/**
 去除导航栏下面那条黑线
 */
- (void)removeNavigationBarDownline {
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBarColor:(NSString *)color alpha:(CGFloat)alpha {
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:color alpha:alpha] rect:RECT(0, 0, SCREENW, NAVIH)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)showNavigationBarDownline {
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)backButton:(NSString *)img {
    if (img.length == 0) {
        self.navigationItem.leftBarButtonItem = nil;
        return;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = RECT(0, 0, 30, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, - 19, 0, 0);
    [button setImage:IMAGE(img) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)leftBarButtonWithImage:(NSString *)image {
    if (image.length == 0) {
        self.navigationItem.leftBarButtonItem = nil;
        return;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = RECT(0, 0, 30, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, - 19, 0, 0);
    [button setImage:IMAGE(image) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBarButtonWithTitle:(NSString *)title {
    if (title.length == 0) {
        self.navigationItem.rightBarButtonItem = nil;
        return;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = [title widthWithFont:MediumFont(button_font)];
    button.frame = RECT(0, 0, width, 44);
    button.titleLabel.font = MediumFont(button_font);
    [button setTitleColor:color_title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)clickBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightButton {
    
}

- (void)clickLeftButton {
    
}
@end

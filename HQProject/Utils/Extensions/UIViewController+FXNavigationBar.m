//
//  UIViewController+FXNavigationBar.m
//  FXQL
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UIViewController+FXNavigationBar.h"

@implementation UIViewController (FXNavigationBar)

- (FXNavigationBar *)fx_navigationBar {
    FXNavigationBar *fx_navigationBar = objc_getAssociatedObject(self, _cmd);
    if (!fx_navigationBar) {
        fx_navigationBar = [[FXNavigationBar alloc] init];
        objc_setAssociatedObject(self, @selector(fx_navigationBar), fx_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.view addSubview:fx_navigationBar];
    }
    return fx_navigationBar;
}

- (void)setFx_navigationBar:(FXNavigationBar *)fx_navigationBar {
    objc_setAssociatedObject(self, @selector(fx_navigationBar), fx_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

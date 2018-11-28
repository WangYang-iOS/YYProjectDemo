//
//  FXNavigationController.m
//  FXQL
//
//  Created by wangyang on 2018/10/11.
//  Copyright © 2018 HangzhouHaiqu. All rights reserved.
//

#import "FXNavigationController.h"
#import "FXBaseVC.h"

@interface FXNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation FXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    self.delegate = self;
    if (self.interactivePopGestureRecognizer.delegate == nil) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.interactivePopGestureRecognizer.enabled = [self.viewControllers count] > 1 ;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
//        if (self.viewControllers.count < 2) {
//            return NO;
//        }
//    }
//    return YES;
//}

@end

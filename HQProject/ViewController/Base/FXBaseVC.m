//
//  FXBaseVC.m
//  FXQL
//
//  Created by wangyang on 2018/8/18.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXBaseVC.h"

@interface FXBaseVC ()<UIGestureRecognizerDelegate>

@end

@implementation FXBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self layoutNavigationBar];
    [self initBindingViewModel];
    [self keyBorderEnable:YES];
}

#pragma mark -
#pragma mark - pravate methods

- (void)setFx_fullScreenPopGestureEnabled:(BOOL)fx_fullScreenPopGestureEnabled {
    _fx_fullScreenPopGestureEnabled = fx_fullScreenPopGestureEnabled;
    self.navigationController.interactivePopGestureRecognizer.delegate = fx_fullScreenPopGestureEnabled ? self : nil;
    self.navigationController.interactivePopGestureRecognizer.enabled = fx_fullScreenPopGestureEnabled;
}

- (void)initBindingViewModel {
    
}

- (void)loadPageData {
    
}

- (void)layoutNavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.fx_navigationBar.backgroundColor = [UIColor whiteColor];
    @weakify(self)
    [[self.fx_navigationBar.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)presentLoginVC:(void (^)(void))completion {
//    FXTabBarController *tabbar = (FXTabBarController *)self.tabBarController;
//    FXNavigationController *nav = (FXNavigationController *)self.navigationController;
//    [self presentViewController:[[FXNavigationController alloc] initWithRootViewController:[FXLoginVC new]] animated:YES completion:^{
//        [nav popToRootViewControllerAnimated:YES];
//        tabbar.selectedIndex = 0;
//        if (completion) {
//            completion();
//        }
//    }];
}

- (void)showEmptyViewWithFrame:(CGRect)frame emptyType:(FXEmptyPageType)emptyType {
    [self.emptyView layoutEmptyViewFrame:frame emptyType:emptyType];
    self.emptyView.hidden = NO;
}

#pragma mark
#pragma mark -- System Methods

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"内存溢出");
}

- (void)dealloc {
    NSLog(@"%@已经释放",NSStringFromClass([self class]));
}

#pragma mark
#pragma mark -- lazy

- (FXEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[FXEmptyView alloc] init];
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}

@end

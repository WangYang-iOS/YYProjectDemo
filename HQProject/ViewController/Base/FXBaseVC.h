//
//  FXBaseVC.h
//  FXQL
//
//  Created by wangyang on 2018/8/18.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXBaseVC : UIViewController

@property(strong, nonatomic) FXEmptyView *emptyView;
@property(assign, nonatomic) NSInteger page;
@property(assign, nonatomic) BOOL isOpened;//是否是第一次打开vc 点击tabbar再加载数据 

@property (nonatomic, assign) BOOL fx_fullScreenPopGestureEnabled;

- (void)layoutNavigationBar;
- (void)initBindingViewModel;
- (void)loadPageData;
- (void)presentLoginVC:(void (^)(void))completion;

- (void)showEmptyViewWithFrame:(CGRect)frame emptyType:(FXEmptyPageType)emptyType;

@end

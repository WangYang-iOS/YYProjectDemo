//
//  FXTabBarController.m
//  FXQL
//
//  Created by yons on 2018/10/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXTabBarController.h"
#import "FXBaseVC.h"
#import "FXNavigationController.h"

@interface FXTabBarController ()<UITabBarControllerDelegate>

@end

@implementation FXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self layoutTabBarVC];
}

#pragma mark
#pragma mark -- arguments

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    FXNavigationController *nav = (FXNavigationController *)viewController;
    FXBaseVC *vc = (FXBaseVC *)(nav.viewControllers.firstObject);
    if ([vc isKindOfClass:[FXBaseVC class]]) {
        //如果isOpened=NO 代表第一次点击 需要加载数据
        if (!vc.isOpened) {
            if (self.lastIndex != self.selectedIndex) {
                [vc loadPageData];
                vc.isOpened = YES;
            }
        }
    }
    self.lastIndex = self.selectedIndex;
}

#pragma mark
#pragma mark -- layout

- (void)layoutTabBarVC {
    NSMutableArray *norImgs = [NSMutableArray array];
    NSMutableArray *selImgs = [NSMutableArray array];
    for (int i = 1; i < 6; i++) {
        UIImage *normalImage = [[UIImage imageNamed:[NSString stringWithFormat:@"ic_tabbar_%d",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [norImgs addObject:normalImage];
    }
    for (int i = 1; i < 6; i++) {
        UIImage *selectImage = [[UIImage imageNamed:[NSString stringWithFormat:@"ic_tabbar_select_%d",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [selImgs addObject:selectImage];
    }
    NSArray *normalIcons = norImgs;
    NSArray *selectIcons = selImgs;
    
    NSArray *titles = @[@"首页",@"需求",@"圈子",@"消息",@"我的"];
    NSArray *vcs = @[@"FXHomePageVC",@"FXDemandConnectionVC",@"FXCircleVC",@"FXMessageListVC",@"FXMineVC"];
    NSMutableArray *navs = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < titles.count; i++) {
        UINavigationController *nav = [self getNavWithViewController:vcs[i] normalIcon:normalIcons[i] selectIcon:selectIcons[i] title:titles[i]];
        [navs addObject:nav];
    }
    self.viewControllers = navs;
    self.tabBar.barTintColor = VIEWRGB;
}

- (UINavigationController *)getNavWithViewController:(NSString *)viewController
                                          normalIcon:(UIImage *)normalIcon
                                          selectIcon:(UIImage *)selectIcon
                                               title:(NSString *)title {
    CGFloat pianYi = -3;//负值向上
    UIViewController *vc = [[NSClassFromString(viewController) alloc] init];
    vc.fx_navigationBar.hiddenLeftButton = YES;
    UITabBarItem *vcItem = [[UITabBarItem alloc] initWithTitle:title image:normalIcon selectedImage:selectIcon];
    [vcItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MAINRGB} forState:UIControlStateSelected];
    [vcItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#B9BDC4"]} forState:UIControlStateNormal];
    vc.tabBarItem = vcItem;
    FXNavigationController *nav = [[FXNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, pianYi);
    return nav;
}

/**
 *  用 block 重写某个 class 的指定方法
 *  @param targetClass 要重写的 class
 *  @param targetSelector 要重写的 class 里的实例方法，注意如果该方法不存在于 targetClass 里，则什么都不做
 *  @param implementationBlock 该 block 必须返回一个 block，返回的 block 将被当成 targetSelector 的新实现，所以要在内部自己处理对 super 的调用，以及对当前调用方法的 self 的 class 的保护判断（因为如果 targetClass 的 targetSelector 是继承自父类的，targetClass 内部并没有重写这个方法，则我们这个函数最终重写的其实是父类的 targetSelector，所以会产生预期之外的 class 的影响，例如 targetClass 传进来  UIButton.class，则最终可能会影响到 UIView.class），implementationBlock 的参数里第一个为你要修改的 class，也即等同于 targetClass，第二个参数为你要修改的 selector，也即等同于 targetSelector，第三个参数是 targetSelector 原本的实现，由于 IMP 可以直接当成 C 函数调用，所以可利用它来实现“调用 super”的效果，但由于 targetSelector 的参数个数、参数类型、返回值类型，都会影响 IMP 的调用写法，所以这个调用只能由业务自己写。
 */
CG_INLINE BOOL
OverrideImplementation(Class targetClass, SEL targetSelector, id (^implementationBlock)(Class originClass, SEL originCMD, IMP originIMP)) {
    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
    if (!originMethod) {
        return NO;
    }
    IMP originIMP = method_getImplementation(originMethod);
    method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originIMP)));
    return YES;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 12.1, *)) {
            OverrideImplementation(NSClassFromString(@"UITabBarButton"), @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP originIMP) {
                return ^(UIView *selfObject, CGRect firstArgv) {
                    if ([selfObject isKindOfClass:originClass]) {
                        // 如果发现即将要设置一个 size 为空的 frame，则屏蔽掉本次设置
                        if (!CGRectIsEmpty(selfObject.frame) && CGRectIsEmpty(firstArgv)) {
                            return;
                        }
                    }
                    // call super
                    void (*originSelectorIMP)(id, SEL, CGRect);
                    originSelectorIMP = (void (*)(id, SEL, CGRect))originIMP;
                    originSelectorIMP(selfObject, originCMD, firstArgv);
                };
            });
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

//
//  AppDelegate.h
//  HQProject
//
//  Created by yons on 2018/11/28.
//  Copyright © 2018年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, weak) id payDelegate;
@property(nonatomic, assign) NSInteger connectCount;//重连s次数

@end


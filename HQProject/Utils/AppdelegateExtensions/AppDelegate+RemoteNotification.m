//
//  AppDelegate+RemoteNotification.m
//  FXQL
//
//  Created by yons on 2018/11/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "AppDelegate+RemoteNotification.h"

@implementation AppDelegate (RemoteNotification)

- (void)registerRemoteNotificationWithOptions:(NSDictionary *)launchOptions {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound |UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        /// ios7注册推送通知
        //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
        //         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
   
    NSDictionary *remoteNotificationUserInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotificationUserInfo) {
        
    }
}

#pragma mark --
#pragma mark -- Notifications 通知

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--->>>>  启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    NSLog(@"收到消息");
}

#pragma mark - 用户通知(推送)回调 _IOS 8.0以上使用
/** 已登记用户通知 */
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // 注册远程通知（推送）
    [application registerForRemoteNotifications];
}

#pragma mark - 远程通知(推送)回调
/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[[[deviceToken description]
                         stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""]  stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    NSLog(@"token == %@",token);
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"注册推送失败|||||||");
    NSLog(@"error -- %@",error);
}

#pragma mark - APP运行中接收到通知(推送)处理 (前台和后台)
/** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台) */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    application.applicationIconBadgeNumber = [userInfo[@"aps"][@"badge"] integerValue];;
    NSLog(@"userInfo == %@",userInfo);
    NSDictionary *appData = userInfo[@"appData"];
    if (userInfo && !([application applicationState] == UIApplicationStateActive)) {
        if (appData == nil) {
            FXTabBarController *tabbarVC = (FXTabBarController *)self.window.rootViewController;
            tabbarVC.selectedIndex = 3;
        }else {
            //系统推送
        }
    }else {
        
    }
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo && !([application applicationState] == UIApplicationStateActive)) {
        FXTabBarController *tabbarVC = (FXTabBarController *)self.window.rootViewController;
        tabbarVC.selectedIndex = 3;
    }else {
        
    }
}

@end

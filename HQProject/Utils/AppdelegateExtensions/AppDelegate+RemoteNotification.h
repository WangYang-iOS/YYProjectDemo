//
//  AppDelegate+RemoteNotification.h
//  FXQL
//
//  Created by yons on 2018/11/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (RemoteNotification)<UNUserNotificationCenterDelegate>

- (void)registerRemoteNotificationWithOptions:(NSDictionary *)launchOptions;

@end

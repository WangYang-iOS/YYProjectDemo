//
//  AppDelegate+Reachability.m
//  Chengqu
//
//  Created by wangyang on 2018/3/19.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "AppDelegate+Reachability.h"

@implementation AppDelegate (Reachability)

- (void)reachability {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                [HQCommenMethods showAlertViewWithTitle:@"当前无网络，前往设置" message:nil cancelButtonTitle:@"忽略" sureButtonTitle:@"切换" cancelBlock:^{} sureBlock:^{
                    //前往设置界面
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                break;
            default:
                break;
        }
    }];
}

@end

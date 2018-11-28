//
//  CQJSWebViewSupVC.h
//  Chengqu
//
//  Created by wangyang on 2017/8/29.
//  Copyright © 2017年 HangzhouHaiqu. All rights reserved.
//

#import "FXBaseVC.h"
#import <WebKit/WebKit.h>

typedef void(^H5ActionHandler)(NSString *methodName, NSDictionary *backDic, WVJBResponseCallback callback);

@interface CQJSWebViewSupVC : FXBaseVC
@property  (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) WKWebView *wkWeb;

- (WKWebView *)loadWebUrl:(NSString *)url frame:(CGRect)rect;
- (void)doH5ActionHandler:(H5ActionHandler)handler;

@end

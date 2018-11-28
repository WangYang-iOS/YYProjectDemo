//
//  CQJSWebViewSupVC.m
//  Chengqu
//
//  Created by wangyang on 2017/8/29.
//  Copyright © 2017年 HangzhouHaiqu. All rights reserved.
//

#import "CQJSWebViewSupVC.h"
#import "HQWebLoadProgressView.h"

@interface CQJSWebViewSupVC ()
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, copy) NSString *methodName;
@property (nonatomic, strong) HQWebLoadProgressView *progressView;
@property (nonatomic, assign) BOOL isFinishLoad;

@end

@implementation CQJSWebViewSupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressView = [[HQWebLoadProgressView alloc] initWithFrame:CGRectMake(0, NAVIH, SCREENW, 3)];
    self.progressView.lineColor = MAINRGB;
    [self.view addSubview:self.progressView];
    self.isFinishLoad = NO;
}

- (WKWebView *)loadWebUrl:(NSString *)url frame:(CGRect)rect {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    WKWebView *wkWeb = [[WKWebView alloc] initWithFrame:rect];
    wkWeb.scrollView.showsVerticalScrollIndicator = NO;
    wkWeb.scrollView.showsHorizontalScrollIndicator = NO;
    wkWeb.scrollView.bounces = NO;
    [self.view addSubview:wkWeb];
    [wkWeb loadRequest:request];
    self.request = request;
    self.wkWeb = wkWeb;

    // 开启日志
    [WebViewJavascriptBridge enableLogging];
    
    // 给哪个webview建立JS与OjbC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:wkWeb];
    [self.bridge setWebViewDelegate:self];
    
    [self.view bringSubviewToFront:self.progressView];

    @weakify(self)
    [RACObserve(self.wkWeb, estimatedProgress) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"%@",x);
        self.progressView.progress = [x floatValue];
    }];
    
    
    
    return wkWeb;
}

- (void)doH5ActionHandler:(H5ActionHandler)handler {
    if (handler) {
        [self.bridge registerHandler:kJSAppinteractive handler:^(id data, WVJBResponseCallback responseCallback) {
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSDictionary *backDataDic = (NSDictionary *)data;
                NSString *methodName = backDataDic[kJSBackMethodName];
                NSDictionary *newBackData = backDataDic[kJSBackModelName];
                self.methodName = methodName;
                
                handler(methodName, newBackData, responseCallback);
            }
        }];
    }
}

@end

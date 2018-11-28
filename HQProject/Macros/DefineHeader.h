//
//  DefineHeader.h
//  Chengqu
//
//  Created by wangyang on 2017/8/8.
//  Copyright © 2017年 HangzhouHaiqu. All rights reserved.
//

#ifndef DefineHeader_h
#define DefineHeader_h

#pragma mark
#pragma mark -- 系统

// UUIDString重启使用 保存至"钥匙串"(Keychain)
#define IDENTIFIER [[UIDevice currentDevice].identifierForVendor UUIDString]
//手机系统
#define SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
//版本号
#define APPVERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//APP名称
#define APPNAME  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#pragma mark
#pragma mark -- 尺寸

#define MainWindow          [UIApplication sharedApplication].delegate.window
#define SCREEN              [UIScreen mainScreen].bounds.size
#define SCREENH             floor(SCREEN.height)
#define SCREENW             floor(SCREEN.width)
#define NAVIH               (SCREENH == 812.0 ? 88 : 64)
#define TABH                49.f
#define BMSAFEH             (SCREENH == 812.0 ? 34 : 0)
#define TOPSAFEH            (SCREENH == 812.0 ? 24 : 0)
#define STATUSH             (SCREENH == 812.0 ? 44 : 20)
#define segControlH         40

#define LINE_H              (1.f/[UIScreen mainScreen].scale)

/**
 *  快速设置 point
 */
#define POINT(_X_,_Y_) CGPointMake(_X_, _Y_)
/**
 *  快速设置 rect
 */
#define RECT(_X_,_Y_,_W_,_H_) CGRectMake(_X_, _Y_, _W_, _H_)
/**
 *  快速设置 size
 */
#define SIZE(_W_,_H_) CGSizeMake(_W_, _H_)
/**
 *  快速设置 bounds
 */
#define BOUNDS(_X_,_Y_,_W_,_H_) CGRectMake(0, 0, _W_, _H_)
/**
 *  快速设置 range
 */
#define RANGE(_location_,_length_) NSMakeRange(_location_,_length_)

#pragma mark
#pragma mark -- 字体

/**
 *  快速设置 font
 */
#define FONT(_SIZE_) [UIFont systemFontOfSize:_SIZE_]

/**
 *  快速设置 MediumFont
 */
#define MediumFont(_SIZE_) [UIFont systemFontOfSize:_SIZE_ weight:UIFontWeightMedium]

/**
 *  快速设置 font
 */
#define PingFangSCRegular(_SIZE_) [UIFont fontWithName:@"PingFangSC-Regular" size:_SIZE_]

/**
 *  快速设置 font
 */
#define PingFangSCBold(_SIZE_) [UIFont fontWithName:@"PingFangSC-Semibold" size:_SIZE_]

#pragma mark
#pragma mark -- 颜色

#define color(r,g,b)        [UIColor colorWithRed:r/225.f green:g/225.f blue:b/225.f alpha:1]
//十六进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 green:((float)((rgbValue & 0xFF00)>>8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]//十六进制
#define UIColorWithAlpha(rgbValue,alphav) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 green:((float)((rgbValue & 0xFF00)>>8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphav]

//主色调
#define MAINRGB  UIColorFromRGB(0x1E6DFF)
//背景色
#define BGRGB    UIColorFromRGB(0xf7f7f7)
//view的背景色
#define VIEWRGB  UIColorFromRGB(0xffffff)
//字体颜色
#define color_title           [UIColor colorWithHexString:@"#2B3343"]
//分割线颜色
#define color_line            [UIColor colorWithHexString:@"#ebebeb"]

#pragma mark
#pragma mark -- 菊花 提示

#define HUDM(text, __view) MBProgressHUD* __hud = [[MBProgressHUD alloc] initWithView:__view]; \
[__view addSubview:__hud];    \
__hud.detailsLabelText = text;    \
__hud.detailsLabelFont = [UIFont systemFontOfSize:15]; \
__hud.removeFromSuperViewOnHide = YES;  \
__hud.mode = MBProgressHUDModeText; \
[__hud show:YES];   \
[__hud hide:true afterDelay:1]; \

#define HUD(_text_) [HQHUDManager hudWithText:_text_];
#define SHOWPROGRESS [HQHUDManager showProgress];
#define HIDDENPROGRESS [HQHUDManager hidden];
#define ERROR_MESSAGE  if (responseMessage.errorMessage.length > 0) {HUD(responseMessage.errorMessage)}

#pragma mark
#pragma mark -- 快速设置
#define PAGESIZE                20
/**
 *  快速配置 imageName
 */
#define IMAGE(_IMAGE_)  [UIImage imageNamed:_IMAGE_]

#define IntegerToString(integer) [NSString stringWithFormat:@"%ld", (long)integer]

#define WeakSelf        __weak typeof(self) weakSelf = self;
#define StrongSelf      __strong typeof(self) strongSelf = weakSelf;

#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

#define FXDefaultHeader @"ic_default_header"
#define FXDefaultLogo   @"ic_default_logo"
/**
 输出语句
 */
#ifndef DEBUG
#define NSLog(...)
#else
#define NSLog(...) NSLog(__VA_ARGS__)
#endif

//-----------------JS交互 方法名  ---------------
#pragma mark -- JS交互 方法名
static NSString *kJSAppinteractive = @"Appinteractive";
static NSString *kJSBackMethodName = @"method";
static NSString *kJSBackModelName = @"data";


#endif /* DefineHeader_h */

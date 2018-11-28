//
//  APIDefine.h
//  customerPro
//
//  Created by wangyang on 16/10/18.
//  Copyright © 2016年 tw. All rights reserved.
//

#ifndef APIDefine_h
#define APIDefine_h

#if 1
//正式环境
#define kDOMAIN                 @"http://api.fenxiangzl.com/" //域名
#else
//测试环境
#define kDOMAIN                 @"http://ledianduo.com:8088/" //域名
#endif


#pragma mark
#pragma mark -- 本地缓存Key

#define FXFirstLaunch       @"FXFirstLaunch"//是否是第一次打开app


#endif /* APIDefine_h */

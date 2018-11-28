//
//  HQWebLoadProgressView.h
//  Chengqu
//
//  Created by wangyang on 2018/9/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQWebLoadProgressView : UIView
//进度条颜色
@property (nonatomic,strong) UIColor *lineColor;

@property (assign, nonatomic) CGFloat progress;

//开始加载
- (void)startLoadingAnimation;

//结束加载
- (void)endLoadingAnimation;

@end

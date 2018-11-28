//
//  WYBannerView.h
//  WYBannerView
//
//  Created by wangyang on 2016/11/22.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYBannerView;

@protocol WYBannerViewDelegate <NSObject>

- (void)clickBannerViewWithTag:(NSInteger)tag;

@end

@interface WYBannerView : UIView

@property (strong, nonatomic) NSArray <NSString *>*imgArray;                //图片
@property (assign, nonatomic) id <WYBannerViewDelegate> WYDelegate;
@property (strong, nonatomic) UIColor *pageColor;                           //pageControl颜色
@property (strong, nonatomic) UIColor *currentPageColor;                    //pageControl当前颜色
@property (nonatomic, assign) UIViewContentMode contentMode;


- (void)initTimer;                  //开启定时器
- (void)invalidateTimer;            //销毁定时器
@end

//
//  UIScrollView+TouchConflict.m
//  Chengqu
//
//  Created by wangyang on 2018/5/10.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UIScrollView+TouchConflict.h"

@implementation UIScrollView (TouchConflict)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    if([view isKindOfClass:[UISlider class]])
    {
        //如果响应view是UISlider,则scrollview禁止滑动
        self.scrollEnabled = NO;
    }
    else
    {   //如果不是,则恢复滑动
        self.scrollEnabled = YES;
    }
    return view;
}

@end


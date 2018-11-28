//
//  FXToolTip.h
//  FXQL
//
//  Created by yons on 2018/10/26.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXToolTip : UIView

/**
 index 0:创建群  1:多群聊天

 @param complete complete description
 */
+ (void)showTipsViewWithComplete:(void(^)(NSInteger index))complete;


@end

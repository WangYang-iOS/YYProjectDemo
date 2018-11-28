//
//  FXLeaderView.h
//  FXQL
//
//  Created by yons on 2018/11/26.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXLeaderView : UIView

+ (FXLeaderView *)showLeaderViewWithImage:(NSString *)image callback:(void(^)(void))callback;

@end

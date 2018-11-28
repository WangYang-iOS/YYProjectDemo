//
//  FXTipsView.h
//  FXQL
//
//  Created by yons on 2018/10/26.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXTipsView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                       images:(NSArray *)images
                     complete:(void(^)(NSInteger index))complete;

@end

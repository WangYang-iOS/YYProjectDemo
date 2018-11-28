//
//  FXSortView.h
//  FXQL
//
//  Created by yons on 2018/10/19.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TotalType = 0,          //综合
    GongType,           //供应类型
    XuType,             //需求类型
    ConnectionType,     //人脉类型
} FXSortType;

@interface FXSortView : UIView

+ (void)showSortView:(FXSortType)sortType lastIndex:(NSInteger)lastIndex vc:(UIViewController *)vc complete:(void(^)(NSInteger itemIndex))complete;

@end

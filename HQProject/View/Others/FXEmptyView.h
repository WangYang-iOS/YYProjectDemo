//
//  FXEmptyView.h
//  FXQL
//
//  Created by yons on 2018/11/7.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXEmptyView : UIView

@property(copy, nonatomic) dispatch_block_t callback;

- (void)layoutEmptyViewFrame:(CGRect)frame emptyType:(FXEmptyPageType)emptyType;
@end

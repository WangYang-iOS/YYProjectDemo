//
//  FXBaseViewModel.h
//  FXQL
//
//  Created by wangyang on 2018/9/18.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXBaseViewModel : NSObject

@property (nonatomic, assign) NSInteger page;

- (void)initBindingViewModel;

@end

NS_ASSUME_NONNULL_END

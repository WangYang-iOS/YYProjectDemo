//
//  FXBaseViewModel.m
//  FXQL
//
//  Created by wangyang on 2018/9/18.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXBaseViewModel.h"

@implementation FXBaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    FXBaseViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        viewModel.page = 1;
        [viewModel initBindingViewModel];
    }
    return viewModel;
}

- (void)initBindingViewModel {
    
}

@end

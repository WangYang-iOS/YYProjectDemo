//
//  UIView+Nib.m
//  Chengqu
//
//  Created by wangyang on 2018/3/20.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)

+ (instancetype)loadXib {
    return [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}

@end

//
//  HQUploadView.h
//  Chengqu
//
//  Created by wangyang on 2018/5/16.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQUploadCell.h"

@interface HQUploadView : UIView

- (instancetype)initWithFrame:(CGRect)frame colum:(NSInteger)colum maxCount:(NSInteger)maxCount;

- (CGFloat)height;

- (void)addImg:(UIImage *)image;

@end

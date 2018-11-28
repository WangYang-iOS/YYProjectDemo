//
//  FXBaseTableViewCell.h
//  FXQL
//
//  Created by yons on 2018/10/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXBaseTableViewCell : UITableViewCell
@property(strong, nonatomic) RACSubject *subject;

+ (CGFloat)cellHeightWithModel:(FXBaseModel *)model;

@end

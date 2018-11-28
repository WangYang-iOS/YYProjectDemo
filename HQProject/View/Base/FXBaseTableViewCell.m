//
//  FXBaseTableViewCell.m
//  FXQL
//
//  Created by yons on 2018/10/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXBaseTableViewCell.h"

@implementation FXBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (CGFloat)cellHeightWithModel:(FXBaseModel *)model {
    return 0;
}

- (RACSubject *)subject {
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}

@end

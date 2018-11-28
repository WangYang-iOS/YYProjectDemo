//
//  UITableView+Methods.m
//  FXQL
//
//  Created by yons on 2018/10/18.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UITableView+Methods.h"

@implementation UITableView (Methods)

- (void)registerCellNib:(NSString *)classString {
    [self registerNib:[UINib nibWithNibName:classString bundle:nil] forCellReuseIdentifier:classString];
}
- (void)registerCellClass:(NSString *)classString {
    [self registerClass:NSClassFromString(classString) forCellReuseIdentifier:classString];
}
- (void)registerCellHeaderFooterNib:(NSString *)classString {
    [self registerNib:[UINib nibWithNibName:classString bundle:nil] forHeaderFooterViewReuseIdentifier:classString];
}
- (void)registerCellHeaderFooterClass:(NSString *)classString {
    [self registerClass:NSClassFromString(classString) forHeaderFooterViewReuseIdentifier:classString];
}
- (void)estimatedHeight {
    self.estimatedRowHeight = UITableViewAutomaticDimension;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
}
@end

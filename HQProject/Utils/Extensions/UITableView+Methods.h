//
//  UITableView+Methods.h
//  FXQL
//
//  Created by yons on 2018/10/18.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Methods)

- (void)registerCellNib:(NSString *)classString;
- (void)registerCellClass:(NSString *)classString;
- (void)registerCellHeaderFooterNib:(NSString *)classString;
- (void)registerCellHeaderFooterClass:(NSString *)classString;
- (void)estimatedHeight;
@end

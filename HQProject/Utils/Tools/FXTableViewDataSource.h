//
//  FXTableViewDataSource.h
//  FXQL
//
//  Created by WY的七色花 on 2018/11/21.
//  Copyright © 2018 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXTableViewDataSource : NSObject<UITableViewDataSource>

- (instancetype)initDataSource:(NSArray *)dataArray
                cellIdentifier:(NSString *)cellIdentifier
                configuerdCell:(void(^)(id cell, id obj))configuerdCell;

- (instancetype)initDataSourceWithCellIdentifier:(NSString *)cellIdentifier
                                  configuerdCell:(void(^)(id cell, id obj))configuerdCell;

- (void)reloadTableViewWithDataArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END

//
//  FXTableViewDataSource.m
//  FXQL
//
//  Created by WY的七色花 on 2018/11/21.
//  Copyright © 2018 HangzhouHaiqu. All rights reserved.
//

#import "FXTableViewDataSource.h"

@interface FXTableViewDataSource ()
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) void (^configuerdCell)(id cell, id obj);
@property (nonatomic, copy) NSString *cellIdentifier;
@end

@implementation FXTableViewDataSource

- (instancetype)initDataSourceWithCellIdentifier:(NSString *)cellIdentifier configuerdCell:(void(^)(id cell, id obj))configuerdCell {
    return [[FXTableViewDataSource alloc] initDataSource:@[] cellIdentifier:cellIdentifier configuerdCell:configuerdCell];
}

- (instancetype)initDataSource:(NSArray *)dataArray cellIdentifier:(NSString *)cellIdentifier configuerdCell:(void(^)(id cell, id obj))configuerdCell {
    self = [super init];
    if (self) {
        self.dataArray = dataArray;
        self.cellIdentifier = cellIdentifier;
        self.configuerdCell = configuerdCell;
    }
    return self;
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id obj = [self objAtIndexPath:indexPath];
    if (self.configuerdCell) {
        self.configuerdCell(cell, obj);
    }
    return cell;
}

#pragma mark -
#pragma mark - pravate methods

- (id)objAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray[indexPath.row];
}

- (void)reloadTableViewWithDataArray:(NSArray *)dataArray {
    self.dataArray = dataArray;
}

@end

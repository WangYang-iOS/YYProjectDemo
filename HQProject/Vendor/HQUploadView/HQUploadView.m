//
//  HQUploadView.m
//  Chengqu
//
//  Created by wangyang on 2018/5/16.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "HQUploadView.h"
#define space 15

@interface HQUploadView ()<HQUploadCellDelegate>
@property (nonatomic, strong) HQUploadCell *addCell;//添加图片
@property (nonatomic, assign) NSInteger colum;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, assign) CGFloat cellW;
@property (nonatomic, strong) NSMutableArray *imgArray;
@end

@implementation HQUploadView

- (instancetype)initWithFrame:(CGRect)frame
                        colum:(NSInteger)colum
                     maxCount:(NSInteger)maxCount {
    self = [super initWithFrame:frame];
    if (self) {
        self.colum = colum;
        self.maxCount = maxCount;
        self.cellW = (frame.size.width - (colum + 1) * space) / (colum * 1.0);
        [self addSubview:self.addCell];
    }
    return self;
}

#pragma mark -
#pragma mark - HQUploadCellDelegate

- (void)didAddUploadCell:(HQUploadCell *)uploadCell {
    //
}

- (void)didDeleteUploadCell:(HQUploadCell *)uploadCell {
    
}

- (void)didReUploadCell:(HQUploadCell *)uploadCell {
    
}

#pragma mark -
#pragma mark - pravate methods

- (CGFloat)height {
    return 100;
}

- (void)addImg:(UIImage *)image {
    [self.imgArray addObject:image];
}
#pragma mark -
#pragma mark - lazy

- (HQUploadCell *)addCell {
    if (!_addCell) {
        HQUploadCell *cell = [[HQUploadCell alloc] initWithFrame:RECT(space, 0, self.cellW, self.cellW)];
        cell.isAdd = YES;
        cell.delegate = self;
        _addCell = cell;
    }
    return _addCell;
}



@end

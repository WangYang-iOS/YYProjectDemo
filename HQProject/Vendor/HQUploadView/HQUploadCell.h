//
//  HQUploadCell.h
//  Chengqu
//
//  Created by wangyang on 2018/5/16.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HQUploadCell;

typedef enum : NSUInteger {
    UploadIng,
    UploadSuccess,
    UploadFail,
} UploadStatus;


@protocol HQUploadCellDelegate <NSObject>
@optional

- (void)didDeleteUploadCell:(HQUploadCell *)uploadCell;//删除图片
- (void)didAddUploadCell:(HQUploadCell *)uploadCell;//添加图片
- (void)didReUploadCell:(HQUploadCell *)uploadCell;//重新上传
@end

@interface HQUploadCell : UIView
@property (nonatomic, weak) id <HQUploadCellDelegate>delegate;
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) UploadStatus uploadState;

@end

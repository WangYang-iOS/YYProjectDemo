//
//  YYPhotoBottomView.h
//  FXQL
//
//  Created by yons on 2018/10/30.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYPhotoBottomViewDelegate <NSObject>
@optional

- (void)didClickSureAtBottomView:(UIView *)bottomView;

@end

@interface YYPhotoBottomView : UIView
@property (nonatomic, weak) id <YYPhotoBottomViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate;
@end

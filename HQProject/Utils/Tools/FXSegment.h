//
//  FXSegment.h
//  FXQL
//
//  Created by yons on 2018/10/19.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXSegment;
@protocol FXSegmentDelegate <NSObject>
@optional
- (void)segment:(FXSegment *)segment didSelectedAtIndex:(NSInteger)index;
@end

@interface FXSegment : UIView
@property(strong, nonatomic) UIColor *selectedColor;
@property(strong, nonatomic) UIColor *normalColor;
@property(strong, nonatomic) UIColor *lineColor;
@property(copy, nonatomic) NSString *selectedImage;
@property(copy, nonatomic) NSString *normalImage;
@property(strong, nonatomic) UIFont *font;

@property(assign, nonatomic) BOOL showBottomLine;

@property(weak, nonatomic) id <FXSegmentDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles delegate:(id<FXSegmentDelegate>)delegate;

- (void)selectedAtIndex:(NSInteger)index;

- (void)moveBottomViewWithContentOffset:(CGPoint)contentOffset;

@end

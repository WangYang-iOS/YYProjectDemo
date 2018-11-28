//
//  FXNavigationBar.h
//  FXQL
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXNavigationBar : UIView

@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *rightButtonTitle;
@property(copy, nonatomic) NSString *rightButtonImage;
@property(strong, nonatomic) UIView *titleView;
@property(strong, nonatomic) UIButton *leftButton;
@property(strong, nonatomic) UIButton *rightButton;

@property(assign, nonatomic) BOOL hiddenLeftButton;
- (void)removeNavigationBarBottomLine:(BOOL)hidden;

@end

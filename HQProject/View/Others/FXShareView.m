//
//  FXShareView.m
//  FXQL
//
//  Created by yons on 2018/11/20.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXShareView.h"
#define shareH 240
#define bottomH 60

@interface FXShareView ()
@property(strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *topView;
@property (copy, nonatomic) void (^callback)(NSInteger index);
@end

@implementation FXShareView


+ (void)showShareView:(void(^)(NSInteger index))callback {
    FXShareView *shareView = [[FXShareView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    shareView.callback = callback;
    [MainWindow addSubview:shareView];
    
    [UIView animateWithDuration:0.25 animations:^{
        shareView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
        shareView.contentView.frame = RECT(0, SCREENH - shareH, SCREENW, shareH);
    }];
}

#pragma mark
#pragma mark -- 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREENW, SCREENH);
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0];
        self.contentView = [[UIView alloc] initWithFrame:RECT(0, SCREENH, SCREENW, 0)];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
        
        self.topView = [[UIView alloc] initWithFrame:RECT(10, 0, SCREENW - 2 * 10, 160)];
        self.topView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.topView];
        [self.topView cornerWithRadius:13];
        
        UIButton *button = [UIButton buttonWithTitle:@"取消" titleColor:@"#2B3343" font:PingFangSCRegular(18)];
        button.frame = RECT(10, shareH - bottomH - 10, SCREENW - 10 * 2, bottomH);
        button.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(removePickerView) forControlEvents:UIControlEventTouchUpInside];
        [button cornerWithRadius:13];
        
        UILabel *titleLabel = [UILabel labelWithText:@"分享到" font:PingFangSCBold(18) textColor:@"#2B3343" textAlignment:NSTextAlignmentCenter];
        [self.topView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.topView);
            make.top.offset(20);
            make.height.offset(25);
        }];
        
        UIButton *wechatButton = [UIButton buttonWithTitle:@"微信" titleColor:@"#999DA5" font:PingFangSCRegular(12)];
        [wechatButton setImage:IMAGE(@"ic_wechat_friend") forState:UIControlStateNormal];
        wechatButton.tag = 11201;
        [self.topView addSubview:wechatButton];
        [wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.topView);
            make.top.equalTo(titleLabel.mas_bottom).offset(15);
            make.height.offset(80);
            make.width.offset(50);
        }];
        [wechatButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [wechatButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        
        UIButton *qqButton = [UIButton buttonWithTitle:@"QQ" titleColor:@"#999DA5" font:PingFangSCRegular(12)];
        [qqButton setImage:IMAGE(@"ic_share_qq") forState:UIControlStateNormal];
        qqButton.tag = 11200;
        [self.topView addSubview:qqButton];
        [qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wechatButton.mas_left).offset(-53);
            make.top.equalTo(titleLabel.mas_bottom).offset(15);
            make.height.offset(80);
            make.width.offset(50);
        }];
        [qqButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [qqButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        
        UIButton *lineButton = [UIButton buttonWithTitle:@"朋友圈" titleColor:@"#999DA5" font:PingFangSCRegular(12)];
        [lineButton setImage:IMAGE(@"ic_wechat_line") forState:UIControlStateNormal];
        lineButton.tag = 11202;
        [self.topView addSubview:lineButton];
        [lineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wechatButton.mas_right).offset(53);
            make.top.equalTo(titleLabel.mas_bottom).offset(15);
            make.height.offset(80);
            make.width.offset(50);
        }];
        [lineButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [lineButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePickerView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)removePickerView {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0];
        self.contentView.frame = RECT(0, SCREENH, SCREENW, shareH);
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)clickButton:(UIButton *)button {
    NSInteger index = button.tag - 11200;
    [self removePickerView];
    if (self.callback) {
        self.callback(index);
    }
}

@end

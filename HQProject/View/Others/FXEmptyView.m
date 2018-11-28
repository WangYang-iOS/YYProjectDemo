//
//  FXEmptyView.m
//  FXQL
//
//  Created by yons on 2018/11/7.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXEmptyView.h"

@interface FXEmptyView ()
@property(strong, nonatomic) UIImageView *emptyV;
@property(strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) UIButton *refreshButton;
@end

@implementation FXEmptyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutEmptyViewFrame:(CGRect)frame emptyType:(FXEmptyPageType)emptyType {
    switch (emptyType) {
        case FXNetworkErrorType:
        {
            self.emptyV.image = IMAGE(@"ic_empty_network");
            self.titleLabel.text = @"网络异常，请刷新重试";
            self.refreshButton.hidden = NO;
        }
            break;
        case FXNoHistoryType:
        {
            self.emptyV.image = IMAGE(@"ic_empty_history");
            self.titleLabel.text = @"暂无记录/内容";
            self.refreshButton.hidden = YES;
        }
            break;
        case FXNoDataType:
        {
            self.emptyV.image = IMAGE(@"ic_empty_data");
            self.titleLabel.text = @"暂无数据";
            self.refreshButton.hidden = YES;
        }
            break;
        case FXNoMessageType:
        {
            self.emptyV.image = IMAGE(@"ic_empty_message");
            self.titleLabel.text = @"暂无数据";
            self.refreshButton.hidden = YES;
        }
            break;
        case FXNoSearchContentType:
        {
            self.emptyV.image = IMAGE(@"ic_empty_search");
            self.titleLabel.text = @"没有搜索结果";
            self.refreshButton.hidden = YES;
        }
            break;
            
        default:
            break;
    }
    self.frame = frame;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.emptyV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-50);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.emptyV.mas_bottom).offset(15);
    }];
    [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(SIZE(106, 40));
    }];
    [self.refreshButton cornerWithRadius:20];
}

- (void)clickRefreshButton {
    if (self.callback) {
        self.callback();
    }
}

#pragma mark
#pragma mark -- lazy

- (UIImageView *)emptyV {
    if (!_emptyV) {
        _emptyV = [[UIImageView alloc] init];
        [self addSubview:_emptyV];
    }
    return _emptyV;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFont:PingFangSCRegular(15) textColor:@"#9A9A9A" textAlignment:NSTextAlignmentCenter];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)refreshButton {
    if (!_refreshButton) {
        _refreshButton = [UIButton buttonWithTitle:@"刷新" titleColor:@"ffffff" font:PingFangSCRegular(15)];
        _refreshButton.backgroundColor = [UIColor colorWithHexString:@"#367FF9"];
        [self addSubview:_refreshButton];
        [_refreshButton addTarget:self action:@selector(clickRefreshButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshButton;
}

@end

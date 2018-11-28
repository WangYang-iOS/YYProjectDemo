//
//  FXImageView.m
//  FXQL
//
//  Created by yons on 2018/11/2.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXImageView.h"

@interface FXImageView ()
@property(strong, nonatomic) UIView *shadowView;
@property(strong, nonatomic) UILabel *progressLabel;

@end

@implementation FXImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.shadowView];
    [self.shadowView addSubview:self.progressLabel];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.shadowView];
        [self.shadowView addSubview:self.progressLabel];
    }
    return self;
}

#pragma mark
#pragma mark -- pravate methods

- (void)uploadImage:(UIImage *)image type:(FXUploadImgType)type {
    NSString *timekey = [HQCommenMethods timestampWithDate:[NSDate date]];
    self.image = image;
    [HQUploadManager uploadImg:image key:timekey type:type progress:^(CGFloat progress) {
        self.shadowView.hidden = NO;
        self.progressLabel.text = [NSString stringWithFormat:@"%.f%%",progress * 100];
        self.isUploading = YES;
    } callback:^(BOOL success, NSString *imgPath, NSString *key) {
        if (success) {
            if ([key isEqualToString:timekey]) {
                self.isUploading = NO;
                self.imagePath = imgPath;
                self.shadowView.hidden = YES;
            }
        }else {
            self.progressLabel.text = @"上传失败";
        }
    }];
}

#pragma mark
#pragma mark -- UI

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsZero);
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsZero);
    }];
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.4];
        _shadowView.hidden = YES;
        _shadowView.clipsToBounds = YES;
    }
    return _shadowView;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [UILabel labelWithFont:PingFangSCBold(10) textColor:@"ffffff" textAlignment:NSTextAlignmentCenter];
        _progressLabel.userInteractionEnabled = YES;
    }
    return _progressLabel;
}

@end

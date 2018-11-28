//
//  HQUploadCell.m
//  Chengqu
//
//  Created by wangyang on 2018/5/16.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "HQUploadCell.h"

@interface HQUploadCell ()
@property (nonatomic, strong) UIImageView *mainView;//图片
@property (nonatomic, strong) UIButton *deleteButton;//删除
@property (nonatomic, strong) UIView *maskView;//阴影背景
@property (nonatomic, strong) UILabel *progressLabel;//进度
@property (nonatomic, strong) UIButton *reUploadButton;//重新上传
@end

@implementation HQUploadCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"EBEBEB"];
        [self addSubview:self.mainView];
        [self addSubview:self.maskView];
        [self addSubview:self.reUploadButton];
        [self addSubview:self.progressLabel];
        [self addSubview:self.deleteButton];
    }
    return self;
}

#pragma mark -
#pragma mark - pravate methods

- (void)setIsAdd:(BOOL)isAdd {
    _isAdd = isAdd;
    self.mainView.image = [UIImage imageNamed:@"icon_img_add"];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f%%",progress];
}

- (void)setUploadState:(UploadStatus)uploadState {
    _uploadState = uploadState;
    switch (uploadState) {
        case UploadIng:
        {
            self.maskView.hidden = NO;
            self.progressLabel.hidden = NO;
            self.deleteButton.hidden = NO;
            self.reUploadButton.hidden = YES;
        }
            break;
        case UploadSuccess:
        {
            self.maskView.hidden = YES;
            self.progressLabel.hidden = YES;
            self.deleteButton.hidden = NO;
            self.reUploadButton.hidden = YES;
        }
            break;
        case UploadFail:
        {
            self.maskView.hidden = NO;
            self.progressLabel.hidden = YES;
            self.deleteButton.hidden = NO;
            self.reUploadButton.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark - interface

/**
 添加图片

 @param tap tap description
 */
- (void)addImg:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(didAddUploadCell:)]) {
        [self.delegate didAddUploadCell:self];
    }
}

/**
 删除图片

 @param button button description
 */
- (void)deleteCell:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(didDeleteUploadCell:)]) {
        [self.delegate didDeleteUploadCell:self];
    }
}

/**
 重新上传

 @param button button description
 */
- (void)reUploadImg:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(didReUploadCell:)]) {
        [self.delegate didReUploadCell:self];
    }
}

#pragma mark -
#pragma mark - lazy

- (UIImageView *)mainView {
    if (!_mainView) {
        _mainView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _mainView.contentMode = UIViewContentModeCenter;
        _mainView.clipsToBounds = YES;
        _mainView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImg:)];
        [_mainView addGestureRecognizer:tap];
    }
    return _mainView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.4;
        _maskView.hidden = YES;
    }
    return _maskView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(self.bounds.size.width - 30, 0, 30, 30);
        [_deleteButton setImage:[UIImage imageNamed:@"icon_img_delete"] forState:UIControlStateNormal];
        _deleteButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 0);
        [_deleteButton addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

- (UIButton *)reUploadButton {
    if (!_reUploadButton) {
        _reUploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reUploadButton.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [_reUploadButton setTitle:@"重新上传" forState:UIControlStateNormal];
        _reUploadButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _reUploadButton.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
        [_reUploadButton addTarget:self action:@selector(reUploadImg:) forControlEvents:UIControlEventTouchUpInside];
        _reUploadButton.hidden = YES;
    }
    return _reUploadButton;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] initWithFrame:RECT(0, 0, self.bounds.size.width, 20)];
        _progressLabel.font = [UIFont systemFontOfSize:15];
        _progressLabel.textColor = [UIColor whiteColor];
        _progressLabel.hidden = YES;
    }
    return _progressLabel;
}
@end

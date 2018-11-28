//
//  FXLeaderView.m
//  FXQL
//
//  Created by yons on 2018/11/26.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXLeaderView.h"

@interface FXLeaderView ()
@property (strong, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) void (^callback)(void);
@end

@implementation FXLeaderView


#pragma mark
#pragma mark -- pravate methods

+ (FXLeaderView *)showLeaderViewWithImage:(NSString *)image callback:(void(^)(void))callback {
    FXLeaderView *leaderView = [[FXLeaderView alloc] initWithFrame:[UIScreen mainScreen].bounds image:image];
    leaderView.callback = callback;
    [MainWindow addSubview:leaderView];
    return leaderView;
}

#pragma mark
#pragma mark -- init

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        self.imageView.image = IMAGE(image);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
        [self.imageView addGestureRecognizer:tap];
    }
    return self;
}

- (void)clickImage:(UITapGestureRecognizer *)tap {
    if (self.callback) {
        self.callback();
    }
    [self removeFromSuperview];
}

#pragma mark
#pragma mark -- lazy

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:RECT(0, 0, [self getWidth], [self getHeight])];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

@end

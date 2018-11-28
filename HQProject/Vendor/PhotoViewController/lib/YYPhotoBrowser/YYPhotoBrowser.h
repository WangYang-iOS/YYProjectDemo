//
//  YYPhotoBrowser.h
//  YYImagePickerController
//
//  Created by wangyang on 2018/6/6.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYPhotoItem.h"

typedef NS_ENUM(NSUInteger, YYPhotoBrowserInteractiveDismissalStyle) {
    YYPhotoBrowserInteractiveDismissalStyleRotation,
    YYPhotoBrowserInteractiveDismissalStyleScale,
    YYPhotoBrowserInteractiveDismissalStyleSlide,
    YYPhotoBrowserInteractiveDismissalStyleNone
};

typedef NS_ENUM(NSUInteger, YYPhotoBrowserBackgroundStyle) {
    YYPhotoBrowserBackgroundStyleBlurPhoto,
    YYPhotoBrowserBackgroundStyleBlur,
    YYPhotoBrowserBackgroundStyleBlack
};

typedef NS_ENUM(NSUInteger, YYPhotoBrowserPageIndicatorStyle) {
    YYPhotoBrowserPageIndicatorStyleDot,
    YYPhotoBrowserPageIndicatorStyleText
};

typedef NS_ENUM(NSUInteger, YYPhotoBrowserImageLoadingStyle) {
    YYPhotoBrowserImageLoadingStyleIndeterminate,
    YYPhotoBrowserImageLoadingStyleDeterminate
};

@class YYPhotoBrowser;

@protocol YYPhotoBrowserDelegate <NSObject>
@optional

- (void)photoBrowser:(YYPhotoBrowser *)photoBrowser didClickSureButton:(id)result;

@end



@interface YYPhotoBrowser : UIViewController
@property (nonatomic, assign) YYPhotoBrowserInteractiveDismissalStyle dismissalStyle;
@property (nonatomic, assign) YYPhotoBrowserBackgroundStyle backgroundStyle;
@property (nonatomic, assign) YYPhotoBrowserPageIndicatorStyle pageindicatorStyle;
@property (nonatomic, assign) YYPhotoBrowserImageLoadingStyle loadingStyle;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, assign) BOOL bounces;
@property (nonatomic, copy) dispatch_block_t refreshBlock;
@property (weak, nonatomic) id <YYPhotoBrowserDelegate> delegate;

+ (instancetype)browserWithPhotoItems:(NSArray<YYPhotoItem *> *)photoItems selectedIndex:(NSUInteger)selectedIndex;
+ (instancetype)browserWithPhotoItems:(NSArray<YYPhotoItem *> *)photoItems selectedIndex:(NSUInteger)selectedIndex delegate:(id<YYPhotoBrowserDelegate>)delegate;
- (instancetype)initWithPhotoItems:(NSArray<YYPhotoItem *> *)photoItems selectedIndex:(NSUInteger)selectedIndex;
- (instancetype)initWithPhotoItems:(NSArray<YYPhotoItem *> *)photoItems selectedIndex:(NSUInteger)selectedIndex delegate:(id<YYPhotoBrowserDelegate>)delegate;
- (void)showFromViewController:(UIViewController *)vc;

@end

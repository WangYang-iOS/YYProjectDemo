//
//  UIImageView+localCache.m
//  Chengqu
//
//  Created by WY的七色花 on 2018/4/7.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UIImageView+localCache.h"

@implementation UIImageView (localCache)

- (void)hq_setImageWithURL:(NSString *)url
          placeholderImage:(NSString *)placeholder
                     needCache:(BOOL)needCache
                 completed:(void(^)(UIImage *image, BOOL success))completedBlock {
    UIImage * placeholderImage;
    if (placeholder.length < 1) {
        placeholder = @"default_banner";
    }
    placeholderImage = [UIImage imageNamed:placeholder];
    
    if (url.length < 1) {
        self.image = placeholderImage;
        if (completedBlock) {
            completedBlock(placeholderImage, NO);
        }
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *_url;
    if ([url rangeOfString:@"http"].length == 4) {
        _url = [NSURL URLWithString:url];
    }
    else {
        _url = [NSURL URLWithString:[kDOMAIN stringByAppendingString:url]];
    }
    if ([[url substringToIndex:1] isEqualToString:@"/"]) {
        _url = [NSURL URLWithString:[kDOMAIN stringByAppendingString:url]];
    }
    [self sd_setImageWithURL:_url placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            if (completedBlock) {
                completedBlock(image,YES);
            }
        }else {
            self.image = placeholderImage;
            if (completedBlock) {
                completedBlock(self.image, NO);
            }
        }
    }];
//    if (needCache) {
//        // 非新闻列表 图片 缓存到本地
//        NSString *imagName = [NSString stringWithFormat:@"%lu",(unsigned long)[url hash]];
//        NSString *localImagePath = [[DBManager getCachePath:FXHpics] stringByAppendingPathComponent:imagName];
//        UIImage *localImage = [UIImage imageWithContentsOfFile:localImagePath];
//        if (localImage) {
//            self.image = localImage;
//            if (completedBlock) {
//                completedBlock(localImage, YES);
//            }
//        } else if ([CQUser shareCQUser].allowLoadImage ) {
//            [self sd_setImageWithURL:_url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                if (!error) {
//                    [DBManager saveImageToLocal:image Keys:imagName];
//                    if (completedBlock) {
//                        completedBlock(image, YES);
//                    }
//                } else {
//                    self.image = placeholderImage;
//                    if (completedBlock) {
//                        completedBlock(self.image, NO);
//                    }
//                }
//            }];
//        } else {
//            self.image = placeholderImage;
//            if (completedBlock) {
//                completedBlock(self.image, NO);
//            }
//        }
//    } else {
//        if ([CQUser shareCQUser].allowLoadImage ) {
//            [self sd_setImageWithURL:_url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                if (!error) {
//                    if (completedBlock) {
//                        completedBlock(image, YES);
//                    }
//                } else {
//                    self.image = placeholderImage;
//                    if (completedBlock) {
//                        completedBlock(self.image, NO);
//                    }
//                }
//            }];
//        }else {
//            self.image = placeholderImage;
//            if (completedBlock) {
//                completedBlock(self.image, NO);
//            }
//        }
//    }
}

@end

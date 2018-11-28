//
//  UIButton+localCache.m
//  Chengqu
//
//  Created by WY的七色花 on 2018/4/7.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "UIButton+localCache.h"

@implementation UIButton (localCache)

- (void)hq_setImageWithURL:(NSString *)url
          placeholderImage:(NSString *)placeholder
                 completed:(void (^)(UIImage *))completedBlock {
    UIImage * placeholderImage;
    if (placeholder.length < 1) {
        placeholder = @"default_banner";
    }
    placeholderImage = [UIImage imageNamed:placeholder];
    
    if (url.length < 1) {
        [self setImage:placeholderImage forState:UIControlStateNormal];
        if (completedBlock) {
            completedBlock(placeholderImage);
        }
        return;
    }
    
    NSURL *_url;
    if ([url rangeOfString:@"http"].length == 4) {
        _url = [NSURL URLWithString:url];
    }else {
        _url = [NSURL URLWithString:[kDOMAIN stringByAppendingString:url]];
    }
    if ([[url substringToIndex:1] isEqualToString:@"/"]) {
        _url = [NSURL URLWithString:[kDOMAIN stringByAppendingString:url]];
    }
    
    NSString *imagName = [NSString stringWithFormat:@"%lu",(unsigned long)[url hash]];
    NSLog(@"%@",imagName);
//    NSString *localImagePath = [[DBManager getCachePath:FXHpics] stringByAppendingPathComponent:imagName];
//    UIImage *localImage = [UIImage imageWithContentsOfFile:localImagePath];
//    if (localImage) {
//        [self setImage:localImage forState:UIControlStateNormal];
//    } else if ([CQUser shareCQUser].allowLoadImage ) {
//        [self sd_setImageWithURL:_url forState:UIControlStateNormal placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (!error) {
//                [DBManager saveImageToLocal:image Keys:imagName];
//            } else {
//                [self setImage:placeholderImage forState:UIControlStateNormal];
//            }
//        }];
//    } else {
//        [self setImage:placeholderImage forState:UIControlStateNormal];
//    }
    
    if (completedBlock) {
        completedBlock(self.currentImage);
    }
}

@end

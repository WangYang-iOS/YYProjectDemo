//
//  UIButton+localCache.h
//  Chengqu
//
//  Created by WY的七色花 on 2018/4/7.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (localCache)

- (void)hq_setImageWithURL:(NSString *)url
          placeholderImage:(NSString *)placeholder
                 completed:(void(^)(UIImage *image))completedBlock;

@end

//
//  NSString+Size.h
//  FXQL
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

- (CGFloat)heightWithFont:(UIFont *)font lineSpace:(CGFloat)lineSpace size:(CGSize)size;

@end

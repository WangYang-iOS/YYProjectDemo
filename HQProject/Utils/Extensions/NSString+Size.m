//
//  NSString+Size.m
//  FXQL
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGFloat)heightWithFont:(UIFont *)font lineSpace:(CGFloat)lineSpace size:(CGSize)size {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:font forKey:NSFontAttributeName];
    if (lineSpace > 0) {
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        [para setLineSpacing:lineSpace];
        [dic setObject:para forKey:NSParagraphStyleAttributeName];
    }
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    //此处要使用ceil函数 大于或等于的最小整数
    CGFloat height = ceil(CGRectGetHeight(rect));
    
//    CGFloat singleH = ceil(CGRectGetHeight([@"一行" boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil]));
//    if (singleH == height) {
//        height = singleH - lineSpace;
//    }
    return height;
}

@end

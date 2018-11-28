//
//  NSMutableAttributedString+AttributedString.m
//  链式
//
//  Created by wangyang on 2018/3/28.
//  Copyright © 2018年 wangyang. All rights reserved.
//

#import "NSMutableAttributedString+AttributedString.h"

@implementation NSMutableAttributedString (AttributedString)

+ (NSMutableAttributedString *(^)(NSString *))initAttributedString {
    return ^(NSString *string) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        return attributedString;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))attributedFont {
    return ^(CGFloat font) {
        [self addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, self.string.length - 1)];
        ;
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))attributedColor {
    return ^(UIColor *color) {
        [self addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.string.length - 1)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))attributedSpace {
    return ^(CGFloat space) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = space;
        [self addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, self.string.length - 1)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *,NSRange))attributedRangeColor {
    return ^(UIColor *color, NSRange range) {
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat,NSRange))attributedRangeFont {
    return ^(CGFloat font, NSRange range) {
        [self addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat,NSRange))attributedRangeBoldFont {
    return ^(CGFloat font, NSRange range) {
        [self addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font] range:range];
        return self;
    };
}
@end

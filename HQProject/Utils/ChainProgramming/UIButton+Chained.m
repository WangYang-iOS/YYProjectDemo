//
//  UIButton+Chained.m
//  链式
//
//  Created by wangyang on 2018/3/28.
//  Copyright © 2018年 wangyang. All rights reserved.
//

#import "UIButton+Chained.h"

@implementation UIButton (Chained)

+ (UIButton *(^)(void))initButton {
    return ^UIButton *() {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        return button;
    };
}

- (UIButton *(^)(NSString *))normalTitle {
    return ^UIButton *(NSString *title) {
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(NSString *))selectedTitle {
    return ^UIButton *(NSString *selectedTitle) {
        [self setTitle:selectedTitle forState:UIControlStateSelected];
        return self;
    };
}

- (UIButton *(^)(UIColor *))normalTitleColor {
    return ^(UIColor *color){
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(UIColor *))selectedTitleColor {
    return ^UIButton *(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateSelected];
        return self;
    };
}

- (UIButton *(^)(CGFloat))titleFont {
    return ^UIButton *(CGFloat font) {
        self.titleLabel.font = [UIFont systemFontOfSize:font];
        return self;
    };
}

- (UIButton *(^)(UIImage *))normalImage {
    return ^UIButton *(UIImage *image) {
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(UIImage *))selectedImage {
    return ^UIButton *(UIImage *image) {
        [self setImage:image forState:UIControlStateSelected];
        return self;
    };
}

@end

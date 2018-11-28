//
//  CALayer+BorderColor.m
//  KeLeiDeng
//
//  Created by wangyang on 2018/1/29.
//  Copyright © 2018年 DemoKing. All rights reserved.
//

#import "CALayer+BorderColor.h"
static char BorderUIColor;
static char ShadowUIColor;
@implementation CALayer (BorderColor)

- (void)setBorderUIColor:(UIColor *)borderUIColor {
    objc_setAssociatedObject(self, &BorderUIColor, borderUIColor, OBJC_ASSOCIATION_RETAIN);
    self.borderColor = borderUIColor.CGColor;
}

- (UIColor *)borderUIColor {
    return objc_getAssociatedObject(self, &BorderUIColor);
}

- (void)setShadowUIColor:(UIColor *)shadowUIColor {
    objc_setAssociatedObject(self, &ShadowUIColor, shadowUIColor, OBJC_ASSOCIATION_RETAIN);
    self.shadowColor= shadowUIColor.CGColor;
}

- (UIColor *)shadowUIColor {
    return objc_getAssociatedObject(self, &ShadowUIColor);
}

@end

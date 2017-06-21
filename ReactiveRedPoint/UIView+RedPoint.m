//
//  UIView+RedPoint.m
//  ReactiveRedPoint
//
//  Created by 纬洲 冯 on 21/06/2017.
//  Copyright © 2017 fengweizhou. All rights reserved.
//

#import "UIView+RedPoint.h"
#import "RedPoint.h"
#import <objc/runtime.h>

@implementation UIView (RedPoint)

- (RedPoint *)redpoint {
    RedPoint *redpoint = objc_getAssociatedObject(self, @selector(redpoint));
    if (redpoint == nil) {
        redpoint = [[RedPoint alloc] initWithBindedView:self];
        objc_setAssociatedObject(self, @selector(redpoint), redpoint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return redpoint;
}

@end

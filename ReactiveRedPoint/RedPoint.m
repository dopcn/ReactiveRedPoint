//
//  RedPointNode.m
//  ReactiveRedPoint
//
//  Created by 纬洲 冯 on 16/06/2017.
//  Copyright © 2017 fengweizhou. All rights reserved.
//

#import "RedPoint.h"

@interface RedPoint ()

@property (nonatomic, copy) CAShapeLayer*(^drawBlock)(NSInteger value);
@property (nonatomic, copy) void(^layoutBlock)(CAShapeLayer *redpoint);
@property (nonatomic, strong) CAShapeLayer *redPoint;
@property (nonatomic, strong) CATextLayer *number;

@end

@implementation RedPoint

- (instancetype)initWithBindedView:(UIView *)view {
    self = [super init];
    if (self) {
        _bindedView = view;
        _children = [NSArray array];
        _signal = [[RedPointSignal alloc] init];
        __weak typeof(self) weakSelf = self;
        [_signal subscribeNext:^(NSInteger value) {
            weakSelf.value = value;
            [weakSelf update:value];
        }];
    }
    return self;
}

- (void)dealloc {
    [self.signal sendCompleted];
}

- (void)setupDrawBlock:(CAShapeLayer *(^)(NSInteger))block {
    self.drawBlock = block;
}

- (void)setupLayoutBlock:(void (^)(CAShapeLayer *))block {
    self.layoutBlock = block;
}

- (void)appendChild:(RedPoint *)node {
    node.parent = self;
    _children = [_children arrayByAddingObject:node];
    
    NSMutableArray *signals = [NSMutableArray array];
    for (RedPoint *red in _children) {
        [signals addObject:red.signal];
    }
    
    _signal = [[RedPointSignal combineLatest:signals] subscribeNext:^(NSInteger value) {
        [self update:value];
    }];
}

- (void)update:(NSInteger)value {
    [self.redPoint removeFromSuperlayer];
    
    if (value != 0) {
        if (self.drawBlock) {
            self.redPoint = self.drawBlock(value);
        } else {
            self.redPoint = [self redPointForNumber:value];
        }
        if (self.layoutBlock) {
            self.layoutBlock(self.redPoint);
        } else {
            CGRect rect = self.redPoint.frame;
            rect.origin.x = self.bindedView.frame.size.width-12;
            rect.origin.y = -3;
            self.redPoint.frame = rect;
            if (value == -1) {
                CGRect rect = self.redPoint.frame;
                rect.origin.x = self.bindedView.frame.size.width-5;
                self.redPoint.frame = rect;
            }
        }
        [self.bindedView.layer addSublayer:self.redPoint];
    }
}

- (void)updateValue:(NSInteger)value {
    [self.signal sendNext:value];
}

- (void)hit {
    [self.signal sendNext:0];
}

- (CAShapeLayer *)redPointForNumber:(NSInteger)number {
    CAShapeLayer *layer = [CAShapeLayer layer];
    CATextLayer *text = [CATextLayer layer];
    text.alignmentMode = kCAAlignmentCenter;
    text.fontSize = 12;
    text.contentsScale = [UIScreen mainScreen].scale;
    text.foregroundColor = [UIColor whiteColor].CGColor;
    CGRect rect = CGRectMake(0, 0, 8, 8);
    [layer addSublayer:text];
    if (number > 99) {
        rect.size.width = 25;
        rect.size.height = 15;
        text.string = @"99+";
    } else if (number > 9) {
        rect.size.width = 20;
        rect.size.height = 15;
        text.string = @(number).stringValue;
    } else if (number > 0) {
        rect = CGRectMake(0, 0, 15, 15);
        text.string = @(number).stringValue;
    }
    layer.frame = rect;
    text.frame = layer.bounds;
    layer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height/2].CGPath;
    layer.fillColor = [UIColor redColor].CGColor;
    return layer;
}

@end

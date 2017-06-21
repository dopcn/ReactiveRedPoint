//
//  RedPointNode.h
//  ReactiveRedPoint
//
//  Created by 纬洲 冯 on 16/06/2017.
//  Copyright © 2017 fengweizhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+RedPoint.h"
#import "RedPointSignal.h"

@interface RedPoint : NSObject

@property (nonatomic, copy) NSString *rid;
//0 -> 没有红点，大于0的数字 -> 包含数字的红点，-1 -> 无内容小红点
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, weak, readonly) UIView *bindedView;
@property (nonatomic, weak) RedPoint *parent;
@property (nonatomic, readonly) NSArray<RedPoint*> *children;
@property (nonatomic, strong, readonly) RedPointSignal *signal;


- (instancetype)initWithBindedView:(UIView*)view;
//自定义红点样式
- (void)setupDrawBlock:(CAShapeLayer*(^)(NSInteger value))block;
//自定义位置
- (void)setupLayoutBlock:(void(^)(CAShapeLayer*))block;

- (void)appendChild:(RedPoint *)node;
- (void)updateValue:(NSInteger)value;
- (void)hit;

@end

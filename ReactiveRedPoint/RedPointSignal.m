//
//  RedPointSignal.m
//  ReactiveRedPoint
//
//  Created by 纬洲 冯 on 21/06/2017.
//  Copyright © 2017 fengweizhou. All rights reserved.
//

#import "RedPointSignal.h"

@interface RedPointSignal ()
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) NSMutableArray<RedPointSubscriber>* subscribers;
@property (nonatomic, copy) void(^completeBlock)(void);
@end

@implementation RedPointSignal

- (instancetype)init {
    self = [super init];
    if (self) {
        _subscribers = [NSMutableArray array];
    }
    return self;
}

- (RedPointSignal *)sendNext:(NSInteger)value {
    self.value = value;
    for (RedPointSubscriber subscriber in self.subscribers) {
        subscriber(value);
    }
    return self;
}

- (RedPointSignal *)sendCompleted {
    self.completeBlock();
    return self;
}

- (RedPointSignal *)subscribeNext:(RedPointSubscriber)subscriber {
    subscriber(self.value);
    [self.subscribers addObject:subscriber];
    return self;
}

- (RedPointSignal *)subscribeCompleted:(void (^)(void))completed {
    self.completeBlock = completed;
    return self;
}

- (NSInteger)peek {
    return self.value;
}

+ (RedPointSignal *)combineLatest:(NSArray<RedPointSignal *> *)signals {
    RedPointSignal *combineSignal = [[RedPointSignal alloc] init];
    for (RedPointSignal *signal in signals) {
        [signal subscribeNext:^(NSInteger value) {
            BOOL hasMinusOne = NO;
            NSInteger total = 0;
            for (RedPointSignal *s in signals) {
                if ([s peek] < 0) {
                    hasMinusOne = YES;
                } else {
                    total += [s peek];
                }
            }
            
            if (total > 0) {
                [combineSignal sendNext:total];
            } else if (hasMinusOne) {
                [combineSignal sendNext:-1];
            } else {
                [combineSignal sendNext:0];
            }
        }];
    }
    return combineSignal;
}

@end

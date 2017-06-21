//
//  RedPointSignal.h
//  ReactiveRedPoint
//
//  Created by 纬洲 冯 on 21/06/2017.
//  Copyright © 2017 fengweizhou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RedPointSubscriber)(NSInteger value);

@interface RedPointSignal : NSObject

- (RedPointSignal *)sendNext:(NSInteger)value;
- (RedPointSignal *)sendCompleted;
- (RedPointSignal *)subscribeNext:(RedPointSubscriber)next;
- (RedPointSignal *)subscribeCompleted:(void(^)(void))completed;
- (NSInteger)peek;

+ (RedPointSignal *)combineLatest:(NSArray<RedPointSignal*>*)signals;

@end

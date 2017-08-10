//
//  WeakProxy.m
//  DataGraphics
//
//  Created by 党国 on 2017/8/10.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "WeakProxy.h"

@interface WeakProxy ()

@property (nonatomic, weak) id target;

@end

@implementation WeakProxy

- (instancetype)initWithTarget:(id)target {
    self = [super init];
    self.target = target;
    
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self.target respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return self.target;
}

@end

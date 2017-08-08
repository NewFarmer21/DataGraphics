//
//  YLBChartModel.m
//  ArcCenter
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "YLBChartModel.h"

@implementation YLBChartModel

- (instancetype)initWithValue:(NSNumber *)value color:(UIColor *)color {
    
    self = [super init];
    
    self.value = value;
    self.color = color;
    
    return self;
}

@end

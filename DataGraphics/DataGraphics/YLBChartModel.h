//
//  YLBChartModel.h
//  ArcCenter
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLBChartModel : NSObject

@property (nonatomic, strong) NSNumber *value;

@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithValue:(NSNumber *)value color:(UIColor *)color;

@end

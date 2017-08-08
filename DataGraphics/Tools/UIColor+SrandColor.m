//
//  AppDelegate+SrandColor.m
//  ArcCenter
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "UIColor+SrandColor.h"

@implementation UIColor (SrandColor)

+ (UIColor *)srand_color {
    CGFloat tmp1 = arc4random() % 255 / 255.0f;
    CGFloat tmp2 = arc4random() % 255 / 255.0f;
    CGFloat tmp3 = arc4random() % 255 / 255.0f;
    
    return [UIColor colorWithRed:tmp1 green:tmp2 blue:tmp3 alpha:1.0f];
}

@end

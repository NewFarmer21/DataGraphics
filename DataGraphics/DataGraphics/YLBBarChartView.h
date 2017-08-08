//
//  YLBBarGraphView.h
//  YLBBarGraphView
//
//  Created by 党国 on 2017/8/1.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  柱状图
 */
@interface YLBBarChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       models:(NSArray *)models
                     maxValue:(CGFloat )maxValues;

@end

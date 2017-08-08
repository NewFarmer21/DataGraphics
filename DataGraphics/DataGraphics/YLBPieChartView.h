//
//  YLBPieChartView.h
//  YLBPieChartView
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLBPieChartView : UIView

/*
 *  dataSource中为YLBChartModel，包含数值和颜色
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;

- (void)animation;

// 动画时间
@property (nonatomic, assign) CFTimeInterval duration;

// 中间空白区域的半径占视图半径的比例
@property (nonatomic, assign) CGFloat lineWidth;

@end

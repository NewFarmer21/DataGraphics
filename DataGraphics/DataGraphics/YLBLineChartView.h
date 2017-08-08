//
//  YLBLineChartView.h
//  DataGraphics
//
//  Created by 党国 on 2017/8/8.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLBLineChartModel : NSObject

@property (nonatomic, strong) NSNumber *value;

@property (nonatomic, strong) NSDateComponents *date;

@end

@interface YLBLineChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)datas;

@end

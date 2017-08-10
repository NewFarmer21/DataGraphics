//
//  YLBBarGraphView.m
//  YLBBarGraphView
//
//  Created by 党国 on 2017/8/1.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "YLBBarChartView.h"
#import "YLBChartModel.h"

@interface YLBBarChartView ()

@property (nonatomic, strong) NSArray *models;

@property (nonatomic, assign) CGFloat maxNum;

@property (nonatomic, assign) CGFloat barWidth;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat labelWidth;

@end

@implementation YLBBarChartView

- (instancetype)initWithFrame:(CGRect)frame
                       models:(NSArray *)models
                     maxValue:(CGFloat)maxValues {
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    self.models = models;
    self.maxNum = maxValues;
    self.labelWidth = 50.0f;
    self.barWidth = (frame.size.width - self.labelWidth) / (models.count * 2 - 1);
    self.centerY = frame.size.height / 2;
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self draw];
}

- (void)draw {
    
    // 线条
    [self addLines];
    
    // 标注Y轴数值
    [self addLabels];
    
    // 绘制柱
    [self drawBarViews];
}

- (void)addLines {
    for (int i=0; i<5; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.labelWidth, i*self.frame.size.height/4, self.frame.size.width - self.labelWidth, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
    }
}

- (void)addLabels {
    for (int i=0; i<5; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i*self.frame.size.height/4 - 15.0f, self.labelWidth, 30.0f)];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.text = [NSString stringWithFormat:@"%0.2f", self.maxNum - i * self.maxNum / 2];
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
    }

}

- (void)drawBarViews {
    
    for (int i=0; i<self.models.count; i++) {
        
        YLBChartModel *barGrapModel = self.models[i];
        CGFloat currentNum = [barGrapModel.value doubleValue];
        
        CGFloat height = (currentNum / self.maxNum) * self.centerY;
        int x = self.labelWidth + self.barWidth * i * 2;
        
        [self drawBarAtX:x height:height bgColor:barGrapModel.color];
    }
}

- (void)drawBarAtX:(int)x height:(int)height bgColor:(UIColor *)bgColor {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if (height > 0) {
        shapeLayer.frame = CGRectMake(x, self.centerY - height, self.barWidth, height);
        [path moveToPoint:CGPointMake(self.barWidth/2, height)];
        [path addLineToPoint:CGPointMake(self.barWidth/2, 0)];
    } else if (height < 0){
        height = -height;
        shapeLayer.frame = CGRectMake(x, self.centerY, self.barWidth, height);
        [path moveToPoint:CGPointMake(self.barWidth/2, 0)];
        [path addLineToPoint:CGPointMake(self.barWidth/2, height)];
    }
    
    shapeLayer.path = path.CGPath;
    
    shapeLayer.lineWidth = self.barWidth;
    shapeLayer.strokeColor = bgColor.CGColor;
    shapeLayer.fillColor = bgColor.CGColor;
    
    [self.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 1.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:[NSString stringWithFormat:@"strokeEndAnimation-%d", x]];
}

@end

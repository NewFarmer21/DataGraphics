//
//  YLBLineChartView.m
//  DataGraphics
//
//  Created by 党国 on 2017/8/8.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "YLBLineChartView.h"

CGFloat numMargin = 1.1;

// label的高度
CGFloat lableHeight = 12.0f;

CGFloat fontSize = 12.0f;

@implementation YLBLineChartModel

- (NSString *)description {
    NSString *desc = [NSString stringWithFormat:@"value: %@", self.value];
    return desc;
}

@end


@interface YLBLineChartView ()

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, assign) CGFloat minValue;

@property (nonatomic, strong) UIView *lineView;

@end


@implementation YLBLineChartView

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)datas {
    self = [super initWithFrame:frame];
    
    self.datas = datas;
    
//    self.clipsToBounds = YES;
    
    // 计算上下最大最小值边界
    [self calcMaxMin];
    
    // 绘制左侧五个Label、五条线条
    [self addLabelsAndLines];
    
    // 绘制开始结束时间
    
    // 绘制走势图
    [self drawLine];
    
    return self;
}

- (void)calcMaxMin {
    
    for (int i=0; i<self.datas.count; i++) {
        YLBLineChartModel *model = self.datas[i];
        CGFloat value = [model.value floatValue];
        if (i==0) {
            self.maxValue = value;
            self.minValue = value;
        } else {
            if (value > self.maxValue) {
                self.maxValue = value;
            }
            if (value < self.minValue) {
                self.minValue = value;
            }
        }
    }
    
    if (fabs(self.maxValue) >= fabs(self.minValue)) {
        self.maxValue = fabs(self.maxValue) * numMargin;
        self.minValue = self.maxValue * -1;
    } else {
        self.minValue = fabs(self.minValue) * numMargin * -1;
        self.maxValue = self.minValue * -1;
    }
}

// 添加标尺Label和Line
- (void)addLabelsAndLines {
    
    for (int i=0; i<5; i++) {
        
        // 添加标尺线
        CGFloat lineY = i * (self.frame.size.height / 4);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, self.frame.size.width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.5f];
        [self addSubview:lineView];
        
        // 添加左侧Label
        CGFloat y = 0;
        if (i == 0) {
            y = 0;
        } else if (i == 4) {
            y = self.frame.size.height - lableHeight;
        } else {
            y = i * (self.frame.size.height / 4) - lableHeight/2;
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, lableHeight)];
        label.font = [UIFont systemFontOfSize:fontSize];
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
        
        CGFloat value = self.maxValue - i * ((self.maxValue - self.minValue) / 4);
        label.text = [NSString stringWithFormat:@"%0.2f", value];

    }
}

- (void)drawLine {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, self.frame.size.height)];
    
    CGFloat width = self.frame.size.width / (self.datas.count - 1);
    
    for (int i=0; i<self.datas.count; i++) {
        YLBLineChartModel *model = self.datas[i];
        CGFloat value = [model.value floatValue];
        CGFloat x = width * i;
        CGFloat y = ((self.maxValue - value) / (self.maxValue - self.minValue)) * self.frame.size.height;
        [bezierPath addLineToPoint:CGPointMake(x, y)];
    }
    
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 0.5f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor colorWithRed:225/255.0f green:237/255.0f blue:251/255.0f alpha:0.2].CGColor;
    shapeLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    shapeLayer.anchorPoint = CGPointMake(1, 1);
    shapeLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    basicAnimation.fromValue = @0.0f;
    basicAnimation.toValue = @1.0f;
    basicAnimation.duration = 2.0f;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [shapeLayer addAnimation:basicAnimation forKey:@"scale.y"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (touches.count > 1) {
        return;
    }
    
    [self showLineViewAtTouches:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.count > 1) {
        return;
    }
    
    [self showLineViewAtTouches:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.lineView removeFromSuperview];
    
    if (touches.count > 1) {
        return;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.lineView removeFromSuperview];
    
    if (touches.count > 1) {
        return;
    }
}

- (void)showLineViewAtTouches:(NSSet<UITouch *> *)touches {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    CGFloat width = self.frame.size.width / (self.datas.count - 1);
    
    CGFloat offset = point.x / width;
    NSInteger curIndex = 0;
    if (offset > 0.5) {
        curIndex = (int)offset + 1;
    } else {
        curIndex = (int)offset;
    }
    
    if (curIndex < 0) {
        curIndex = 0;
    } else if (curIndex >= self.datas.count) {
        curIndex = self.datas.count - 1;
    }
    
    YLBLineChartModel *model = self.datas[curIndex];
    CGFloat value = [model.value floatValue];
    
    if (self.lineView == nil) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(curIndex*width, 0, 0.5f, self.frame.size.height)];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
    } else {
        self.lineView.frame = CGRectMake(curIndex*width, 0, 0.5f, self.frame.size.height);
    }
    
    if (self.lineView.superview == nil) {
        [self addSubview:self.lineView];
    }
    
    NSLog(@"%f", value);
}

@end

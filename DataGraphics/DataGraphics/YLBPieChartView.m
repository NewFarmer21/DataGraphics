//
//  YLBPieChartView.m
//  YLBPieChartView
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "YLBPieChartView.h"
#import "YLBChartModel.h"

#define kDefaultDuration 3.0f
#define kDefaultLineWidth 0.5f

@interface YLBPieChartView () <CAAnimationDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) CGFloat totalValues;

@property (nonatomic, assign) CGPoint arcCenter;

@property (nonatomic, assign) CGFloat startAngle;

@property (nonatomic, assign) CGFloat endAngle;

@property (nonatomic, assign) NSUInteger currentAnimationIndex;

@end


@implementation YLBPieChartView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource {
    self = [super initWithFrame:frame];
    
    self.dataSource = dataSource;
    
    self.duration = kDefaultDuration;
    self.lineWidth = (self.frame.size.width / 2) * kDefaultLineWidth;
    
    self.totalValues = 0.0f;
    for (YLBChartModel *model in self.dataSource) {
        self.totalValues += [model.value floatValue];
    }
    
    self.arcCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    self.startAngle = -M_PI_2;
    self.endAngle = -M_PI_2;
    
    [self setMaskLayer];
    
    return self;
}

- (void)setMaskLayer {
    
    // 添加中间透明色小圆
    UIBezierPath *clearPath = [UIBezierPath bezierPathWithArcCenter:self.arcCenter
                                                             radius:self.frame.size.width / 2 - self.lineWidth
                                                         startAngle:0
                                                           endAngle:2 * M_PI
                                                          clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeStart = 0.0f;
    shapeLayer.strokeEnd = 1.0f;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.path = clearPath.CGPath;
    
    // 解决绘制扇形超出区域的问题
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:self.arcCenter
                                                            radius:self.frame.size.width / 2
                                                        startAngle:0
                                                          endAngle:2 * M_PI
                                                         clockwise:YES];
    CAShapeLayer *maskShapeLayer = [CAShapeLayer layer];
    maskShapeLayer.strokeStart = 0.0f;
    maskShapeLayer.strokeEnd = 1.0f;
    maskShapeLayer.fillColor = [UIColor whiteColor].CGColor;
    maskShapeLayer.path = maskPath.CGPath;
    
    [maskShapeLayer addSublayer:shapeLayer];
    self.layer.mask = maskShapeLayer;
}


- (void)addLayoutAnimation:(NSUInteger)index {
    
    self.currentAnimationIndex = index;
    
    YLBChartModel *model = self.dataSource[index];
    
    self.startAngle = self.endAngle;
    self.endAngle = self.startAngle + ([model.value floatValue] / self.totalValues) * M_PI * 2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.self.arcCenter
                                                        radius:self.lineWidth * 2
                                                    startAngle:self.startAngle
                                                      endAngle:self.endAngle
                                                     clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeStart = 0.0f;
    shapeLayer.lineWidth = self.lineWidth * 2;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = model.color.CGColor;
    shapeLayer.path = path.CGPath;
    
    shapeLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:shapeLayer];
    
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.fromValue = @0.0f;
    basicAnimation.toValue = @1.0f;
    basicAnimation.duration = [model.value floatValue] / self.totalValues * self.duration;
    basicAnimation.delegate = self;
    
    [shapeLayer addAnimation:basicAnimation forKey:@"strokeEnd"];
}

- (void)animation {
    
    // 开启第一个动画
    if (self.dataSource.count > 0) {
        [self addLayoutAnimation:0];
    }
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSUInteger next = self.currentAnimationIndex + 1;
    
    if (next < self.dataSource.count) {
        [self  addLayoutAnimation:next];
    }
}

@end

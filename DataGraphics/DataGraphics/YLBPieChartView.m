//
//  YLBPieChartView.m
//  YLBPieChartView
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "YLBPieChartView.h"
#import "YLBChartModel.h"
#import "WeakProxy.h"

const CGFloat kDefaultDuration = 2.0f;
const CGFloat kDefaultLineWidthPercent = 0.5f;

@interface YLBPieChartView ()

@property (nonatomic, assign) CGFloat valueSum;

@property (nonatomic, assign) CGPoint arcCenter;

@property (nonatomic, assign) CGFloat startAngle;

@property (nonatomic, assign) CGFloat endAngle;

@property (nonatomic, assign) NSUInteger currentAnimationIndex;

@property (nonatomic, strong) NSMutableArray *shapeLayers;

@end


@implementation YLBPieChartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initializeVariable];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource {
    self = [super initWithFrame:frame];
    [self initializeVariable];
    self.dataSource = dataSource;
    return self;
}

- (void)initializeVariable {
    self.duration = kDefaultDuration;
    self.lineWidth = (self.frame.size.width / 2) * kDefaultLineWidthPercent;
}

- (NSMutableArray *)shapeLayers {
    if (_shapeLayers == nil) {
        _shapeLayers = [NSMutableArray array];
    }
    return _shapeLayers;
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
    self.endAngle = self.startAngle + ([model.value floatValue] / self.valueSum) * M_PI * 2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter
                                                        radius:self.frame.size.width/2
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
    basicAnimation.duration = [model.value floatValue] / self.valueSum * self.duration;
    basicAnimation.delegate = [[WeakProxy alloc] initWithTarget:self];
    [shapeLayer addAnimation:basicAnimation forKey:@"strokeEnd"];
    
    [self.shapeLayers addObject:shapeLayer];
}

- (void)animation {
    
    [self cleanAndCalc];
    
    [self setMaskLayer];
    
    // 开启第一个动画
    if (self.dataSource.count > 0) {
        [self addLayoutAnimation:0];
    }
}

// 清除上次动画的现场，并计算出绘制需要的值
- (void)cleanAndCalc {
    
    NSArray *labels = [NSArray arrayWithArray:self.subviews];
    for (UILabel *label in labels) {
        [label removeFromSuperview];
    }
    
    for (CAShapeLayer *shapeLayer in self.shapeLayers) {
        [shapeLayer removeFromSuperlayer];
    }
    
    self.startAngle = -M_PI_2;
    self.endAngle = -M_PI_2;
    self.arcCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    self.valueSum = [[self.dataSource valueForKeyPath:@"@sum.value.floatValue"] floatValue];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSUInteger next = self.currentAnimationIndex + 1;
    
    if (next < self.dataSource.count) {
        [self addLayoutAnimation:next];
    } else if (self.totalValue != nil) { // 扇形绘制完毕，显示总金额
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 2 * self.lineWidth, 30.0f)];
        descLabel.center  = CGPointMake(self.frame.size.width / 2.0f , self.frame.size.height / 2.0f - 15.0f);
        descLabel.text = self.totalDesc;
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.textColor = [UIColor lightGrayColor];
        descLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:descLabel];
        
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 2 * self.lineWidth, 30.0f)];
        valueLabel.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f + 15.0f);
        valueLabel.text = [NSString stringWithFormat:@"%0.2f", [self.totalValue floatValue]];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.textColor = [UIColor lightGrayColor];
        valueLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:valueLabel];
    }
}

@end

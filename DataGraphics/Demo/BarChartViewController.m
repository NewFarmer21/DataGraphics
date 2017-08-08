//
//  BarChartViewController.m
//  ArcCenter
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "BarChartViewController.h"
#import "YLBBarChartView.h"
#import "YLBChartModel.h"
#import "UIColor+SrandColor.h"

@interface BarChartViewController ()

@property (nonatomic, strong) YLBBarChartView *barGraphView;

@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildBarChartView];
}

- (void)buildBarChartView {
    
    NSMutableArray *models = [NSMutableArray array];
    YLBChartModel *model1 = [[YLBChartModel alloc] initWithValue:[self arc4randomNumber]
                                                           color:[UIColor srand_color]];
    [models addObject:model1];
    
    YLBChartModel *model2 = [[YLBChartModel alloc] initWithValue:[self arc4randomNumber]
                                                           color:[UIColor srand_color]];
    [models addObject:model2];
    
    YLBChartModel *model3 = [[YLBChartModel alloc] initWithValue:[self arc4randomNumber]
                                                           color:[UIColor srand_color]];
    [models addObject:model3];
    
    YLBChartModel *model4 = [[YLBChartModel alloc] initWithValue:[self arc4randomNumber]
                                                           color:[UIColor srand_color]];
    [models addObject:model4];
    
    YLBBarChartView *barGraphView =
    [[YLBBarChartView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20.0f, 400)
                                    models:models
                                  maxValue:500.0f];
    
    [self.view addSubview:barGraphView];
    
    self.barGraphView = barGraphView;
}

- (NSNumber *)arc4randomNumber {
    
    int agree = arc4random() % 4;
    
    NSNumber *nubmer;
    if (agree == 0) {
        nubmer = [NSNumber numberWithInt: (-1) * (arc4random() % 500)];
    } else {
        nubmer = [NSNumber numberWithInt: arc4random() % 500];
    }
    
    return nubmer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.barGraphView removeFromSuperview];
    [self buildBarChartView];
}

@end

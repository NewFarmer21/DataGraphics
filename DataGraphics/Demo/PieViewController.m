//
//  PieViewController.m
//  PieViewController
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "PieViewController.h"
#import "YLBPieChartView.h"
#import "YLBChartModel.h"
#import "UIColor+SrandColor.h"

@interface PieViewController ()

@property (nonatomic, strong) YLBPieChartView *arcView;

@end

@implementation PieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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

    
    YLBPieChartView *arcView = [[YLBPieChartView alloc] initWithFrame:CGRectMake(50, 100, 300, 300) dataSource:models];
    [self.view addSubview:arcView];
    
    self.arcView = arcView;
  
    
    [arcView animation];
}

- (NSNumber *)arc4randomNumber {
    
    NSNumber *nubmer = [NSNumber numberWithInt: arc4random() % 500];
    
    return nubmer;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self.arcView animation];
}



@end

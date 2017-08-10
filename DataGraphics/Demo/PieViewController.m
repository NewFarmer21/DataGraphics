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
    
    YLBPieChartView *arcView = [[YLBPieChartView alloc] initWithFrame:CGRectMake(50, 100, 300, 300)];
    arcView.lineWidth = 20.0f;
    arcView.duration = 1.0f;
    [self.view addSubview:arcView];
    
    self.arcView = arcView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSMutableArray *models = [NSMutableArray array];
    
    for (int i=0; i<6; i++) {
        [models addObject:[self arc4randomModel]];
    }
    
    self.arcView.totalDesc = @"总金额(元)";
    self.arcView.totalValue = [models valueForKeyPath:@"@sum.value.floatValue"];
    self.arcView.dataSource = models;
    
    [self.arcView animation];
}

- (NSNumber *)arc4randomNumber {
    
    NSNumber *nubmer = [NSNumber numberWithInt: arc4random() % 500];
    
    return nubmer;
}

- (YLBChartModel *)arc4randomModel {
    YLBChartModel *model = [[YLBChartModel alloc] initWithValue:[self arc4randomNumber]
                                                           color:[UIColor srand_color]];
    return model;
}

@end

//
//  lineChartViewController.m
//  DataGraphics
//
//  Created by 党国 on 2017/8/8.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "lineChartViewController.h"
#import "YLBLineChartView.h"

@interface lineChartViewController ()

@end

@implementation lineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i=0; i<30; i++) {
        YLBLineChartModel *model1 = [[YLBLineChartModel alloc] init];
        model1.value = [NSNumber numberWithFloat:(arc4random() % 28) / 9.0f];
        model1.date = [[NSDateComponents alloc] init];
        model1.date.year = 2017;
        model1.date.month = 7;
        model1.date.day = 8;
        
        [array addObject:model1];
    }

    
    YLBLineChartView *view = [[YLBLineChartView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 150) data:array];
    
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

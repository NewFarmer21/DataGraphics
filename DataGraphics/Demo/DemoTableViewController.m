//
//  DemoTableViewController.m
//  ArcCenter
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "DemoTableViewController.h"
#import "UITableViewProtocol.h"
#import "DemoObject.h"
#import "DemoTableViewCell.h"
#import "BarChartViewController.h"
#import "PieViewController.h"
#import "lineChartViewController.h"

@interface DemoTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UITableViewProtocol *protocol;

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildDataSource];

    __weak typeof(DemoTableViewController) *weakSelf = self;
    self.protocol =
        [[UITableViewProtocol alloc] initWithTableView:self.tableView
                                            dataSource:self.dataSource
                                             cellClass:[DemoTableViewCell class]
                                        didSelectBlock:^(NSIndexPath *indexPath) {
                                            [weakSelf didSelectedAtIndex:indexPath];
                                        }];
}

- (void)buildDataSource {
    __weak typeof(DemoTableViewController) *weakSelf = self;
    DemoObject *obj1 = [[DemoObject alloc] initWithText:@"柱状图" block:^(NSIndexPath *indexPath) {
        [weakSelf pushToBarViewController];
    }];
    
    DemoObject *obj2 = [[DemoObject alloc] initWithText:@"饼图" block:^(NSIndexPath *indexPath) {
        [weakSelf pushToArcViewController];
    }];
    
    
    DemoObject *obj3 = [[DemoObject alloc] initWithText:@"折线图" block:^(NSIndexPath *indexPath) {
        [weakSelf pushToLineChartViewController];
    }];
    
    self.dataSource = [NSMutableArray arrayWithObjects:obj1, obj2, obj3, nil];
}

- (void)pushToBarViewController {
    
    BarChartViewController *vc = [[BarChartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushToArcViewController {
    
    PieViewController *vc = [[PieViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushToLineChartViewController {
    lineChartViewController *vc = [[lineChartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectedAtIndex:(NSIndexPath *)indexPath {
    DemoObject *object = self.dataSource[indexPath.row];
    object.block(indexPath);
}
@end

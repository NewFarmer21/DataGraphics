//
//  UITableViewProtocol.h
//  UITableViewProtocolDemo
//
//  Created by 新时代农民工 on 2017/4/12.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectBlock)(NSIndexPath *indexPath);

@interface UITableViewProtocol : NSObject

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) Class cellClass;

@property (nonatomic, copy)   DidSelectBlock didSelectBlock;

- (instancetype)initWithTableView:(UITableView *)tableView
                       dataSource:(NSArray *)dataSource
                        cellClass:(Class)cellClass
                   didSelectBlock:(DidSelectBlock)didSelectBlock;

@end

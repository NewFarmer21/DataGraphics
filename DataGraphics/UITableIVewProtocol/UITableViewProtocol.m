//
//  UITableViewProtocol.m
//  UITableViewProtocolDemo
//
//  Created by 新时代农民工 on 2017/4/12.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "UITableViewProtocol.h"
#import <objc/message.h>

@interface UITableViewProtocol () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation UITableViewProtocol

- (instancetype)initWithTableView:(UITableView *)tableView
                       dataSource:(NSArray *)dataSource
                        cellClass:(Class)cellClass
                   didSelectBlock:(void (^)(NSIndexPath *indexPath))didSelectBlock
{
    self = [super init];
    if (!self) return nil;
    
    self.dataSource = dataSource;
    self.cellClass = cellClass;
    self.didSelectBlock = didSelectBlock;
    
    [tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.cellClass) forIndexPath:indexPath];
    
    [cell performSelector:@selector(setModel:) withObject:self.dataSource[indexPath.row]];
     
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectBlock) {
        self.didSelectBlock(indexPath);
    }
}

@end

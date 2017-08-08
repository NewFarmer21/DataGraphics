//
//  DemoObject.h
//  ArcCenter
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewProtocol.h"

@interface DemoObject : NSObject

@property (nonatomic, strong) NSString *text;

@property (nonatomic, copy) DidSelectBlock block;

- (instancetype)initWithText:(NSString *)text block:(DidSelectBlock) block;

@end

//
//  DemoObject.m
//  ArcCenter
//
//  Created by 党国 on 2017/8/4.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import "DemoObject.h"

@implementation DemoObject


- (instancetype)initWithText:(NSString *)text block:(DidSelectBlock) block {
    self = [super init];
    
    self.text = text;
    self.block = block;
    
    return self;
}

@end

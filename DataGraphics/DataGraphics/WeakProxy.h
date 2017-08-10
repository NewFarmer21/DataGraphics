//
//  WeakProxy.h
//  DataGraphics
//
//  Created by 党国 on 2017/8/10.
//  Copyright © 2017年 dangguo.github.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakProxy : NSObject

- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END

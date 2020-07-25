//
//  OneToManyDelegateArrayMediator32.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  采用消息转发处理解决每个协议都得重新处理一遍

#import <Foundation/Foundation.h>
#import "TSDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface OneToManyDelegateArrayMediator32 : NSObject <TSDelegate>

@property (nonatomic, readonly) NSPointerArray *delegates;

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END

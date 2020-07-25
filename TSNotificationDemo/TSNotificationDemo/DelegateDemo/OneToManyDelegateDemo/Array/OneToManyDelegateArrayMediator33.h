//
//  OneToManyDelegateArrayMediator33.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  采用传递Protocol等参数解决每个协议都得重新处理一遍，并且同时解决了本文件原本需要#import "TSDelegate.h"问题

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OneToManyDelegateArrayMediator33 : NSObject

@property (nonatomic, readonly) NSPointerArray *delegates;

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;

- (void)broadcastProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector responder:(void (^_Nonnull)(id _Nonnull delegateReceiver))block;

@end

NS_ASSUME_NONNULL_END

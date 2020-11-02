//
//  OneToManyDelegateHashMediator33.h
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneToManyDelegateHashMediator33 : NSObject

@property (nonatomic, strong, readonly) NSHashTable *hashTable;

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;

///**
// 发送广播，同步串行。
//
// @param protocol 要发送的广播协议
// @param selector 广播协议对应的 selector，会自动判断监听者是否实现 selector。selector 会自动为 block 参数过滤掉不响应的 listener，如果 selector 传入 nil，则 block 会被全量执行。
// @param block 执行 selector 的 block
// */
- (void)broadcastProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector responder:(void (^_Nonnull)(id _Nonnull delegateReceiver))block;

@end

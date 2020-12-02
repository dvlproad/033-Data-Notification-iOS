//
//  CJProtocolCenter.m
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJProtocolCenter.h"
#import <objc/runtime.h>

@interface CJProtocolCenter ()

@property (nonatomic, strong, readonly) NSMutableSet *listenerLists;

@end

@implementation CJProtocolCenter

/*
 取默认广播中心对象

 @return CJProtocolCenter
 */
+ (instancetype)defaultCenter {
    static CJProtocolCenter *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _listenerLists = [NSMutableSet set];
    }
    return self;
}

/*
 添加监听者。如果监听者要求回调方法要异步执行，请在各自的回调方法中自行实现异步功能。

 @param listener    要添加的监听者，监听者必须实现 protocol 参数的协议。
 @param protocol    要监听的广播协议
 */
- (void)addListener:(id _Nonnull)listener forProtocol:(Protocol * _Nonnull)protocol {
    NSAssert(listener, @"listener is nil");
    NSAssert(protocol, @"Protocol is nil");
#ifdef DEBUG
    NSAssert([listener conformsToProtocol:protocol], @"This listener does not conform to the protocol");
#endif
    
    @synchronized(protocol) {
        NSHashTable *table = [self __unsafe_listenersForProtocol:protocol autoCreate:YES];
        if (![table containsObject:listener]) {
            [table addObject:listener];
        }
    }
}

/*
 移除监听者，停止监听，

 @param listener    要移除的监听者
 @param protocol    要停止监听的广播协议，传入 nil 则表示移除这个监听者的所有监听。
 */
- (void)removeListener:(id _Nonnull)listener forProtocol:(Protocol * _Nullable)protocol {
    NSAssert(listener, @"listener is nil");
    
    @synchronized(protocol) {
        if (protocol) {
            NSHashTable *table = [self __unsafe_listenersForProtocol:protocol autoCreate:NO];
            if ([table containsObject:listener]) {
                [table removeObject:listener];
            }
        } else {
            for (NSMutableArray *table in self.listenerLists) {
                if ([table containsObject:listener]) {
                    [table removeObject:listener];
                }
            }
        }
    }
}

/*
 发送广播，同步串行。让protocol的监听者们执行block方法（参数selector必须与block的方法相对应，用于在执行block前判断该protoco监听者是否能够执行该方法）

 @param protocol    要发送的广播协议
 @param selector    广播协议对应的 selector，会自动判断监听者是否实现 selector。selector 会自动为 block 参数过滤掉不响应的 listener，如果 selector 传入 nil，则 block 会被全量执行。
 @param block       执行 selector 的 block
 */
- (void)broadcastProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector responder:(void (^_Nonnull)(id _Nonnull listener))block {
    NSAssert(protocol, @"Protocol is nil.");
    NSAssert(block, @"Block is nil.");
    
    NSArray *table = nil;
    @synchronized(protocol) {
        table = [self __unsafe_listenersForProtocol:protocol autoCreate:NO].allObjects;
    }
    for (id listener in table) {
        if (!selector || [listener respondsToSelector:selector]) {
            block(listener);
        }
    }
}

static void *CJ_BROADCAST_PROTOCOL_LISTENER = &CJ_BROADCAST_PROTOCOL_LISTENER;
- (NSHashTable *)__unsafe_listenersForProtocol:(Protocol *)protocol autoCreate:(BOOL)autoCreate {
    NSHashTable *array = objc_getAssociatedObject(protocol, CJ_BROADCAST_PROTOCOL_LISTENER);
    if (!array && autoCreate) {
        array = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        @synchronized (self.listenerLists) {
            [self.listenerLists addObject:array];
        }
        objc_setAssociatedObject(protocol, CJ_BROADCAST_PROTOCOL_LISTENER, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return array;
}

@end

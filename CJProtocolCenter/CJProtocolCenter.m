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

@property (nonatomic, strong, readonly) NSMutableSet<NSHashTable *> *listenerLists; // 保存多个NSHashTable，可以理解为数组的数组，里面的元素是 NSHashTable *listeners

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

#pragma mark - 添加监听者
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
        NSHashTable *listeners = [self __unsafe_listenersForProtocol:protocol autoCreate:YES];
        if (![listeners containsObject:listener]) {
            [listeners addObject:listener];
        }
    }
}

#pragma mark - 发送广播
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

#pragma mark - 停止/移除监听者
/*
 让监听者停止对指定协议的监听

 @param listener    要操作的监听者
 @param protocol    要停止监听的广播协议
 */
- (void)removeListener:(id _Nonnull)listener forProtocol:(Protocol * _Nonnull)protocol {
    NSAssert(listener, @"listener is nil");
    NSAssert(protocol, @"Protocol is nil.");
    
    @synchronized(protocol) {
        NSHashTable *listeners = [self __unsafe_listenersForProtocol:protocol autoCreate:NO]; // 找到之前绑定到这个protocal上的监听者列表
        if (listeners && [listeners containsObject:listener]) {
            [listeners removeObject:listener];
        }
    }
}

/*
 移除指定的监听者，使其不再监听

 @param listener    要移除的监听者
 */
- (void)removeListenerForAllProtocol:(id _Nonnull)listener {
    @synchronized(self) {
        for (NSHashTable *table in self.listenerLists) {
            if (table && [table containsObject:listener]) {
                [table removeObject:listener];
            }
        }
    }
}

/*
 *  删除所有监听者
 *  @note   用于：有些视图控制器你因为循环引用的无法正常remove监听的时候，临时采用在退出登录的时候调用此方法
 */
- (void)removeAllListener {
    @synchronized(self) {
        for (NSHashTable *table in self.listenerLists) {
            for (id listener in table) {
                [table removeObject:listener];
            }
        }
    }
}
 
/*
 *  删除所有监听protocol的监听者
 *  @note   用于：有些视图控制器你因为循环引用的无法正常remove监听的时候，临时采用在退出登录的时候调用此方法
 *
 *  @param protocol     对象包含的监听广播协议
 */
- (void)removeAllListenerWhichConformsToProtocol:(Protocol * _Nonnull)protocol {
    NSAssert(protocol, @"Protocol is nil.");
    
    @synchronized(protocol) {
        for (NSHashTable *listeners in self.listenerLists) {
            //NSMutableArray *shouldRemoveListeners = [[NSMutableArray alloc] init];
            NSHashTable *shouldRemoveListeners = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory]; // 为了和
            for (id listener in listeners) {
                if ([listener conformsToProtocol:protocol]) {
                    [shouldRemoveListeners addObject:listener];
                }
            }
            [self __hashTable:listeners removeListeners:shouldRemoveListeners];
        }
    }
}


#pragma mark - Private Method
static void *CJ_BROADCAST_PROTOCOL_LISTENER = &CJ_BROADCAST_PROTOCOL_LISTENER;
// 找到之前绑定到这个protocal上的监听者列表
- (NSHashTable *)__unsafe_listenersForProtocol:(Protocol *)protocol autoCreate:(BOOL)autoCreate {
    NSHashTable *listeners = objc_getAssociatedObject(protocol, CJ_BROADCAST_PROTOCOL_LISTENER); // 找到之前绑定到这个protocal上的监听者列表。好处：查找的时候可直接得到结果
    if (!listeners && autoCreate) { // 如果这个protocal还还没监听者，且允许创建，则创建一个监听者列表，用于等下返回添加监听者
        listeners = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        @synchronized (self.listenerLists) {
            [self.listenerLists addObject:listeners];
        }
        objc_setAssociatedObject(protocol, CJ_BROADCAST_PROTOCOL_LISTENER, listeners, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return listeners;
}

/*
 *  从哈希表hashTable中删除指定数据
 *
 *  @param removeListeners 要删除的数据
 */
- (void)__hashTable:(NSHashTable *)hashTable removeListeners:(NSHashTable *)removeListeners {
    //NSLog(@"删除前的table = %@", table);
    for (id shouldRemoveListener in removeListeners) {
        [hashTable removeObject:shouldRemoveListener];
    }
//    [hashTable removeObjectsInArray:shouldRemoveListeners]; // 不要使用removeObjectsInArray。因为NSHashTable无removeObjectsInArray方法
    //NSLog(@"删除后的table = %@", table);
}

@end

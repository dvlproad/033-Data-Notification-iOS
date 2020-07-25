//
//  CJProtocolCenter.m
//  ProtocolNotification
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

- (void)addListener:(id __nonnull)listener forProtocol:(Protocol * _Nonnull )protocol {
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

- (void)removeListener:(id __nonnull)listener forProtocol:(Protocol * __nullable)protocol {
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

- (void)broadcastProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector responder:(void (^_Nonnull)(id listener))block {
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

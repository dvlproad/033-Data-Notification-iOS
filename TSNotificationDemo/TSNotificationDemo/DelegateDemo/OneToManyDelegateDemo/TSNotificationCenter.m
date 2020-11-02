//
//  TSNotificationCenter.m
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TSNotificationCenter.h"

@interface TSNotificationCenter ()

@property (nonatomic, strong, readonly) NSHashTable *hashTable;

@end

@implementation TSNotificationCenter

+ (instancetype)defaultCenter {
    static TSNotificationCenter *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)addDelegate:(id __nonnull)listener forProtocol:(Protocol * _Nonnull )protocol {
    NSAssert(listener, @"listener is nil");
    NSAssert(protocol, @"Protocol is nil");
#ifdef DEBUG
    NSAssert([listener conformsToProtocol:protocol], @"This listener does not conform to the protocol");
#endif
    
    @synchronized(protocol) {
        [self.hashTable addObject:listener];
    }
}

- (void)removeDelegate:(id __nonnull)listener forProtocol:(Protocol * __nullable)protocol {
    NSAssert(listener, @"listener is nil");
    
    @synchronized(protocol) {
        [self.hashTable removeObject:listener];
    }
}

- (void)broadcastProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector responder:(void (^_Nonnull)(id delegateReceiver))block {
    NSAssert(protocol, @"Protocol is nil.");
    NSAssert(block, @"Block is nil.");
    
    for (id delegateReceiver in self.hashTable) {
        if (![delegateReceiver conformsToProtocol:protocol]) {  // 处理多个protocal中有同名方法,通过传进来的protocol参数，我们在判断接收者有我们想要的方法前，先找到有实现我们想要协议的那个接收者
            continue;
        }
        if (!selector || [delegateReceiver respondsToSelector:selector]) {
            block(delegateReceiver);
        }
    }
}

@end

//
//  OneToManyDelegateHashMediator33.m
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "OneToManyDelegateHashMediator33.h"

@interface OneToManyDelegateHashMediator33 ()

@end

@implementation OneToManyDelegateHashMediator33

- (instancetype)init {
    self = [super init];
    if (self) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)addDelegate:(id)delegate {
    [_hashTable addObject:delegate];
}

- (void)removeDelegate:(id)delegate {
    [_hashTable removeObject:delegate];
}


#pragma mark - TSDelegate
//- (void)delegate_didUpdateLoginState:(BOOL)loginState {
//    for (id delegate in self.hashTable) {
//        if (delegate && [delegate respondsToSelector:@selector(delegate_didUpdateLoginState:)]) {
//            [delegate delegate_didUpdateLoginState:YES];
//        }
//    }
//} 
- (void)broadcastProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector responder:(void (^_Nonnull)(id _Nonnull delegateReceiver))block {
    NSAssert(protocol, @"Protocol is nil.");
    NSAssert(block, @"Block is nil.");
    
    for (id delegateReceiver in self.hashTable) {
        if (!selector || [delegateReceiver respondsToSelector:selector]) {
            block(delegateReceiver);
        }
    }
}

@end

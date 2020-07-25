//
//  OneToManyDelegateArrayMediator33.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "OneToManyDelegateArrayMediator33.h"

@implementation OneToManyDelegateArrayMediator33

- (instancetype)init {
    self = [super init];
    if (self) {
        _delegates = [NSPointerArray weakObjectsPointerArray];
    }
    return self;
}

- (void)addDelegate:(id)delegate {
    [_delegates addPointer:(__bridge void*)delegate];
}

- (void)removeDelegate:(id)delegate {
    NSUInteger index = [self __indexOfDelegate:delegate];
    if (index != NSNotFound) {
        [_delegates removePointerAtIndex:index];
    }
    [_delegates compact];
    // 注意 [_delegates compact]，这个方法可以帮助你去掉数组里面的野指针，避免你在快速遍历的时候拿到一个指向不存在对象的地址
}

#pragma mark - Private Method
- (NSUInteger)__indexOfDelegate:(id)delegate {
    for (NSUInteger i = 0; i < _delegates.count; i += 1) {
        if ([_delegates pointerAtIndex:i] == (__bridge void*)delegate) {
          return i;
        }
    }
    return NSNotFound;
}




#pragma mark - TSDelegate
//- (void)delegate_didUpdateLoginState:(BOOL)loginState {
//    for (NSUInteger i = 0; i < self.delegates.count; i++) {
//        id delegate = (__bridge id)[self.delegates pointerAtIndex:i];
//        if (delegate && [delegate respondsToSelector:@selector(delegate_didUpdateLoginState:)]) {
//            [delegate delegate_didUpdateLoginState:YES];
//        }
//    }
//}
- (void)broadcastProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector responder:(void (^_Nonnull)(id _Nonnull delegateReceiver))block {
    NSAssert(protocol, @"Protocol is nil.");
    NSAssert(block, @"Block is nil.");
    
    for (NSUInteger i = 0; i < self.delegates.count; i++) {
        id delegateReceiver = (__bridge id)[self.delegates pointerAtIndex:i];
        if (!selector || [delegateReceiver respondsToSelector:selector]) {
            block(delegateReceiver);
        }
    }
}

@end

//
//  OneToManyDelegateArrayMediator32.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "OneToManyDelegateArrayMediator32.h"

@implementation OneToManyDelegateArrayMediator32

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
//多播的delegate与通常的delegate不同，multiDelegate并没有实现协议中的方法，而是将协议中的方法转发到自己delegate链中的对象。   对multiDelegate对象调用test1方法时，由于GCDMulticastDelegate没有实现test1方法，因此该类的forwardInvocation函数会被触发，在该函数中会遍历delegate链，对每一个delegate对象调用test1方法，从而实现了多个delegate。同时，在对multiDelegate调用协议方法时，采用的是异步的方式，协议方法会立刻返回，不会阻碍当前函数。
//- (void)delegate_didUpdateLoginState:(BOOL)loginState {
//    for (NSUInteger i = 0; i < self.delegates.count; i++) {
//        id delegate = (__bridge id)[self.delegates pointerAtIndex:i];
//        if (delegate && [delegate respondsToSelector:@selector(delegate_didUpdateLoginState:)]) {
//            [delegate delegate_didUpdateLoginState:YES];
//        }
//    }
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (signature) {
        return signature;
    }
    [_delegates compact];   //注意 [_delegates compact]，这个方法可以帮助你去掉数组里面的野指针，避免你在快速遍历的时候拿到一个指向不存在对象的地址
    for (id delegate in _delegates) {
        if (!delegate) {
          continue;
        }
        signature = [delegate methodSignatureForSelector:aSelector];
        if (signature) {
          break;
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    BOOL responded = NO;
    for (id delegate in _delegates) {
        if (delegate && [delegate respondsToSelector:selector]) {
            [anInvocation invokeWithTarget:delegate];
            responded = YES;
        }
    }
    if (!responded) {
        [self doesNotRecognizeSelector:selector];
    }
}

@end

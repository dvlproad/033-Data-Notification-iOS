//
//  CJProtocolCenter+Module.m
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/4/12.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "CJProtocolCenter+Module.h"
#import "CJProtocolCenter+Private.h"

@implementation CJProtocolCenter (Module)

#pragma mark - A模块中调用B模块中的方法 / A模块让B执行某个方法
/*
 添加模块，以允许其他模块能够调用此模块中的方法，如跳转到此模块

 @param module      要添加的模块，模块必须实现 protocol 参数的协议。
 @param protocol    要监听的广播协议
 */
+ (void)addModule:(id _Nonnull)module forProtocol:(Protocol * _Nonnull)protocol {
    [[CJProtocolCenter defaultCenter] addListener:module forProtocol:protocol];
}

/*
 遍历找到符合条件的模块，并让其执行block方法（参数selector必须与block的方法相对应，用于在执行block前判断该protoco监听者是否能够执行该方法）
 eg: B模块传入参数，让登录模块执行goLoginPage
 @使用场地：一般用在要跳转到其他模块页面,监听者为xxxModuleImpl单例

 @param protocol    要发送的广播协议
 @param selector    广播协议对应的 selector，会自动判断监听者是否实现 selector。selector 会自动为 block 参数过滤掉不响应的 listener，如果 selector 传入 nil，则 block 会被全量执行。
 @param block       执行 selector 的 block
 */
+ (void)broadcastOtherModuleWhichConformsToProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector execHandle:(void (^_Nonnull)(id _Nonnull listener))block {
    NSAssert(protocol, @"Protocol is nil.");
    NSAssert(block, @"Block is nil.");
    
    NSArray *modules = nil;
    @synchronized(protocol) {
        modules = [[CJProtocolCenter defaultCenter] __unsafe_listenersForProtocol:protocol autoCreate:NO].allObjects;
    }
    NSAssert(modules.count <= 1, @"要执行 selector 的 modules 至多只能有一个.");
    for (id module in modules) {
        //[module selectorWithObject1:xxx object2:yyy]; eg: OrderHomeViewController 的 goLoginPage
//        if ([module isKindOfClass:[NSObject class]]) {
//            [(NSObject *)module performSelector:selector target:listener argument:nil order:0 modes:[NSRunLoopCommonModes]];
//        }
        if (!selector || [module respondsToSelector:selector]) {
            block(module);
        }
    }
}


#pragma mark - a业务通知所有b业务更新(a、b业务可在不同模块）
/*
 添加监听者。如果监听者要求回调方法要异步执行，请在各自的回调方法中自行实现异步功能。

 @param listener    要添加的监听者，监听者必须实现 protocol 参数的协议。
 @param protocol    要监听的广播协议
 */
+ (void)addListener:(id _Nonnull)listener forProtocol:(Protocol * _Nonnull)protocol {
    [[CJProtocolCenter defaultCenter] addListener:listener forProtocol:protocol];
}

/*
 移除这个监听者的所有监听

 @param listener    要移除的监听者
 */
+ (void)removeListenerForAllProtocol:(id _Nonnull)listener {
    [[CJProtocolCenter defaultCenter] removeListener:listener forProtocol:nil];
}

/*
 遍历找到符合条件的所有监听者，并让其执行block方法（参数selector必须与block的方法相对应，用于在执行block前判断该protoco监听者是否能够执行该方法）
 eg: 用户UserService传出新的userName，并让所有监听用户状态变化的键停止执行userNameUpdate
 @使用场地：一般用在Service管理层，如用户管理层发现用户登录状态变化,监听者一般为xxxViewController

 @param protocol    要发送的广播协议
 @param selector    广播协议对应的 selector，会自动判断监听者是否实现 selector。selector 会自动为 block 参数过滤掉不响应的 listener，如果 selector 传入 nil，则 block 会被全量执行。
 @param block       执行 selector 的 block
 */
+ (void)broadcastAllListenersWhichConformsToProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector execHandle:(void (^_Nonnull)(id _Nonnull listener))block {
//    [[CJProtocolCenter defaultCenter] broadcastProtocol:protocol selector:selector responder:block];
    NSAssert(protocol, @"Protocol is nil.");
    NSAssert(block, @"Block is nil.");
    
    NSArray *listeners = nil;
    @synchronized(protocol) {
        listeners = [[CJProtocolCenter defaultCenter] __unsafe_listenersForProtocol:protocol autoCreate:NO].allObjects;
    }
    for (id listener in listeners) {
//        if ([listener isKindOfClass:[NSObject class]]) {
//            [(NSObject *)listener performSelector:selector target:listener argument:nil order:0 modes:[NSRunLoopCommonModes]];
//        }
        if (!selector || [listener respondsToSelector:selector]) {
            block(listener);
        }
    }
}

@end

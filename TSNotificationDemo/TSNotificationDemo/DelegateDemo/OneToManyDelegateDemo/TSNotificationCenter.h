//
//  TSNotificationCenter.h
//  ProtocolNotification
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TSNotificationCenter : NSObject

/**
 取默认广播中心对象

 @return TSNotificationCenter
 */
+ (instancetype _Nonnull)defaultCenter;


/**
 添加监听者。如果监听者要求回调方法要异步执行，请在各自的回调方法中自行实现异步功能。

 @param listener 要添加的监听者，监听者必须实现 protocol 参数的协议。
 @param protocol 要监听的广播协议
 */
- (void)addDelegate:(id _Nonnull)listener forProtocol:(Protocol * _Nonnull)protocol;


/**
 移除监听者，停止监听，

 @param listener 要移除的监听者
 @param protocol 要停止监听的广播协议，传入 nil 则表示移除这个监听者的所有监听。
 */
- (void)removeDelegate:(id _Nonnull)listener forProtocol:(Protocol * _Nullable)protocol;


/**
 发送广播，同步串行。

 @param protocol 要发送的广播协议
 @param selector 广播协议对应的 selector，会自动判断监听者是否实现 selector。selector 会自动为 block 参数过滤掉不响应的 listener，如果 selector 传入 nil，则 block 会被全量执行。
 @param block 执行 selector 的 block
 */
- (void)broadcastProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector responder:(void (^_Nonnull)(id _Nonnull delegateReceiver))block;

@end

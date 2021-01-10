//
//  CJProtocolCenter.h
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CJProtocolCenter : NSObject

/*
 取默认广播中心对象

 @return CJProtocolCenter
 */
+ (instancetype _Nonnull)defaultCenter;


#pragma mark - 添加监听者
/*
 添加监听者。如果监听者要求回调方法要异步执行，请在各自的回调方法中自行实现异步功能。

 @param listener    要添加的监听者，监听者必须实现 protocol 参数的协议。
 @param protocol    要监听的广播协议
 */
- (void)addListener:(id _Nonnull)listener forProtocol:(Protocol * _Nonnull)protocol;


#pragma mark - 发送广播
/*
 发送广播，同步串行。让protocol的监听者们执行block方法（参数selector必须与block的方法相对应，用于在执行block前判断该protoco监听者是否能够执行该方法）
 * @note 容易出现的异常bug:通知发送多遍，此时可能是你同一个控制器注册多次，比如退出或者返回时候【忘记移除】或者【因为循环引用无法移除成功】该控制器监听，再进入时候又重新添加监听。而导致你的对数据层的操作变成了多次

 @param protocol    要发送的广播协议
 @param selector    广播协议对应的 selector，会自动判断监听者是否实现 selector。selector 会自动为 block 参数过滤掉不响应的 listener，如果 selector 传入 nil，则 block 会被全量执行。
 @param block       执行 selector 的 block
 */
- (void)broadcastProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector responder:(void (^_Nonnull)(id _Nonnull listener))block;



#pragma mark - 移除监听者
/*
 移除监听者，停止监听，

 @param listener    要移除的监听者
 @param protocol    要停止监听的广播协议，传入 nil 则表示移除这个监听者的所有监听。
 */
- (void)removeListener:(id _Nonnull)listener forProtocol:(Protocol * _Nullable)protocol;

/*
 *  删除所有监听者
 *  @note   用于：有些视图控制器你因为循环引用的无法正常remove监听的时候，临时采用在退出登录的时候调用此方法
 */
- (void)removeAllListener;
 
/*
 *  删除所有监听protocol的监听者
 *  @note   用于：有些视图控制器你因为循环引用的无法正常remove监听的时候，临时采用在退出登录的时候调用此方法
 *
 *  @param protocol     对象包含的监听广播协议
 */
- (void)removeAllListenerWhichConformsToProtocol:(Protocol * _Nonnull)protocol;

@end

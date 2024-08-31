//
//  CQModuleHelper.m
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQModuleHelper.h"
#import <CJProtocolCenter/CJProtocolCenter+Module.h>
#import <TSModulePublic/CJUserServiceProtocolForModule.h>
#import <TSModulePublic/LoginModulePublic.h>
#import <TSModulePublic/OrderModulePublic.h>

@implementation CQModuleHelper

#pragma mark - 通知
+ (void)noti_didUpdateLoginState:(BOOL)loginState {
    // 1、登录成功后，其他页面登录状态更新(一般用在Service管理层，如用户管理层发现用户登录状态变化,监听者一般为xxxViewController）
    [CJProtocolCenter broadcastAllListenersWhichConformsToProtocol:@protocol(CJUserServiceProtocolForModule)
                                                          selector:@selector(userDelegate_didUpdateLoginState:)
                                                        execHandle:^(id<CJUserServiceProtocolForModule> listener) {
        [listener userDelegate_didUpdateLoginState:YES];
    }];
    // 要让调用者实现上述方法，则调用者必须在初始化的时候监听指定的协议
    // [CJProtocolCenter addListener:self forProtocol:@protocol(CJUserServiceProtocolForModule)];
    // 销毁的时候记得移除，因为会被通知执行此方法的基本为xxxViewController
    // [CJProtocolCenter removeListenerForAllProtocol:self];
}

#pragma mark - 跳转
+ (void)goOrderHomePage:(int)pageType {
    // 2、登录成功，跳转到其他模块的其他页面（一般用在要跳转到其他模块页面,监听者为xxxModuleImpl单例）
    [CJProtocolCenter broadcastOtherModuleWhichConformsToProtocol:@protocol(OrderModulePublic) selector:@selector(orderModule_goOrderHomePage:) execHandle:^(id<OrderModulePublic>  _Nonnull listener) {
        [listener orderModule_goOrderHomePage:pageType];
    }];
    // 要让调用者实现上述方法，则调用者必须在初始化的时候监听指定的协议
    // [CJProtocolCenter addModule:self forProtocol:@protocol(OrderModulePublic)];
}

+ (void)goLoginPage:(BOOL)loginState {
    [CJProtocolCenter broadcastOtherModuleWhichConformsToProtocol:@protocol(LoginModulePublic) selector:@selector(loginModule_goLoginPage:) execHandle:^(id<LoginModulePublic>  _Nonnull listener) {
        [listener loginModule_goLoginPage:loginState];
    }];
}


@end

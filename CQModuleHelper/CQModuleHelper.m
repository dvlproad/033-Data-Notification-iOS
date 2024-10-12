//
//  CQModuleHelper.m
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQModuleHelper.h"
#import <CJProtocolCenter/CJProtocolCenter+Module.h>
#import <TSModulePublic/CJUserServicePublic.h>
#import <TSModulePublic/LoginModulePublic.h>
#import <TSModulePublic/OrderModulePublic.h>

@implementation CQModuleHelper

#pragma mark - 管理数据变化+内部通知
+ (void)loginSuccessWithMap:(NSDictionary *)dict {
    // 1、登录成功后，更新数据到用户数据Service管理类中，并在用户数据管理类中根据数据变化进行其他相应的通知其他页面登录状态更新
    [CJProtocolCenter broadcastOtherModuleWhichConformsToProtocol:@protocol(CJUserServiceProtocol) selector:@selector(loginSuccessWithMap:) execHandle:^(id<CJUserServiceProtocol>  _Nonnull listener) {
        [listener loginSuccessWithMap:dict];
    }];
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

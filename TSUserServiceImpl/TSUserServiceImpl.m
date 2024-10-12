//
//  TSUserServiceImpl.m
//  CJProtocolCenterDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TSUserServiceImpl.h"

@implementation TSUserServiceImpl

+ (TSUserServiceImpl *)sharedInstance {
    static TSUserServiceImpl *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _serviceUser = [[TSUser alloc] init];
    }
    return self;
}

- (void)loginSuccessWithMap:(NSDictionary *)dict {
    [_serviceUser updateWithLoginSuccessDictionary:dict];
    // 1、登录成功后，其他页面登录状态更新(一般用在Service管理层，如用户管理层发现用户登录状态变化,监听者一般为xxxViewController）
    [CJProtocolCenter broadcastAllListenersWhichConformsToProtocol:@protocol(CJModuleNotificationForUser)
                                                          selector:@selector(userDelegate_didUpdateLoginState:)
                                                        execHandle:^(id<CJModuleNotificationForUser> listener) {
        [listener userDelegate_didUpdateLoginState:YES];
    }];
    // 要让调用者实现上述方法，则调用者必须在初始化的时候监听指定的协议
    // [CJProtocolCenter addListener:self forProtocol:@protocol(CJUserServiceProtocolForModule)];
    // 销毁的时候记得移除，因为会被通知执行此方法的基本为xxxViewController
    // [CJProtocolCenter removeListenerForAllProtocol:self];
}

- (void)logout {
    _serviceUser = nil;
    
    [CJProtocolCenter broadcastAllListenersWhichConformsToProtocol:@protocol(CJModuleNotificationForUser)
                                                          selector:@selector(userDelegate_didUpdateLoginState:)
                                                        execHandle:^(id<CJModuleNotificationForUser> listener) {
        [listener userDelegate_didUpdateLoginState:NO];
    }];
    // 要让调用者实现上述方法，则调用者必须在初始化的时候监听指定的协议
    // [CJProtocolCenter addListener:调用者常为self forProtocol:@protocol(CJUserServiceProtocolForModule)];
    // 销毁的时候记得移除
    // [CJProtocolCenter removeListenerForAllProtocol:self];
}

- (void)dealloc {
    [CJProtocolCenter removeListenerForAllProtocol:self];
 }

@end

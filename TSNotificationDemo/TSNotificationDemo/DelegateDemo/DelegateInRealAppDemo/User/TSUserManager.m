//
//  TSUserManager.m
//  CJProtocolCenterDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TSUserManager.h"

@implementation TSUserManager

+ (TSUserManager *)sharedInstance {
    static TSUserManager *_sharedInstance = nil;
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
    [CJProtocolCenter broadcastAllListenersWhichConformsToProtocol:@protocol(TSUserDelegate)
                                                          selector:@selector(userDelegate_didUpdateLoginState:)
                                                        execHandle:^(id<TSUserDelegate> listener) {
        [listener userDelegate_didUpdateLoginState:YES];
    }];
    
    // 要让调用者实现上述方法，则调用者必须在初始化的时候监听指定的协议
    // [CJProtocolCenter addListener:调用者常为self forProtocol:@protocol(TSUserDelegate)];
    // 销毁的时候记得移除
    // [CJProtocolCenter removeListenerForAllProtocol:self];
}

- (void)logout {
    _serviceUser = nil;
    
    [CJProtocolCenter broadcastAllListenersWhichConformsToProtocol:@protocol(TSUserDelegate)
                                                          selector:@selector(userDelegate_didUpdateLoginState:)
                                                        execHandle:^(id<TSUserDelegate> listener) {
        [listener userDelegate_didUpdateLoginState:NO];
    }];
    // 要让调用者实现上述方法，则调用者必须在初始化的时候监听指定的协议
    // [CJProtocolCenter addListener:调用者常为self forProtocol:@protocol(TSUserDelegate)];
    // 销毁的时候记得移除
    // [CJProtocolCenter removeListenerForAllProtocol:self];
}

- (void)dealloc {
    [CJProtocolCenter removeListenerForAllProtocol:self];
 }

@end

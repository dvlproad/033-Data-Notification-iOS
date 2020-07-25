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

- (void)login {
    [[CJProtocolCenter defaultCenter] broadcastProtocol:@protocol(TSUserDelegate)
                                                    selector:@selector(userDelegate_didUpdateLoginState:)
                                                   responder:^(id<TSUserDelegate> listener) {
        [listener userDelegate_didUpdateLoginState:YES];
    }];
}

- (void)logout {
    [[CJProtocolCenter defaultCenter] broadcastProtocol:@protocol(TSUserDelegate)
                                                    selector:@selector(userDelegate_didUpdateLoginState:)
                                                   responder:^(id<TSUserDelegate> listener) {
        [listener userDelegate_didUpdateLoginState:NO];
    }];
}

- (void)dealloc {
    [[CJProtocolCenter defaultCenter] removeListener:self forProtocol:nil];
 }

@end

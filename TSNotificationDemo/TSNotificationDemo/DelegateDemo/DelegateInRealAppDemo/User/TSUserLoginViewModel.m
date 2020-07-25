//
//  TSUserLoginViewModel.m
//  CJProtocolCenterDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TSUserLoginViewModel.h"

@implementation TSUserLoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _serviceUser = [[TSUser alloc] init];
    }
    return self;
}

- (void)login {
    [[CJProtocolCenter defaultCenter] broadcastProtocol:@protocol(TSDelegate)
                                                    selector:@selector(delegate_didUpdateLoginState:)
                                                   responder:^(id<TSDelegate> listener) {
        [listener delegate_didUpdateLoginState:YES];
    }];
}

- (void)logout {
    [[CJProtocolCenter defaultCenter] broadcastProtocol:@protocol(TSDelegate)
                                                    selector:@selector(delegate_didUpdateLoginState:)
                                                   responder:^(id<TSDelegate> listener) {
        [listener delegate_didUpdateLoginState:NO];
    }];
}

- (void)dealloc {
    [[CJProtocolCenter defaultCenter] removeListener:self forProtocol:nil];
 }

@end

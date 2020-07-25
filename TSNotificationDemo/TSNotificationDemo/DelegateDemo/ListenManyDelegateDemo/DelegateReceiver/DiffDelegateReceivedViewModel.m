//
//  DiffDelegateReceivedViewModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "DiffDelegateReceivedViewModel.h"

@implementation DiffDelegateReceivedViewModel

#pragma mark - TSUserDelegate
- (void)userDelegate_didUpdateLoginState:(BOOL)loginState {
    NSLog(@"vm收到userDelegate:登录状态发生变化，您已%@", loginState ? @"登录" : @"登出");
}

#pragma mark - TSMessageDelegate
- (void)messageDelegate_didUpdateMessageState:(BOOL)messageState {
    NSLog(@"vm收到messageDelegate:信息状态发生变化");
}

@end

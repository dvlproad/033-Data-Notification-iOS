//
//  DelegateReceivedViewModel1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "DelegateReceivedViewModel1.h"

@implementation DelegateReceivedViewModel1

#pragma mark - TSDelegate
- (void)delegate_didUpdateLoginState:(BOOL)loginState {
    NSLog(@"vm1收到delegate:登录状态发生变化，您已%@", loginState ? @"登录" : @"登出");
}

@end

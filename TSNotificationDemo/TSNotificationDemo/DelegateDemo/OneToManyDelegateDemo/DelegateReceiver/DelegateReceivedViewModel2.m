//
//  DelegateReceivedViewModel2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "DelegateReceivedViewModel2.h"

@implementation DelegateReceivedViewModel2

#pragma mark - TSDelegate
- (void)delegate_didUpdateLoginState:(BOOL)loginState {
    NSLog(@"vm2收到delegate:登录状态发生变化，您已%@", loginState ? @"登录" : @"登出");
}


@end

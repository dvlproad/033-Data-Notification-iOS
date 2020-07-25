//
//  OneToManyDelegateNormalMediator21.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "OneToManyDelegateNormalMediator21.h"

@implementation OneToManyDelegateNormalMediator21


#pragma mark - TSDelegate
- (void)delegate_didUpdateLoginState:(BOOL)loginState {
    if (self.delegate1 && [self.delegate1 respondsToSelector:@selector(delegate_didUpdateLoginState:)]) {
        [self.delegate1 delegate_didUpdateLoginState:YES];
    }
    
    if (self.delegate2 && [self.delegate2 respondsToSelector:@selector(delegate_didUpdateLoginState:)]) {
        [self.delegate2 delegate_didUpdateLoginState:YES];
    }
}

@end

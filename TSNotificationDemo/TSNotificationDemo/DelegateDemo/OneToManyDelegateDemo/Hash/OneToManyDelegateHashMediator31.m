//
//  OneToManyDelegateHashMediator31.m
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "OneToManyDelegateHashMediator31.h"

@interface OneToManyDelegateHashMediator31 ()

@end

@implementation OneToManyDelegateHashMediator31

+ (instancetype)defaultCenter {
    static OneToManyDelegateHashMediator31 *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)addDelegate:(id)delegate {
    [_hashTable addObject:delegate];
}

- (void)removeDelegate:(id)delegate {
    [_hashTable removeObject:delegate];
}


#pragma mark - TSDelegate
- (void)delegate_didUpdateLoginState:(BOOL)loginState {
    for (id delegate in self.hashTable) {
        if (delegate && [delegate respondsToSelector:@selector(delegate_didUpdateLoginState:)]) {
            [delegate delegate_didUpdateLoginState:YES];
        }
    }
}

@end

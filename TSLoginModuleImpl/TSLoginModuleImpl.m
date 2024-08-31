//
//  TSLoginModuleImplPublic.m
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TSLoginModuleImpl.h"
#import <CJProtocolCenter/CJProtocolCenter+Module.h>
#import <CJBaseHelper/UIViewControllerCJHelper.h>
#import "TSLoginViewController.h"

@implementation TSLoginModuleImpl

+ (TSLoginModuleImpl *)create {
    static TSLoginModuleImpl *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [CJProtocolCenter addModule:self forProtocol:@protocol(LoginModulePublic)];
    }
    return self;
}

#pragma mark - LoginModulePublic
- (void)loginModule_goLoginPage:(BOOL)loginState {
    UIViewController *topVC = [UIViewControllerCJHelper findCurrentShowingViewController];
    
    TSLoginViewController *vc = [[TSLoginViewController alloc] init];
    [topVC.navigationController pushViewController:vc animated:YES];
}

@end

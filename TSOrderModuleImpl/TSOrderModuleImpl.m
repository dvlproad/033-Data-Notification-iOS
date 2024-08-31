//
//  TSOrderModuleImplPublic.m
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TSOrderModuleImpl.h"
#import <CJProtocolCenter/CJProtocolCenter+Module.h>
#import <CJBaseHelper/UIViewControllerCJHelper.h>
#import "TSOrderHomeViewController.h"

@interface TSOrderModuleImpl ()<OrderModulePublic>

@end

@implementation TSOrderModuleImpl

+ (TSOrderModuleImpl *)create {
    static TSOrderModuleImpl *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [CJProtocolCenter addModule:self forProtocol:@protocol(OrderModulePublic)];
    }
    return self;
}

#pragma mark - OrderModulePublic
- (void)orderModule_goOrderHomePage:(int)pageType {
    UIViewController *topVC = [UIViewControllerCJHelper findCurrentShowingViewController];
    
    TSOrderHomeViewController *vc = [[TSOrderHomeViewController alloc] init];
    [topVC.navigationController pushViewController:vc animated:YES];
}

@end

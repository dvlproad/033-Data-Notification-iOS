//
//  UIWindow+RootSetting.m
//  CQShareDemo
//
//  Created by ciyouzen on 2018/4/12.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "UIWindow+RootSetting.h"
#import "TSNotificationMainViewController.h"
//#import <TSModulePublic/LoginModulePublic.h>
//#import <TSModulePublic/OrderModulePublic.h>
#import <TSLoginModuleImpl/TSLoginModuleImpl.h>
#import <TSOrderModuleImpl/TSOrderModuleImpl.h>

@implementation UIWindow (RootSetting)

- (void)settingRoot {
    [self addModules];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    // 只直接测试某个页面
//    UIViewController *rootViewController = [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(@"DelegateHomeViewController") alloc] init]];
    UIViewController *rootViewController = [[TSNotificationMainViewController alloc] init];
    
    self.rootViewController = rootViewController;
    [self makeKeyAndVisible];
}

- (void)addModules {
    [TSLoginModuleImpl create];
    [TSOrderModuleImpl create];
}

@end

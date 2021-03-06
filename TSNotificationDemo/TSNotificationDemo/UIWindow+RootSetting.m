//
//  UIWindow+RootSetting.m
//  CQShareDemo
//
//  Created by ciyouzen on 2018/4/12.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "UIWindow+RootSetting.h"

@implementation UIWindow (RootSetting)

- (void)settingRoot {
    [self setBackgroundColor:[UIColor whiteColor]];
    // 只直接测试某个页面
    UIViewController *rootViewController = [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(@"DelegateHomeViewController") alloc] init]];
    
    self.rootViewController = rootViewController;
    [self makeKeyAndVisible];
}

@end

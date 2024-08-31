//
//  CQModuleHelper.h
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CQModuleHelper : NSObject

#pragma mark - 通知
+ (void)noti_didUpdateLoginState:(BOOL)loginState;

#pragma mark - 跳转
+ (void)goOrderHomePage:(int)pageType;

+ (void)goLoginPage:(BOOL)loginState;


@end

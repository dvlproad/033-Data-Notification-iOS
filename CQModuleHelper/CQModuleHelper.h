//
//  CQModuleHelper.h
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CQModuleHelper : NSObject

#pragma mark - 管理数据变化+内部通知
+ (void)loginSuccessWithMap:(NSDictionary *)dict;

#pragma mark - 跳转
+ (void)goOrderHomePage:(int)pageType;

+ (void)goLoginPage:(BOOL)loginState;


@end

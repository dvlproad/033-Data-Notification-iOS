//
//  TSUserServiceImpl.h
//  CJProtocolCenterDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TSUser.h"

#import <TSModulePublic/CJUserServicePublic.h>
#import <CJProtocolCenter/CJProtocolCenter+Module.h>    // 用于数据管理变化时候的内部通知

@interface TSUserServiceImpl : NSObject <UIApplicationDelegate, CJUserServiceProtocol> {
    
}
@property (nonatomic, strong, readonly) TSUser *serviceUser;

+ (TSUserServiceImpl *)sharedInstance;

@end

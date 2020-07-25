//
//  TSUserManager.h
//  CJProtocolCenterDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TSUser.h"

#import "CJProtocolCenter.h"
#import "TSUserDelegate.h"

@interface TSUserManager : NSObject <UIApplicationDelegate> {
    
}
@property (nonatomic, strong, readonly) TSUser *serviceUser;

+ (TSUserManager *)sharedInstance;

- (void)login;
- (void)logout;

@end

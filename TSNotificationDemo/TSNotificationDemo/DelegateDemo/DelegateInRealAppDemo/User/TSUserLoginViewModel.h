//
//  TSUserLoginViewModel.h
//  CJProtocolCenterDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TSUser.h"

#import "CJProtocolCenter.h"
#import "TSDelegate.h"

@interface TSUserLoginViewModel : NSObject <UIApplicationDelegate> {
    
}
@property (nonatomic, strong, readonly) TSUser *serviceUser;

- (void)login;
- (void)logout;

@end

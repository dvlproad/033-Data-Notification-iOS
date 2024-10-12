//
//  CJUserServicePublic.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#ifndef CJUserServicePublic_h
#define CJUserServicePublic_h

@protocol CJUserServiceProtocol <NSObject>

@required
- (void)loginSuccessWithMap:(NSDictionary *)dict;
- (void)logout;

@end


@protocol CJModuleNotificationForUser <NSObject>

@required
- (void)userDelegate_didUpdateLoginState:(BOOL)loginState;

@end

#endif /* CJUserServicePublic_h */

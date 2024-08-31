//
//  TSUserDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#ifndef TSUserDelegate_h
#define TSUserDelegate_h

@protocol CJUserServiceProtocolForModule <NSObject>

- (void)userDelegate_didUpdateLoginState:(BOOL)loginState;

@end


@interface CJModuleNotificationForUser : NSObject

@end

#endif /* TSDelegate2_h */

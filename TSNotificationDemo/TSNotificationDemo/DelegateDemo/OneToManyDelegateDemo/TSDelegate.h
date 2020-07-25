//
//  TSDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#ifndef TSDelegate_h
#define TSDelegate_h

@protocol TSDelegate <NSObject>

@optional
- (void)delegate_didUpdateLoginState:(BOOL)loginState;

@end


#endif /* TSDelegate1_h */

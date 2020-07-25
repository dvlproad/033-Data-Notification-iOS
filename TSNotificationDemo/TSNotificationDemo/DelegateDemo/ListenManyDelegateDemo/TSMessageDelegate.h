//
//  TSMessageDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#ifndef TSMessageDelegate_h
#define TSMessageDelegate_h

@protocol TSMessageDelegate <NSObject>

- (void)messageDelegate_didUpdateMessageState:(BOOL)messageState;

@end

#endif /* TSDelegate2_h */

//
//  CJProtocolCenter+Private.h
//  TSNotificationDemo
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJProtocolCenter.h"

@interface CJProtocolCenter(Private)

- (NSHashTable *)__unsafe_listenersForProtocol:(Protocol *)protocol autoCreate:(BOOL)autoCreate;

@end

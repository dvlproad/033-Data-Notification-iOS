//
//  OneToManyDelegateHashMediator31.h
//  ProtocolNotification
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDelegate.h"

@interface OneToManyDelegateHashMediator31 : NSObject <TSDelegate>

@property (nonatomic, strong, readonly) NSHashTable *hashTable;

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;

@end

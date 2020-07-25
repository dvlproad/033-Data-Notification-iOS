//
//  OneToManyDelegateArrayMediator31.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface OneToManyDelegateArrayMediator31 : NSObject <TSDelegate>

@property (nonatomic, readonly) NSPointerArray *delegates;

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END

//
//  DiffDelegateReceivedViewModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSUserDelegate.h"
#import "TSMessageDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DiffDelegateReceivedViewModel : NSObject <TSUserDelegate, TSMessageDelegate>

@end

NS_ASSUME_NONNULL_END

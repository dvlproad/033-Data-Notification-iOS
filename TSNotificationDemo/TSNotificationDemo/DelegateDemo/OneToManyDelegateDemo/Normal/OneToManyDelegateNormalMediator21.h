//
//  OneToManyDelegateNormalMediator21.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/6/21.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface OneToManyDelegateNormalMediator21 : NSObject <TSDelegate> {
    
}
@property (nonatomic, weak) id<TSDelegate> delegate1;
@property (nonatomic, weak) id<TSDelegate> delegate2;

@end

NS_ASSUME_NONNULL_END

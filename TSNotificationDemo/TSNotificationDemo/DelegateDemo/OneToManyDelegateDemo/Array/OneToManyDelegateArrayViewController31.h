//
//  OneToManyDelegateArrayViewController31.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseHomeViewController.h"
#import "TSDelegate.h"

#import "OneToManyDelegateArrayMediator31.h"

@interface OneToManyDelegateArrayViewController31 : CJUIKitBaseHomeViewController {
    
}
@property (nonatomic, strong) OneToManyDelegateArrayMediator31 *delegateMediator;
//@property (nonatomic, strong) NSPointerArray *delegates;
//@property (nonatomic, weak) id<TSDelegate> delegate1;
//@property (nonatomic, weak) id<TSDelegate> delegate2;

@end

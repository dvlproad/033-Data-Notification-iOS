//
//  OneToManyDelegateHashViewController31.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseHomeViewController.h"
#import "TSDelegate.h"

#import "OneToManyDelegateHashMediator31.h"

@interface OneToManyDelegateHashViewController31 : CJUIKitBaseHomeViewController {
    
}
@property (nonatomic, strong) OneToManyDelegateHashMediator31 *delegateMediator;
//@property (nonatomic, strong) NSHashTable *hashDelegateTable;
//@property (nonatomic, weak) id<TSDelegate> delegate1;
//@property (nonatomic, weak) id<TSDelegate> delegate2;

@end

//
//  OneToManyDelegateNormalViewController1.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseHomeViewController.h"
#import "TSDelegate.h"

@interface OneToManyDelegateNormalViewController1 : CJUIKitBaseHomeViewController {
    
}
@property (nonatomic, weak) id<TSDelegate> delegate1;
@property (nonatomic, weak) id<TSDelegate> delegate2;

@end

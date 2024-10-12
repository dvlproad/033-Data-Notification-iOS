//
//  TSUser.m
//  CJProtocolCenterDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TSUser.h"

@implementation TSUser

- (instancetype)initWithUserDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    if (self) {
        _uid = userDictionary[@"uid"];
        _nickName = userDictionary[@"nickName"];
    }
    
    return self;
}

// 避免登录接口比已拥有的数据少，而造成覆盖丢失
- (void)updateWithLoginSuccessDictionary:(NSDictionary *)userDictionary {
    _uid = userDictionary[@"uid"];
    
    //[self __updateServiceUser:userDictionary forKeys:nil keyMap:nil];
}
 


@end

//
//  TSUser.h
//  CJProtocolCenterDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TSUser : NSObject

/**
 模型对象为只读，整个模型对象的属性均为只读；
 在值更新的时候，外部不能直接修改，应通过私有方法更新；
 
 这样做的好处是内外部同一个对象，外部可以直接观察该对象的值，同时不能随意修改属性值；
 真正需要修改的时候导入私有方法头文件，更明确具体在做什么。
 */
@property (nonatomic, copy, readonly) NSString *uid;        /**< 用户Id */
@property (nonatomic, copy, readonly) NSString *nickName;   /**< 员工昵称(登录接口会返回) */

- (instancetype)initWithUserDictionary:(NSDictionary *)userDictionary;

// 避免登录接口比已拥有的数据少，而造成覆盖丢失
- (void)updateWithLoginSuccessDictionary:(NSDictionary *)userDictionary;

@end

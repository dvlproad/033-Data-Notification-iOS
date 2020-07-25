//
//  ListenManyDelegateViewController2.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ListenManyDelegateViewController2.h"

#import "OneToManyDelegateHashMediator33.h"
#import "TSUserDelegate.h"
#import "TSMessageDelegate.h"

@interface ListenManyDelegateViewController2 () {
    
}

@end

@implementation ListenManyDelegateViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"不同协议给同一监听者/同时监听不同协议", nil);
   
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 多代理-delegate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"执行delegate(未封装)";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"执行userDelegate的登录操作，发送登录状态变化";
            loginModule.actionBlock = ^{
                SEL selector = @selector(userDelegate_didUpdateLoginState:);
                for (id delegate in self.delegateMediator.hashTable) {
                    if (!selector || [delegate respondsToSelector:selector]) {
                        [delegate userDelegate_didUpdateLoginState:YES];
                    }
                }
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"执行messageDelegate的更新操作，发送信息状态变化";
            loginModule.actionBlock = ^{
                SEL selector = @selector(messageDelegate_didUpdateMessageState:);
                for (id delegate in self.delegateMediator.hashTable) {
                    if (!selector || [delegate respondsToSelector:selector]) {
                        [delegate messageDelegate_didUpdateMessageState:YES];
                    }
                }
            };
            [sectionDataModel.values addObject:loginModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 多代理-delegate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"执行delegate(初步封装)";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"执行userDelegate的登录操作，发送登录状态变化";
            loginModule.actionBlock = ^{
                [self __broadcastProtocol:@protocol(TSUserDelegate)
                                 selector:@selector(userDelegate_didUpdateLoginState:)
                                responder:^(id<TSUserDelegate> delegate) {
                    [delegate userDelegate_didUpdateLoginState:YES];
                }];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"执行messageDelegate的更新操作，发送信息状态变化";
            loginModule.actionBlock = ^{
                [self __broadcastProtocol:@protocol(TSMessageDelegate)
                                 selector:@selector(messageDelegate_didUpdateMessageState:)
                                responder:^(id<TSMessageDelegate> delegate) {
                    [delegate messageDelegate_didUpdateMessageState:YES];
                }];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 多代理-delegate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"执行delegate(正式封装)";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"执行userDelegate的登录操作，发送登录状态变化";
            loginModule.actionBlock = ^{
                [self.delegateMediator broadcastProtocol:@protocol(TSUserDelegate)
                                                selector:@selector(userDelegate_didUpdateLoginState:)
                                               responder:^(id<TSUserDelegate> delegate) {
                    [delegate userDelegate_didUpdateLoginState:YES];
                }];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"执行messageDelegate的更新操作，发送信息状态变化";
            loginModule.actionBlock = ^{
                [self.delegateMediator broadcastProtocol:@protocol(TSMessageDelegate)
                                                selector:@selector(messageDelegate_didUpdateMessageState:)
                                               responder:^(id<TSMessageDelegate> delegate) {
                    [delegate messageDelegate_didUpdateMessageState:YES];
                }];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - Private Method
- (void)__broadcastProtocol:(Protocol * _Nonnull)protocol selector:(SEL _Nullable)selector responder:(void (^_Nonnull)(id delegate))block {
    NSAssert(protocol, @"Protocol is nil.");
    NSAssert(block, @"Block is nil.");

    NSHashTable *hashTable = self.delegateMediator.hashTable;
    for (id delegate in hashTable) {
        if (!selector || [delegate respondsToSelector:selector]) {
            block(delegate);
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

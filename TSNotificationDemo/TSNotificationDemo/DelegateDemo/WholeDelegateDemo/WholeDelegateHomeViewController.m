//
//  WholeDelegateHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "WholeDelegateHomeViewController.h"
#import "CJProtocolCenter.h"
#import "TSUserDelegate.h"
#import "TSMessageDelegate.h"

@interface WholeDelegateHomeViewController ()

@end

@implementation WholeDelegateHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"(发送者发)同一协议给多个监听者 & (接收者收)同时监听不同协议", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 多代理-delegate
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"执行delegate(最最终封装成库)";
        {
            CQDMModuleModel *loginModule = [[CQDMModuleModel alloc] init];
            loginModule.title = @"执行userDelegate的登录操作，发送登录状态变化";
            loginModule.actionBlock = ^{
                [[CJProtocolCenter defaultCenter] broadcastProtocol:@protocol(TSUserDelegate)
                                                               selector:@selector(userDelegate_didUpdateLoginState:)
                                                              responder:^(id<TSUserDelegate> listener) {
                    [listener userDelegate_didUpdateLoginState:YES];
                }];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CQDMModuleModel *loginModule = [[CQDMModuleModel alloc] init];
            loginModule.title = @"执行userDelegate的退出操作，发送登录状态变化";
            loginModule.actionBlock = ^{
                [[CJProtocolCenter defaultCenter] broadcastProtocol:@protocol(TSUserDelegate)
                                                               selector:@selector(userDelegate_didUpdateLoginState:)
                                                              responder:^(id<TSUserDelegate> listener) {
                    [listener userDelegate_didUpdateLoginState:NO];
                }];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CQDMModuleModel *loginModule = [[CQDMModuleModel alloc] init];
            loginModule.title = @"执行messageDelegate的更新操作，发送信息状态变化";
            loginModule.actionBlock = ^{
                [[CJProtocolCenter defaultCenter] broadcastProtocol:@protocol(TSMessageDelegate)
                                                               selector:@selector(messageDelegate_didUpdateMessageState:)
                                                              responder:^(id<TSMessageDelegate> listener) {
                    [listener messageDelegate_didUpdateMessageState:YES];
                }];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
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

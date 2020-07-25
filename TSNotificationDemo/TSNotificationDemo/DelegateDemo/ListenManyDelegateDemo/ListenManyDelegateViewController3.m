//
//  ListenManyDelegateViewController3.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ListenManyDelegateViewController3.h"

#import "TSNotificationCenter.h"
#import "TSUserDelegate.h"
#import "TSMessageDelegate.h"

@interface ListenManyDelegateViewController3 () {
    
}

@end

@implementation ListenManyDelegateViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"不同协议给同一监听者/同时监听不同协议", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 多代理-delegate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"执行delegate(最终封装)";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"执行userDelegate的登录操作，发送登录状态变化";
            loginModule.actionBlock = ^{
                [[TSNotificationCenter defaultCenter] broadcastProtocol:@protocol(TSUserDelegate)
                                                               selector:@selector(userDelegate_didUpdateLoginState:)
                                                              responder:^(id<TSUserDelegate> listener) {
                    [listener userDelegate_didUpdateLoginState:YES];
                }];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"执行messageDelegate的更新操作，发送信息状态变化";
            loginModule.actionBlock = ^{
                [[TSNotificationCenter defaultCenter] broadcastProtocol:@protocol(TSMessageDelegate)
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

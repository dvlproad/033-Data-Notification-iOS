//
//  TSLoginViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSLoginViewController.h"
#import <TSModulePublic/OrderModulePublic.h>                // 模块间
#import <TSModulePublic/CJUserServiceProtocolForModule.h>   // Service信息管理层的协议
#import <CJProtocolCenter/CJProtocolCenter+Module.h>
#import <CQModuleHelper/CQModuleHelper.h>

@interface TSLoginViewController ()

@end

@implementation TSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"登录模块", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    __weak typeof(self) weakSelf = self;
    // 多代理-UserManager
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"模块化测试";
        {
            CQDMModuleModel *loginModule = [[CQDMModuleModel alloc] init];
            loginModule.title = @"登录，若成功则跳转到订单首页";
            loginModule.actionBlock = ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf __loginSuccess];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}


#pragma mark - 登录请求结束的数据处理方法(分请求成功和请求失败)
/// 登录请求成功结束的数据处理方法
- (void)__loginSuccess {
    // 1、登录成功后，其他页面登录状态更新(一般用在Service管理层，如用户管理层发现用户登录状态变化,监听者一般为xxxViewController）
    [CQModuleHelper noti_didUpdateLoginState:YES];
    // 2、登录成功，跳转到其他模块的其他页面（一般用在要跳转到其他模块页面,监听者为xxxModuleImpl单例）
    [CQModuleHelper goOrderHomePage:2];
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

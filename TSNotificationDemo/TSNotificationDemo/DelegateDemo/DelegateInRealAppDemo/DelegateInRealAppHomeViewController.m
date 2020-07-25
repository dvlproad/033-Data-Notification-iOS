//
//  DelegateInRealAppHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DelegateInRealAppHomeViewController.h"

#import "TSUserManager.h"

@interface DelegateInRealAppHomeViewController ()

@end

@implementation DelegateInRealAppHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"(发送者发)同一协议给多个监听者 & (接收者收)同时监听不同协议", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 多代理-UserManager
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"manager用户登录/登出";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"manger执行登录操作，发送登录状态变化";
            loginModule.actionBlock = ^{
                //NSDictionary *userDictionary = @{@"uid": @"111"};
                //[[TSUserManager sharedInstance] __updateServiceUser:userDictionary forKeys:nil keyMap:nil];
                [[TSUserManager sharedInstance] login];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"manager执行退出操作，发送登录状态变化";
            loginModule.actionBlock = ^{
                //NSDictionary *userDictionary = nil;
                //[[TSUserManager sharedInstance] __updateServiceUser:userDictionary forKeys:nil keyMap:nil];
                [[TSUserManager sharedInstance] logout];
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

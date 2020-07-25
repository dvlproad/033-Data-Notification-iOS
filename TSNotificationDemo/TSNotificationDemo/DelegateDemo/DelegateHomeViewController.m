//
//  DelegateHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DelegateHomeViewController.h"

#import "OneToManyDelegateHomeViewController.h"
#import "ListenManyDelegateHomeViewController.h"
#import "WholeDelegateHomeViewController.h"
#import "DelegateInRealAppHomeViewController.h"

#import "TSUserLoginViewModel.h"
#import "TSUserManager.h"

@interface DelegateHomeViewController () <TSDelegate, TSUserDelegate> {
    
}

@end

@implementation DelegateHomeViewController

#pragma mark - TSDelegate
- (void)delegate_didUpdateLoginState:(BOOL)loginState {
    NSLog(@"vm登录状态发生变化，您已%@", loginState ? @"登录" : @"登出");
}


#pragma mark - TSUserDelegate
- (void)userDelegate_didUpdateLoginState:(BOOL)loginState {
    NSLog(@"manager登录状态发生变化，您已%@", loginState ? @"登录" : @"登出");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"同一协议给多个监听者", nil);
    
    [[CJProtocolCenter defaultCenter] addListener:self forProtocol:@protocol(TSDelegate)];
    [[CJProtocolCenter defaultCenter] addListener:self forProtocol:@protocol(TSUserDelegate)];
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // OneToManyDelegate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"OneToManyDelegate";
        {
            CJModuleModel *helperModule = [[CJModuleModel alloc] init];
            helperModule.title = @"(发送者发)同一协议给多个监听者";
            helperModule.classEntry = [OneToManyDelegateHomeViewController class];
            [sectionDataModel.values addObject:helperModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // ListenManyDelegate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"ListenManyDelegate";
        {
            CJModuleModel *helperModule = [[CJModuleModel alloc] init];
            helperModule.title = @"(接收者收)不同协议给同一监听者/同时监听不同协议";
            helperModule.classEntry = [ListenManyDelegateHomeViewController class];
            [sectionDataModel.values addObject:helperModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // Whole
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Whole";
        {
            CJModuleModel *helperModule = [[CJModuleModel alloc] init];
            helperModule.title = @"完整的";
            helperModule.classEntry = [WholeDelegateHomeViewController class];
            [sectionDataModel.values addObject:helperModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 多代理在正式app中的使用示例
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"多代理在正式app中的使用示例";
        {
            CJModuleModel *helperModule = [[CJModuleModel alloc] init];
            helperModule.title = @"多代理在正式app中的使用示例";
            helperModule.classEntry = [DelegateInRealAppHomeViewController class];
            [sectionDataModel.values addObject:helperModule];
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

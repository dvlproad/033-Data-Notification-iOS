//
//  TSOrderHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSOrderHomeViewController.h"
#import <CQModuleHelper/CQModuleHelper.h>
#import <TSModulePublic/CJUserServiceProtocolForModule.h>
#import <TSModulePublic/LoginModulePublic.h>
#import <CJProtocolCenter/CJProtocolCenter+Module.h>

@interface TSOrderHomeViewController ()<CJUserServiceProtocolForModule>

@end

@implementation TSOrderHomeViewController

- (void)dealloc {
    [CJProtocolCenter removeListenerForAllProtocol:self];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [CJProtocolCenter addListener:self forProtocol:@protocol(CJUserServiceProtocolForModule)];
    }
    return self;
}


#pragma mark - CJUserServiceProtocolForModule
- (void)userDelegate_didUpdateLoginState:(BOOL)loginState {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"订单模块", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 多代理-UserManager
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"模块化测试";
        {
            CQDMModuleModel *loginModule = [[CQDMModuleModel alloc] init];
            loginModule.title = @"跳到登录模块";
            loginModule.actionBlock = ^{
                [CQModuleHelper goLoginPage:YES];
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

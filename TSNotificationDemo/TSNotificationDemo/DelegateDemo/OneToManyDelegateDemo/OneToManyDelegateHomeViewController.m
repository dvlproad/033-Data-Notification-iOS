//
//  OneToManyDelegateHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "OneToManyDelegateHomeViewController.h"
#import "DelegateReceivedViewModel1.h"
#import "DelegateReceivedViewModel2.h"

#import "OneToManyDelegateNormalViewController1.h"
#import "OneToManyDelegateNormalViewController21.h"

#import "OneToManyDelegateArrayViewController1.h"
#import "OneToManyDelegateArrayViewController31.h"
#import "OneToManyDelegateArrayViewController33.h"

#import "OneToManyDelegateHashViewController1.h"
#import "OneToManyDelegateHashViewController31.h"
#import "OneToManyDelegateHashViewController33.h"

#import "OneToManyDelegateViewController6.h"

@interface OneToManyDelegateHomeViewController () {
    
}
@property (nonatomic, strong) DelegateReceivedViewModel1 *delegateReceiver1;
@property (nonatomic, strong) DelegateReceivedViewModel2 *delegateReceiver2;

@end

@implementation OneToManyDelegateHomeViewController

#pragma mark - TSDelegate
- (void)delegate_didUpdateLoginState:(BOOL)loginState {
    NSLog(@"delegate1:登录状态发生变化，您已%@", loginState ? @"登录" : @"登出");
}

#pragma mark - TSUserDelegate
- (void)userDelegate_didUpdateLoginState:(BOOL)loginState {
    NSLog(@"delegate2:登录状态发生变化，您已%@", loginState ? @"登录" : @"登出");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"(发送者发)同一协议给多个监听者", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    DelegateReceivedViewModel1 *delegateReceiver1 = [[DelegateReceivedViewModel1 alloc] init];
    DelegateReceivedViewModel2 *delegateReceiver2 = [[DelegateReceivedViewModel2 alloc] init];
    self.delegateReceiver1 = delegateReceiver1;
    self.delegateReceiver2 = delegateReceiver2;
    
    // 多代理-Delegate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"OneToManyDelegate";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"传统一个个多次操作delegate";
            loginModule.actionBlock = ^{
                OneToManyDelegateNormalViewController1 *viewController = [[OneToManyDelegateNormalViewController1 alloc] init];
                viewController.delegate1 = delegateReceiver1;
                viewController.delegate2 = delegateReceiver2;
                [self.navigationController pushViewController:viewController animated:YES];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"传统一个个多次操作delegate";
            loginModule.actionBlock = ^{
                OneToManyDelegateNormalMediator21 *delegateMediator = [[OneToManyDelegateNormalMediator21 alloc] init];
                delegateMediator.delegate1 = self.delegateReceiver1;
                delegateMediator.delegate2 = self.delegateReceiver2;
                
                OneToManyDelegateNormalViewController21 *viewController = [[OneToManyDelegateNormalViewController21 alloc] init];
                viewController.delegateMediator = delegateMediator;
                [self.navigationController pushViewController:viewController animated:YES];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 多代理-Delegate(Array)
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Array遍历操作delegate";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"OneToManyDelegateArrayViewController1";
            loginModule.actionBlock = ^{
                NSPointerArray *delegates = [NSPointerArray weakObjectsPointerArray];
                [delegates addPointer:(__bridge void * _Nullable)self.delegateReceiver1];
                [delegates addPointer:(__bridge void * _Nullable)self.delegateReceiver2] ;
                
                OneToManyDelegateArrayViewController1 *viewController = [[OneToManyDelegateArrayViewController1 alloc] init];
                viewController.delegates = delegates;
                [self.navigationController pushViewController:viewController animated:YES];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"OneToManyDelegateArrayViewController31";
            loginModule.actionBlock = ^{
                OneToManyDelegateArrayMediator31 *delegateMediator = [[OneToManyDelegateArrayMediator31 alloc] init];
                [delegateMediator addDelegate:self.delegateReceiver1];
                [delegateMediator addDelegate:self.delegateReceiver2];
                
                OneToManyDelegateArrayViewController31 *viewController = [[OneToManyDelegateArrayViewController31 alloc] init];
                viewController.delegateMediator = delegateMediator;
                [self.navigationController pushViewController:viewController animated:YES];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"OneToManyDelegateArrayViewController33";
            loginModule.actionBlock = ^{
                OneToManyDelegateArrayMediator33 *delegateMediator = [[OneToManyDelegateArrayMediator33 alloc] init];
                [delegateMediator addDelegate:self.delegateReceiver1];
                [delegateMediator addDelegate:self.delegateReceiver2];
                
                OneToManyDelegateArrayViewController33 *viewController = [[OneToManyDelegateArrayViewController33 alloc] init];
                viewController.delegateMediator = delegateMediator;
                [self.navigationController pushViewController:viewController animated:YES];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    // 多代理-Delegate(Hash)
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Hash遍历操作delegate";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"OneToManyDelegateHashViewController1";
            loginModule.actionBlock = ^{
                NSHashTable *delegates = [NSHashTable weakObjectsHashTable];
                [delegates addObject:self.delegateReceiver1];
                [delegates addObject:self.delegateReceiver2];
                
                OneToManyDelegateHashViewController1 *viewController = [[OneToManyDelegateHashViewController1 alloc] init];
                viewController.hashDelegateTable = delegates;
                [self.navigationController pushViewController:viewController animated:YES];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"OneToManyDelegateHashViewController31";
            loginModule.actionBlock = ^{
                OneToManyDelegateHashMediator31 *delegateMediator = [[OneToManyDelegateHashMediator31 alloc] init];
                [delegateMediator addDelegate:self.delegateReceiver1];
                [delegateMediator addDelegate:self.delegateReceiver2];
                
                OneToManyDelegateHashViewController31 *viewController = [[OneToManyDelegateHashViewController31 alloc] init];
                viewController.delegateMediator = delegateMediator;
                [self.navigationController pushViewController:viewController animated:YES];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"OneToManyDelegateHashViewController33";
            loginModule.actionBlock = ^{
                OneToManyDelegateHashMediator33 *delegateMediator = [[OneToManyDelegateHashMediator33 alloc] init];
                [delegateMediator addDelegate:self.delegateReceiver1];
                [delegateMediator addDelegate:self.delegateReceiver2];
                
                OneToManyDelegateHashViewController33 *viewController = [[OneToManyDelegateHashViewController33 alloc] init];
                viewController.delegateMediator = delegateMediator;
                [self.navigationController pushViewController:viewController animated:YES];
            };
            [sectionDataModel.values addObject:loginModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 多代理-Delegate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"OneToManyDelegate";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"OneToManyDelegateViewController6";
            loginModule.actionBlock = ^{
                OneToManyDelegateViewController6 *viewController = [[OneToManyDelegateViewController6 alloc] init];
                [[TSNotificationCenter defaultCenter] addDelegate:self.delegateReceiver1 forProtocol:@protocol(TSDelegate)];
                [[TSNotificationCenter defaultCenter] addDelegate:self.delegateReceiver2 forProtocol:@protocol(TSDelegate)];
                [self.navigationController pushViewController:viewController animated:YES];
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

//
//  ListenManyDelegateHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ListenManyDelegateHomeViewController.h"

#import "ListenManyDelegateViewController2.h"
#import "ListenManyDelegateViewController3.h"

#import "DiffDelegateReceivedViewModel.h"

#import "TSNotificationCenter.h"

@interface ListenManyDelegateHomeViewController () {
    
}
@property (nonatomic, strong) DiffDelegateReceivedViewModel *diffDelegateReceiver;

@end

@implementation ListenManyDelegateHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"(接收者收)不同协议给同一监听者/同时监听不同协议", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    DiffDelegateReceivedViewModel *diffDelegateReceiver = [[DiffDelegateReceivedViewModel alloc] init];
    self.diffDelegateReceiver = diffDelegateReceiver;
    
    // 多代理-ViewModel
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"(接收者收)不同协议给同一监听者/同时监听不同协议";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"ListenManyDelegateViewController2";
            loginModule.actionBlock = ^{
                OneToManyDelegateHashMediator33 *delegateMediator = [[OneToManyDelegateHashMediator33 alloc] init];
                [delegateMediator addDelegate:diffDelegateReceiver];
                
                ListenManyDelegateViewController2 *viewController = [[ListenManyDelegateViewController2 alloc] init];
                viewController.delegateMediator = delegateMediator;
                [self.navigationController pushViewController:viewController animated:YES];
            };
            
            [sectionDataModel.values addObject:loginModule];
        }
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"(接收者收)不同协议给同一监听者/同时监听不同协议";
            loginModule.actionBlock = ^{
                [[TSNotificationCenter defaultCenter] addDelegate:self.diffDelegateReceiver
                                                      forProtocol:@protocol(TSUserDelegate)];
                [[TSNotificationCenter defaultCenter] addDelegate:self.diffDelegateReceiver
                                                      forProtocol:@protocol(TSMessageDelegate)];
                
                ListenManyDelegateViewController3 *viewController = [[ListenManyDelegateViewController3 alloc] init];
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

//
//  TSNotificationMainViewController.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSNotificationMainViewController.h"
#import "DelegateHomeViewController.h"
#import <TSLoginModuleImpl/TSLoginViewController.h>

@interface TSNotificationMainViewController ()

@end

@implementation TSNotificationMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray<CQDMTabBarModel *> *tabBarModels = [[NSMutableArray alloc] init];
    {
        CQDMTabBarModel *tabBarModel = [[CQDMTabBarModel alloc] init];
        tabBarModel.title = NSLocalizedString(@"DelegateHome", nil);
        tabBarModel.classEntry = [DelegateHomeViewController class];
        [tabBarModels addObject:tabBarModel];
    }
    {
        CQDMTabBarModel *tabBarModel = [[CQDMTabBarModel alloc] init];
        tabBarModel.title = NSLocalizedString(@"测试模块化", nil);
        tabBarModel.classEntry = [TSLoginViewController class];
        [tabBarModels addObject:tabBarModel];
    }
    
    self.tabBarModels = tabBarModels;
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

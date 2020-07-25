//
//  OneToManyDelegateNormalViewController1.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "OneToManyDelegateNormalViewController1.h"

@interface OneToManyDelegateNormalViewController1 () {
    
}

@end

@implementation OneToManyDelegateNormalViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"同时发送给 delegateReceiver1 & delegateReceiver2", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 多代理-delegate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"delegate1 & delegate2";
        {
            CJModuleModel *loginModule = [[CJModuleModel alloc] init];
            loginModule.title = @"delegate1:执行登录操作，发送登录状态变化";
            loginModule.actionBlock = ^{
                [self.delegate1 delegate_didUpdateLoginState:YES];
                [self.delegate2 delegate_didUpdateLoginState:YES];
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

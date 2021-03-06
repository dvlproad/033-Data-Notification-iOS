//
//  OneToManyDelegateArrayViewController33.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "OneToManyDelegateArrayViewController33.h"
#import "TSDelegate.h"

@interface OneToManyDelegateArrayViewController33 () {
    
}

@end

@implementation OneToManyDelegateArrayViewController33

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"同时发送给 delegateReceiver1 & delegateReceiver2", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 多代理-delegate
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"delegate1 & delegate2";
        {
            CQDMModuleModel *loginModule = [[CQDMModuleModel alloc] init];
            loginModule.title = @"delegate:执行登录操作，发送登录状态变化";
            loginModule.actionBlock = ^{
                //[self.delegate1 delegate_didUpdateLoginState:YES];
                //[self.delegate2 delegate_didUpdateLoginState:YES];
                
                //for (NSUInteger i = 0; i < self.delegates.count; i++) {
                //    id delegate = (__bridge id)[self.delegates pointerAtIndex:i];
                //    if (delegate && [delegate respondsToSelector:@selector(delegate_didUpdateLoginState:)]) {
                //        [delegate delegate_didUpdateLoginState:YES];
                //    }
                //}
                
                //if (self.delegateMediator && [self.delegateMediator respondsToSelector:@selector(delegate_didUpdateLoginState:)]) {
                //    [self.delegateMediator delegate_didUpdateLoginState:YES];
                //}
                
                 [self.delegateMediator broadcastProtocol:@protocol(TSDelegate)
                                                 selector:@selector(delegate_didUpdateLoginState:)
                                                responder:^(id<TSDelegate> delegateReceiver) {
                     [delegateReceiver delegate_didUpdateLoginState:YES];
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

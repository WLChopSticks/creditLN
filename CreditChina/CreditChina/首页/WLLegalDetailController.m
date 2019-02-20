//
//  WLLegalDetailController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLegalDetailController.h"
#import <WLPlatform.h>

@interface WLLegalDetailController ()

@end

@implementation WLLegalDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self queryData];
}

- (void)queryData
{
    [ProgressHUD show];
    [WLApiManager queryCompanyDetailUserCode:self.usercode andCreditNumber:self.creditcode success:^(id  _Nullable response) {
        [ProgressHUD dismiss];
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
    }];
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

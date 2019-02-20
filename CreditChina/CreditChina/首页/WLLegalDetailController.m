//
//  WLLegalDetailController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLegalDetailController.h"
#import <WLPlatform.h>
#import "WLLegalDetailModel.h"

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
        NSDictionary *result = (NSDictionary *)response;
        WLLegalDetailModel *model = [WLLegalDetailModel getEnterproseDetailModel:result];
        NSLog(@"%@", model);
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
    }];
}

- (void)decorateTopView
{
    UILabel *company = [[UILabel alloc]init];
    company.text = @"辽宁立科科技发展有限公司";
    [self.view addSubview:company];
    
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

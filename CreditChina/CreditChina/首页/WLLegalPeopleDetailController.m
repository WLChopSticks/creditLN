//
//  WLLegalPeopleDetailController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLegalPeopleDetailController.h"
#import <WLPlatform.h>
#import "WLLegalDetailModel.h"

@interface WLLegalPeopleDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *uniqueCreditNo;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *creditNo;
@property (weak, nonatomic) IBOutlet UILabel *business;
@property (weak, nonatomic) IBOutlet UILabel *legalPeople;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *createTime;

@property (nonatomic, strong) WLLegalDetailModel *model;

@end

@implementation WLLegalPeopleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self queryData];
}

- (void)queryData
{
    [ProgressHUD show];
    [WLApiManager queryCompanyDetailUserCode:self.usercode andCreditNumber:self.creditcode success:^(id  _Nullable response) {
        [ProgressHUD dismiss];
        NSDictionary *result = (NSDictionary *)response;
        WLLegalDetailModel *model = [WLLegalDetailModel getEnterproseDetailModel:result];
        if (model.enterpriseInfo != nil)
        {
            self.model = model;
            [self fillTopViewContent];
        }else
        {
            [self showEmptyView];
        }
        
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
        [self showEmptyView];
    }];
}

- (void)fillTopViewContent
{
    WLEnterpriseInfo *enterpriseInfo = self.model.enterpriseInfo;
    self.company.text = enterpriseInfo.company;
    self.creditNo.text = enterpriseInfo.creditNo;
    self.uniqueCreditNo.text = enterpriseInfo.uniqueCreditNo;
    self.legalPeople.text = enterpriseInfo.legalPeople;
    self.money.text = enterpriseInfo.money;
    self.address.text = enterpriseInfo.address;
    self.business.text = enterpriseInfo.business;
    NSString *foundDate = enterpriseInfo.foundDate;
    self.createTime.text = [[foundDate componentsSeparatedByString:@" "]firstObject];
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

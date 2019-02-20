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
#import <WLSegmentTableViewController.h>
#import "WLLegalPeopleDetailDisplayController.h"

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
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic, weak) WLSegmentTableViewController *categoryTable;

@end

@implementation WLLegalPeopleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self decorateUI];
    [self queryData];
}

- (void)decorateUI
{
    
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
            [self fillCategoryTableContent];
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

- (void)fillCategoryTableContent
{
    WLSegmentTableViewController *categoryTable = [[WLSegmentTableViewController alloc]init];
    self.categoryTable = categoryTable;
    categoryTable.categoryWidth = Screen_Width;
    categoryTable.isTitlesEqualWidth = NO;
    
    
    //基本信息
    WLEnterpriseXzDetail *enterpriseDetail = self.model.enterpriseXzDetail;
    
    NSMutableArray *titles = [NSMutableArray array];
    for (WLEnterpriseDetailBlock *block in enterpriseDetail.enterpriseXzDetail)
    {
        if (block.typedepartmentname.length > 0)
        {
            [titles addObject:block.typedepartmentname];
        }
    }
    self.categoryTable.titles = titles;
    
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++)
    {
        WLLegalPeopleDetailDisplayController *vc = [[WLLegalPeopleDetailDisplayController alloc]init];
        WLEnterpriseDetailBlock *block = enterpriseDetail.enterpriseXzDetail[i];
        vc.block = block;
        [vcs addObject:vc];
    }
    self.categoryTable.controllers = vcs;
    
    [self.view addSubview:categoryTable.view];
    [self addChildViewController:categoryTable];
    
    [categoryTable.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
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

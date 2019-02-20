//
//  WLLegalPeopleDetailDisplayController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLegalPeopleDetailDisplayController.h"
#import "WLTableView.h"
#import <WLPlatform.h>
#import "WLLegalPeopleBasicInfoCell.h"
#import "WLLegalPeopleBusinessCell.h"

@interface WLLegalPeopleDetailDisplayController ()

@property (nonatomic, weak) WLTableView *tableView;

@end

@implementation WLLegalPeopleDetailDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    WLTableView *tableView = [[WLTableView alloc]init];
    tableView.wltableView.scrollEnabled = NO;
    NSArray *dataArr;
    if (self.block.xytype == 1)
    {
        
    }
    switch (self.block.xytype)
    {
        case 1:
            dataArr = [self fillBasicInfoCell];
            tableView.cellClass = [WLLegalPeopleBasicInfoCell class];
            [tableView registNibForCell:@"WLLegalPeopleBasicInfoCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
            break;
        case 2:
            dataArr = [self fillBusinessInfoCell];
            tableView.cellClass = [WLLegalPeopleBusinessCell class];
            [tableView registNibForCell:@"WLLegalPeopleBusinessCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
            break;
            
        default:
            break;
    }
    if (dataArr != nil)
    {
        tableView.rowsData = dataArr;
    }
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSArray *)fillBasicInfoCell
{
    NSMutableArray *dataM = [NSMutableArray array];
    NSArray *indexSets = self.block.indexedSets;
    for (WLEnterpriseIndexSet *indexSet in indexSets)
    {
        for (WLEnterpriseIndexSetData *indexSetData in indexSet.indexedSetData)
        {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            [dictM setObject:indexSetData.organiseName forKey:@"company"];
            [dictM setObject:indexSetData.organiseCode forKey:@"organiseNo"];
            [dictM setObject:indexSetData.gszch forKey:@"certificateNo"];
            [dictM setObject:indexSetData.organiseAddress forKey:@"address"];
            [dictM setObject:indexSetData.legalPeople forKey:@"legalPeople"];
            [dictM setObject:[indexSetData.firstCertificateDate componentsSeparatedByString:@" "].firstObject forKey:@"firstCertificateDate"];
            [dictM setObject:[indexSetData.validStartDate componentsSeparatedByString:@" "].firstObject forKey:@"validStartDate"];
            [dictM setObject:[indexSetData.validEndDate componentsSeparatedByString:@" "].firstObject forKey:@"validEndDate"];
            [dictM setObject:[indexSetData.latestReviewDate componentsSeparatedByString:@" "].firstObject forKey:@"latestReviewDate"];
            [dataM addObject:dictM];
            
        }
    }
    
    return dataM;
}

- (NSArray *)fillBusinessInfoCell
{
    NSMutableArray *dataM = [NSMutableArray array];
    NSArray *indexSets = self.block.indexedSets;
    for (WLEnterpriseIndexSet *indexSet in indexSets)
    {
        for (WLEnterpriseIndexSetData *indexSetData in indexSet.indexedSetData)
        {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            [dictM setObject:indexSetData.company forKey:@"company"];
            [dictM setObject:indexSetData.signupNo forKey:@"signupNo"];
            [dictM setObject:indexSetData.ASYear forKey:@"ASYear"];
            [dictM setObject:indexSetData.ASResult forKey:@"ASResult"];
            [dataM addObject:dictM];
        }
    }
    
    return dataM;
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

//
//  WLRewardsAndPunishExampleViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLRewardsAndPunishExampleViewController.h"
#import "WLRewardsAndPunishEgTableViewCell.h"
#import "WLTableView.h"
#import <Masonry.h>
#import "WLCommonTool.h"
#import "WLNetworkTool.h"
#import "WLRewardsAndPunishDetailController.h"

@interface WLRewardsAndPunishExampleViewController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLTableView *tableView;

@end

@implementation WLRewardsAndPunishExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    self.title = @"联合奖惩案例";
    WLTableView *tableView = [[WLTableView alloc]init];
    self.tableView = tableView;
    tableView.cellClass = [WLRewardsAndPunishEgTableViewCell class];
    [tableView registNibForCell:@"WLRewardsAndPunishEgTableViewCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self queryData];
}

- (void)queryData
{
    [ProgressHUD show];
    [WLApiManager  queryRewardsAndPunishExampleType:self.exampleType andExampleName:nil andSubjectName:nil page:1 success:^(id  _Nullable response) {
        [ProgressHUD dismiss];
        NSDictionary *result = (NSDictionary *)response;
        NSArray *data = [self constructLosePromiseCellContentDict:result];
        if (data.count > 0)
        {
            self.tableView.rowsData = [self constructLosePromiseCellContentDict:result];
        }else
        {
            [self showEmptyView];
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
        [self showEmptyView];
    }];
}

- (NSArray *)constructLosePromiseCellContentDict: (NSDictionary *)result
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    NSArray *dataList = result[@"rows"];
    
    for (NSDictionary *model in dataList) 
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:model[@"datacasename"] forKey:@"caseName"];
        [constructingDict setObject:model[@"datapunishtypename"] forKey:@"symbol"];
        [constructingDict setObject:model[@"datameasuresname"] forKey:@"subtitle"];
        [constructingDict setObject:model[@"datacasetime"] forKey:@"time"];
        [constructingArr addObject:constructingDict];
    }

    return constructingArr;
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    WLRewardsAndPunishDetailController *vc = [[WLRewardsAndPunishDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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

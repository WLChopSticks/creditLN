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
    WLNetworkTool *networkTool = [WLNetworkTool sharedNetworkToolManager];
    NSMutableString *URL = [NSMutableString stringWithString:networkTool.queryAPIList[@"getdatareportings"]];
    
    NSString *counterpart = @"xzxdrmc";
    NSString *page = @"1";
    NSString *pageSize = @"10";
    [URL appendString:[NSString stringWithFormat:@"/%@",self.keepOrBreakPromise]];
    [URL appendString:[NSString stringWithFormat:@"/%@",counterpart]];
    [URL appendString:[NSString stringWithFormat:@"/%@",page]];
    [URL appendString:[NSString stringWithFormat:@"/%@",pageSize]];
    NSString *urlString = [NSString stringWithString:URL];
    urlString = @"http://223.100.2.221:8383/credit-webservice-app/restwebservice/app/datacase/getdatacase/%E6%B2%88%E9%98%B3%E5%B8%82%E6%9D%BE%E9%99%B5%E5%B7%A5%E5%85%B7%E5%8E%82/%E6%B2%88%E9%98%B3%E5%B8%82%E6%9D%BE%E9%99%B5%E5%B7%A5%E5%85%B7%E5%8E%82/2/1/10";
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    [networkTool GET_queryWithURL:urlString andParameters:nil success:^(id  _Nullable responseObject) {
        
        NSDictionary *result = (NSDictionary *)responseObject;
        self.tableView.rowsData = [self constructLosePromiseCellContentDict:result];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (NSArray *)constructLosePromiseCellContentDict: (NSDictionary *)model
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    NSArray *dataList = model[@"rows"];
//    for (NSDictionary *dataDict in dataList)
//    {
//        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
//        [constructingDict setObject:dataDict[@"datacasename"] forKey:@"caseName"];
//        [constructingDict setObject:dataDict[@"datapunishtypename"] forKey:@"symbol"];
//        [constructingDict setObject:dataDict[@"datacasesubjectsname"] forKey:@"subtitle"];
//        NSInteger times = [dataDict[@"datacaseupdatetime"]integerValue];
//        [constructingDict setObject:[WLCommonTool transferTimeFormatWIthTime:times] forKey:@"time"];
//
//        [constructingArr addObject:constructingDict];
//    }
    
    for (int i = 0; i < 10; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:@"辽宁华杰医药物流有限公司" forKey:@"caseName"];
        [constructingDict setObject:@"黑名单" forKey:@"symbol"];
        [constructingDict setObject:@"税务总局_重大税收违法案件当事人名单" forKey:@"subtitle"];
        [constructingDict setObject:@"2010-00-00" forKey:@"time"];
        
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

//
//  WLRewardsAndPunishExampleViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLRewardsAndPunishExampleViewController.h"
#import "WLDoublePublicityCell.h"
#import "WLTableView.h"
#import <Masonry.h>
#import "WLCommonTool.h"
#import "WLNetworkTool.h"

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
    tableView.cellClass = [WLDoublePublicityCell class];
    [tableView registNibForCell:@"WLDoublePublicityCell" andBundleName:@"WLControls"];
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
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    [networkTool GET_queryWithURL:urlString andParameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
//        WLDoublePublicityModel *model = [[WLDoublePublicityModel alloc]init];
//        model = [model getModel:result];
        self.tableView.rowsData = [self constructLosePromiseCellContentDict:result];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell %ld", indexPath.row);
}

- (NSArray *)constructLosePromiseCellContentDict: (NSDictionary *)model
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    
//    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
    for (int i = 0; i < 10; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:@"辽宁省守信案例实例一" forKey:@"publicityType"];
        NSString *symbolString = @"";
        if ([self.keepOrBreakPromise isEqualToString:@"1"])
        {
            symbolString = @"守信激励案例";
        }else
        {
            symbolString = @"失信惩戒案例";
        }
        [constructingDict setObject:symbolString forKey:@"symbolString"];
        [constructingDict setObject:[WLCommonTool transferTimeFormatWIthTime:213231221312] forKey:@"updateTime"];
        
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
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

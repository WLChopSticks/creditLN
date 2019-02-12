//
//  WLDoublePublicityViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/30.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLDoublePublicityViewController.h"
#import <WLPlatform.h>
#import "WLTableView.h"
#import "WLDoublePublicitysTableViewCell.h"
#import "WLDoublePublicityModel.h"
#import "WLDoublePolicyDetailViewController.h"

@interface WLDoublePublicityViewController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLTableView *tableView;

@end

@implementation WLDoublePublicityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)decorateUI
{
    WLTableView *tableView = [[WLTableView alloc]init];
    self.tableView = tableView;
    tableView.wltableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.cellClass = [WLDoublePublicitysTableViewCell class];
    [tableView registNibForCell:@"WLDoublePublicitysTableViewCell"  inBundel:[NSBundle mainBundle] orBundleName:@"WLControls"];
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
    [URL appendString:[NSString stringWithFormat:@"/%@",self.doublePubliciryType]];
    [URL appendString:[NSString stringWithFormat:@"/%@",counterpart]];
    [URL appendString:[NSString stringWithFormat:@"/%@",page]];
    [URL appendString:[NSString stringWithFormat:@"/%@",pageSize]];
    NSString *urlString = [NSString stringWithString:URL];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    [networkTool GET_queryWithURL:urlString andParameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        WLDoublePublicityModel *model = [[WLDoublePublicityModel alloc]init];
        model = [model getModel:result];
        if ([self.doublePubliciryType isEqualToString:@"1"])
        {
            self.tableView.rowsData = [self constructPunishCellContentDict:model];
        }else if ([self.doublePubliciryType isEqualToString:@"2"])
        {
            self.tableView.rowsData = [self constructPermissionCellContentDict:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (NSArray *)constructPunishCellContentDict: (WLDoublePublicityModel *)model
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];

        [constructingDict setObject:detailModel.xzxdrmc forKey:@"company"];
        [constructingDict setObject:detailModel.etablename forKey:@"content"];
        [constructingDict setObject:[WLCommonTool transferTimeFormatWIthTime:detailModel.updatetime] forKey:@"time"];
        [constructingDict setObject:detailModel.xzcfjdswh forKey:@"shuwenhao"];
        [constructingArr addObject:constructingDict];
    }
    
//    for (int i = 0; i < 10; i++)
//    {
//        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
//        
//        [constructingDict setObject:@"鞍钢股份有限公司" forKey:@"company"];
//        [constructingDict setObject:@"关于对鞍钢股份有限公司的处罚" forKey:@"content"];
//        [constructingDict setObject:@"2019-01-23" forKey:@"time"];
//        [constructingDict setObject:@"鞍环罚决字[2018]第(11006)号" forKey:@"shuwenhao"];
//        [constructingArr addObject:constructingDict];
//    }
    
    return constructingArr;
}

- (NSArray *)constructPermissionCellContentDict: (WLDoublePublicityModel *)model
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    
//    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
//    {
//        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
//
//        [constructingDict setObject:detailModel.xzxdrmc forKey:@"company"];
//        [constructingDict setObject:detailModel.cfsy forKey:@"content"];
//        [constructingDict setObject:[WLCommonTool transferTimeFormatWIthTime:detailModel.updatetime] forKey:@"time"];
//        [constructingDict setObject:detailModel.xzxkjdswh forKey:@"shuwenhao"];
//        [constructingArr addObject:constructingDict];
//    }
    
    for (int i = 0; i < 10; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        
        [constructingDict setObject:@"丹东边境经济合作区泰金木制品加工厂" forKey:@"company"];
        [constructingDict setObject:@"木材运输证" forKey:@"content"];
        [constructingDict setObject:@"2019-01-24" forKey:@"time"];
        [constructingDict setObject:@"XKCG0005000119005" forKey:@"shuwenhao"];
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell %ld", indexPath.row);
    WLDoublePolicyDetailViewController *vc = [[WLDoublePolicyDetailViewController alloc]init];
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

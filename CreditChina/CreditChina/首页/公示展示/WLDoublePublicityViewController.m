//
//  WLDoublePublicityViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/30.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLDoublePublicityViewController.h"
#import "WLFourItemsCell.h"
#import "WLTableView.h"
#import <Masonry.h>
#import "WLNetworkTool.h"
#import "WLDoublePublicityCell.h"
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
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
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
        self.tableView.rowsData = [self constructPunishCellContentDict:model];
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
        [constructingDict setObject:detailModel.wfxwlx forKey:@"publicityType"];
        NSString *symbolString = @"";
        if ([self.doublePubliciryType isEqualToString:@"2"])
        {
            symbolString = @"行政许可";
        }
        if ([self.doublePubliciryType isEqualToString:@"1"])
        {
            symbolString = @"行政处罚";
        }
        [constructingDict setObject:symbolString forKey:@"symbolString"];
        [constructingDict setObject:[WLCommonTool transferTimeFormatWIthTime:detailModel.updatetime] forKey:@"updateTime"];
        
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

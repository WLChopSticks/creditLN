//
//  WLDoublePolicyDetailViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/5.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLDoublePolicyDetailViewController.h"
#import "WLPlatform.h"
#import "WLChartRatioTableViewCell.h"
#import "WLTableView.h"
#import "WLDoublePublicityModel.h"

#define FirstItemWidthRaio 3
#define SecondItemWidthRaio 7
#define THirdItemWidthRaio 0

@interface WLDoublePolicyDetailViewController ()

@property (nonatomic, strong) NSString *pageTitle;
@property (nonatomic, strong) NSDictionary *contentDict;

@end

@interface WLDoublePolicyDetailViewController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLTableView *tableView;

@end

@implementation WLDoublePolicyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    [self decorateUI];
}

- (void)decorateUI
{
    self.title = @"行政处罚";
    WLTableView *tableView = [[WLTableView alloc]init];
    self.tableView = tableView;
    tableView.cellClass = [WLChartRatioTableViewCell class];
    tableView.delegate = self;
    tableView.wltableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [URL appendString:[NSString stringWithFormat:@"/%@",@"1"]];
    [URL appendString:[NSString stringWithFormat:@"/%@",counterpart]];
    [URL appendString:[NSString stringWithFormat:@"/%@",page]];
    [URL appendString:[NSString stringWithFormat:@"/%@",pageSize]];
    NSString *urlString = [NSString stringWithString:URL];
    urlString = @"http://223.100.2.221:8383/credit-webservice-app/restwebservice/app/datareportings/getdetails/1/20190130150637698899";
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    [networkTool GET_queryWithURL:urlString andParameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
//        WLDoublePublicityModel *model = [[WLDoublePublicityModel alloc]init];
//        WLDoublePublicityDetailModel *detailModel = [model detailGetModel:result];
        self.tableView.rowsData = [self constructCellContentDict:result];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (NSArray *)constructCellContentDict: (NSDictionary *)model
{
    
    NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
    NSMutableArray *keyArr = [NSMutableArray array];
    [constructingDict setObject:model[@"xzcfjdswh"] forKey:[WLKeyValueStandard getFullStringFromAbbreviation:@"xzcfjdswh"]];
    [keyArr addObject:[WLKeyValueStandard getFullStringFromAbbreviation:@"xzcfjdswh"]];
    
    [constructingDict setObject:model[@"xzxdrmc"] forKey:[WLKeyValueStandard getFullStringFromAbbreviation:@"xzxdrmc"]];
    [keyArr addObject:[WLKeyValueStandard getFullStringFromAbbreviation:@"xzxdrmc"]];
    
    [constructingDict setObject:model[@"xzxdrlb"] forKey:[WLKeyValueStandard getFullStringFromAbbreviation:@"xzxdrlb"]];
    [keyArr addObject:[WLKeyValueStandard getFullStringFromAbbreviation:@"xzxdrlb"]];
    
    [constructingDict setObject:model[@"cfsy"] forKey:[WLKeyValueStandard getFullStringFromAbbreviation:@"cfsy"]];
    [keyArr addObject:[WLKeyValueStandard getFullStringFromAbbreviation:@"cfsy"]];
    
    [constructingDict setObject:model[@"cfyj"] forKey:[WLKeyValueStandard getFullStringFromAbbreviation:@"cfyj"]];
    [keyArr addObject:[WLKeyValueStandard getFullStringFromAbbreviation:@"cfyj"]];
    
    [constructingDict setObject:model[@"cflb"] forKey:[WLKeyValueStandard getFullStringFromAbbreviation:@"cflb"]];
    [keyArr addObject:[WLKeyValueStandard getFullStringFromAbbreviation:@"cflb"]];
    
    [constructingDict setObject:model[@"cfnr"] forKey:[WLKeyValueStandard getFullStringFromAbbreviation:@"cfnr"]];
    [keyArr addObject:[WLKeyValueStandard getFullStringFromAbbreviation:@"cfnr"]];
    
    [constructingDict setObject:[NSString stringWithFormat:@"%@",model[@"cfjdrq"]] forKey:[WLKeyValueStandard getFullStringFromAbbreviation:@"cfjdrq"]];
    [keyArr addObject:[WLKeyValueStandard getFullStringFromAbbreviation:@"cfjdrq"]];
    
    [constructingDict setObject:model[@"cfjg"] forKey:[WLKeyValueStandard getFullStringFromAbbreviation:@"cfjg"]];
    [keyArr addObject:[WLKeyValueStandard getFullStringFromAbbreviation:@"cfjg"]];
    
    
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    for (NSString *key in keyArr)
    {
        NSMutableDictionary * tempDict = [NSMutableDictionary dictionary];
        [tempDict setObject:key forKey:@"firstItem"];
        [tempDict setObject:constructingDict[key] forKey:@"secondItem"];
        [tempDict setObject:@"" forKey:@"thirdItem"];
        [tempDict setObject:[NSNumber numberWithInteger:FirstItemWidthRaio] forKey:@"firstItemWidth"];
        [tempDict setObject:[NSNumber numberWithInteger:SecondItemWidthRaio] forKey:@"secondItemWidth"];
        [tempDict setObject:[NSNumber numberWithInteger:THirdItemWidthRaio] forKey:@"thirdItemWidth"];
        [tempDict setObject:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1] forKey:@"firstItemBackground"];
        [constructingArr addObject:tempDict];
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

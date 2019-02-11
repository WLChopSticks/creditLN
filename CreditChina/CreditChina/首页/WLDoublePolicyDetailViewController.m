//
//  WLDoublePolicyDetailViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/5.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLDoublePolicyDetailViewController.h"
#import "WLPlatform.h"
#import "WLSectionHeaderCell.h"
#import "WLTableView.h"

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
    tableView.cellClass = [WLSectionHeaderCell class];
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
//        model = [model getModel:result];
        self.tableView.rowsData = [self constructCellContentDict:result];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (NSArray *)constructCellContentDict: (NSDictionary *)model
{
    
    NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
    [constructingDict setObject:@"国家" forKey:@"数据来源"];
    [constructingDict setObject:@"行政处罚" forKey:@"数据类别"];
    [constructingDict setObject:@"北京卓宏润酒店管理有限公司" forKey:@"行政相对人名称"];
    [constructingDict setObject:@"91110106784834803J" forKey:@"统一社会信用代码"];
    [constructingDict setObject:@"110106009267488" forKey:@"工商注册号"];
    [constructingDict setObject:@"784834803" forKey:@"组织机构代码"];
    [constructingDict setObject:@"" forKey:@"税务登记号"];
    [constructingDict setObject:@"" forKey:@"法定代表人"];
    [constructingDict setObject:@"（京丰）安监罚【2018】执-19号" forKey:@"行政处罚决定书文号"];
    [constructingDict setObject:@"生产安全事故应急救援预案违法" forKey:@"违法事实"];
    [constructingDict setObject:@"中华人民共和国安全生产法第九十四条第五项" forKey:@"处罚依据"];
    [constructingDict setObject:@"罚款" forKey:@"处罚类别"];
    [constructingDict setObject:@"空" forKey:@"处罚内容"];
    
    NSArray *keyArr = @[@"数据来源",@"数据类别",@"行政相对人名称",@"统一社会信用代码",@"工商注册号",@"组织机构代码",@"税务登记号",@"法定代表人",@"行政处罚决定书文号",@"违法事实",@"处罚依据",@"处罚类别",@"处罚内容"];
    
    
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

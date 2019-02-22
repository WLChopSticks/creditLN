//
//  WLCreditReportViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLCreditReportViewController.h"
#import "WLSectionHeaderTableView.h"
#import "WLSectionHeaderCell.h"
#import "WLPlatform.h"
#import "WLDoublePublicityCell.h"

#define FirstItemWidthRaio 7
#define SecondItemWidthRaio 2
#define THirdItemWidthRaio 3

@interface WLCreditReportViewController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLSectionHeaderTableView *sectionHeadertableView;
@property (nonatomic, weak) WLTableView *tableView;

@end

@implementation WLCreditReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    self.title = @"信用报告";
    if ([self.publicityOrSystem isEqualToString:@"1"])
    {
        WLSectionHeaderTableView *tableView = [[WLSectionHeaderTableView alloc]init];
        tableView.wltableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.firstItemTitle = @"企业名称";
        tableView.secondItemTitle = @"信用等级";
        tableView.thirdItemTitle = @"有效时间";
        tableView.firstItemWidthRatio = FirstItemWidthRaio;
        tableView.secondItemWidthRatio = SecondItemWidthRaio;
        tableView.thirdItemWidthRatio = THirdItemWidthRaio;
        self.sectionHeadertableView = tableView;
        tableView.cellClass = [WLSectionHeaderCell class];
        tableView.delegate = self;
        [self.view addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        [self queryData];
    }else
    {
        WLTableView *tableView = [[WLTableView alloc]init];
        self.tableView = tableView;
        tableView.cellClass = [WLDoublePublicityCell class];
        [tableView registNibForCell:@"WLDoublePublicityCell"  inBundel:nil orBundleName:@"WLControls"];
        tableView.delegate = self;
        [self.view addSubview:tableView];

        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];

        [self queryData];
    }
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
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    [networkTool GET_queryWithURL:urlString andParameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        //        WLDoublePublicityModel *model = [[WLDoublePublicityModel alloc]init];
        //        model = [model getModel:result];
        if ([self isPublicity])
        {
            self.sectionHeadertableView.rowsData = [self constructPublicityCellContentDict:result];
            [self.sectionHeadertableView reloadData];
        }else
        {
            self.tableView.rowsData = [self constructSystemCellContentDict:result];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (NSArray *)constructPublicityCellContentDict: (NSDictionary *)model
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    //    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
    for (int i = 0; i < 10; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:@"辽宁力诚科技发展有限公司" forKey:@"firstItem"];
        [constructingDict setObject:@"A" forKey:@"secondItem"];
        [constructingDict setObject:[WLCommonTool transferTimeFormatWIthTime:13231221312] forKey:@"thirdItem"];
        
        [constructingDict setObject:[NSNumber numberWithInteger:FirstItemWidthRaio] forKey:@"firstItemWidth"];
        [constructingDict setObject:[NSNumber numberWithInteger:SecondItemWidthRaio] forKey:@"secondItemWidth"];
        [constructingDict setObject:[NSNumber numberWithInteger:THirdItemWidthRaio] forKey:@"thirdItemWidth"];
        
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

- (NSArray *)constructSystemCellContentDict: (NSDictionary *)model
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    //    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
    for (int i = 0; i < 10; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:@"辽宁省人民政府办公厅转发省政府金融办关于加快发展科技金融 推进科技创新实施意见的通知" forKey:@"publicityType"];
        [constructingDict setObject:@"信用报告制度" forKey:@"symbolString"];
        [constructingDict setObject:[WLCommonTool transferTimeFormatWIthTime:13231221312] forKey:@"updateTime"];
        
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

- (BOOL)isPublicity
{
    return [self.publicityOrSystem isEqualToString:@"1"];
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

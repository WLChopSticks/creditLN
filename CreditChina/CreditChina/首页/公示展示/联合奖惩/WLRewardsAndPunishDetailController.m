//
//  WLRewardsAndPunishDetailController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/11.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLRewardsAndPunishDetailController.h"
#import "WLPlatform.h"
#import "WLChartRatioTableViewCell.h"
#import "WLTableView.h"

#define FirstItemWidthRaio 3
#define SecondItemWidthRaio 7
#define THirdItemWidthRaio 0

@interface WLRewardsAndPunishDetailController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLTableView *tableView;

@end

@implementation WLRewardsAndPunishDetailController

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
    urlString = @"http://223.100.2.221:8383/credit-webservice-app/restwebservice/app/datacase/getdatacaseDetail/20180823154405019343/111/111";
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
    [constructingDict setObject:model[@"datacasename"] forKey:@"案例名称"];
    [constructingDict setObject:model[@"creditsubject"] forKey:@"信用主体名称"];
    [constructingDict setObject:model[@"datacasetime"] forKey:@"奖惩时间"];
    [constructingDict setObject:model[@"dictionaryname"] forKey:@"奖惩类型"];
    [constructingDict setObject:model[@"datacasenote"] forKey:@"案例描述"];
    [constructingDict setObject:model[@"userdepartmentname"] forKey:@"实施部门"];
    [constructingDict setObject:model[@"datameasuresname"] forKey:@"惩戒措施"];
    [constructingDict setObject:model[@"datameasuresnote"] forKey:@"法律及政策依据"];
   
    
    
    
    NSArray *keyArr = @[@"案例名称",@"信用主体名称",@"奖惩类型",@"奖惩时间",@"案例描述",@"实施部门",@"惩戒措施",@"法律及政策依据"];
    
    
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

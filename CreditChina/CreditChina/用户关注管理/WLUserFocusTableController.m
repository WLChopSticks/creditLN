//
//  WLUserFocusTableController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLUserFocusTableController.h"
#import "WLTableView.h"
#import "WLFourItemsCell.h"
#import <Masonry.h>
#import "WLTitleContentTimeCell.h"
#import <WLPlatform.h>

@interface WLUserFocusTableController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLTableView *tableView;

@end

@implementation WLUserFocusTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
    
}

- (void)decorateUI
{
    WLTableView *tableView = [[WLTableView alloc]init];
    self.tableView = tableView;
    tableView.cellClass = [WLTitleContentTimeCell class];
    [tableView registNibForCell:@"WLTitleContentTimeCell" andBundleName:@"WLControls"];
    tableView.rowsData = @[@{@"title":@"234",@"内容":@"普通"},@{@"标题":@"234",@"内容":@"普通"},@{@"标题":@"234",@"内容":@"普通"},@{@"标题":@"234",@"内容":@"普通"},@{@"标题":@"234",@"内容":@"普通"}];
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
        self.tableView.rowsData = [self constructCellContentDict:result];
        [self.tableView reloadData];
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (NSArray *)constructCellContentDict: (NSDictionary *)model
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    //    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
    
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:@"政府网站工作年度报表" forKey:@"title"];
        [constructingDict setObject:@"" forKey:@"content"];
        [constructingDict setObject:[WLCommonTool transferTimeFormatWIthTime:13231221312] forKey:@"time"];
        [constructingDict setObject:@"省内动态"forKey:@"type"];
        [constructingArr addObject:constructingDict];
        
        NSMutableDictionary * constructingDict1 = [NSMutableDictionary dictionary];
        [constructingDict1 setObject:@"关于事业单位转企后涉及信用评估相关问题处理意见的公告" forKey:@"title"];
        [constructingDict1 setObject:@"" forKey:@"content"];
        [constructingDict1 setObject:[WLCommonTool transferTimeFormatWIthTime:13231221312] forKey:@"time"];
        [constructingDict1 setObject:@"省内动态"forKey:@"type"];
        [constructingArr addObject:constructingDict1];
        
        NSMutableDictionary * constructingDict2 = [NSMutableDictionary dictionary];
        [constructingDict2 setObject:@"“信用沈阳”：创新建设模式 优化营商环境" forKey:@"title"];
        [constructingDict2 setObject:@"近年来，在国家、省发展改革委的指导下，在沈阳市委、市政府的正确领导下，在沈阳市信用办的综合协调下，经过领导小组成员单位的共同努力，沈阳市以信用制度建设为保障，以沈阳市公共信用信息平台为支撑，以政务诚信、商务诚信、社会诚信和司法公信为主要内容，以创建社会信用体系建设示范城市为契机，以危害群众利益、损害市场公平等突出问题为导向，以守信联合激励和失信联合惩戒机制为手段，以诚信宣传教育为引领，逐步提高全社会诚信意识和诚信水平。" forKey:@"content"];
        [constructingDict2 setObject:[WLCommonTool transferTimeFormatWIthTime:13231221312] forKey:@"time"];
        [constructingDict2 setObject:@"省内动态"forKey:@"type"];
        [constructingArr addObject:constructingDict2];
        
        NSMutableDictionary * constructingDict3 = [NSMutableDictionary dictionary];
        [constructingDict3 setObject:@"“信用大连”：强化体制机制 突出创新发展" forKey:@"title"];
        [constructingDict3 setObject:@"作为全国第二批创建社会信用体系建设示范城市之一，大连市近年来不断完善体制机制，加大信用体系平台建设力度，在社会信用体系建设方面取得了积极成效。在本轮事业单位改革中，大连市重新组建市政府直属的大连市信用中心，这在全国属于首例。此外，大连市还全面加强顶层设计，出台《关于进一步加快推进社会信用体系建设的实施方案》，从四大领域、30多个行业全面推动大连市信用体系建设再上新台阶。" forKey:@"content"];
        [constructingDict3 setObject:[WLCommonTool transferTimeFormatWIthTime:13231221312] forKey:@"time"];
        [constructingDict3 setObject:@"省内动态"forKey:@"type"];
        [constructingArr addObject:constructingDict3];
        
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

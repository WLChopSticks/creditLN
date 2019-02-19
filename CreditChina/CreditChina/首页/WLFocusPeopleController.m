//
//  WLFocusPeopleController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/19.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLFocusPeopleController.h"
#import <WLTableView.h>
#import <WLPlatform.h>
#import <WLFourItemsCell.h>
#import "WLFocusPeopleResultCell.h"

@interface WLFocusPeopleController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLTableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation WLFocusPeopleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    WLTableView *tableView = [[WLTableView alloc]init];
//    tableView.backgroundColor = [UIColor redColor];
    self.tableView = tableView;
    tableView.cellClass = [WLBaseTableViewCell class];
//    tableView.wltableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self queryFocusPeopleClass];
}

- (void)queryFocusPeopleClass
{
    [ProgressHUD show];
    [WLApiManager queryFocusPeopleClassWithSuccess:^(id  _Nullable response) {
        [ProgressHUD dismiss];
        NSDictionary *result = (NSDictionary *)response;
        self.dataArray = [self constructCellContentDict:result];
        self.tableView.rowsData = self.dataArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
    }];
}

- (NSArray *)constructCellContentDict: (NSDictionary *)dict
{
    NSArray *peoplename = dict[@"personlist"];
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    for (int i = 0; i < peoplename.count; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:peoplename[i][@"peoplename"] forKey:@"title"];
        [constructingDict setObject:peoplename[i][@"datapeoplequerycode"] forKey:@"parameter"];
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *type = self.dataArray[indexPath.row][@"parameter"];
    [self.tableView registNibForCell:@"WLFocusPeopleResultCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
    [ProgressHUD show];
    [WLApiManager queryFocusPeopleDatatype:type andName:nil andCerticateNo:nil page:1 success:^(id  _Nullable response) {
        [ProgressHUD dismiss];
        NSDictionary *result = (NSDictionary *)response;
        self.dataArray = [self constructFocusPeopleCellContentDict:result];
        self.tableView.rowsData = self.dataArray;
        self.tableView.cellClass = [WLFocusPeopleResultCell class];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
    }];
}

- (NSArray *)constructFocusPeopleCellContentDict: (NSDictionary *)dict
{
    NSArray *focusPeople = dict[@"rows"];
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    for (NSDictionary *dict in focusPeople)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:[WLCommonTool getValue:dict Key:@"zgrxm" default:@""] forKey:@"name"];
        [constructingDict setObject:[WLCommonTool getValue:dict Key:@"zczsmc" default:@""] forKey:@"job"];
        [constructingDict setObject:[WLCommonTool getValue:dict Key:@"zyzgdj" default:@""] forKey:@"grade"];
        [constructingDict setObject:[WLCommonTool getValue:dict Key:@"gaid" default:@""] forKey:@"idCard"];
        [constructingDict setObject:[WLCommonTool getValue:dict Key:@"zczsbh" default:@""] forKey:@"number"];
        
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

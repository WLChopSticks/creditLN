//
//  WLQueryCreditInfoViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLQueryCreditInfoViewController.h"
#import <WLPlatform.h>
#import "WLSearchConditionCell.h"
#import "WLTableView.h"
#import "WLLegalPeopleSearchResultCell.h"
#import "WLFocusPeopleResultCell.h"
#import "WLPersonResultCell.h"
#import "WLLegalPeopleDetailController.h"

@interface WLQueryCreditInfoViewController ()<wlTableViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) UIView *bigCategoryBackView;
//0为法人信用查询, 1为重点人群信用查询, 2为个人身份核实
@property (nonatomic, assign) NSInteger searchType;
@property (nonatomic, weak) UISegmentedControl *searchCategory;
@property (nonatomic, weak) UIButton *filterBtn;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, weak) WLTableView *tableView;
@property (nonatomic, weak) WLTableView *searchResulTableView;
@property (nonatomic, strong) NSArray *rowsData;
@property (nonatomic, strong) NSArray *searchResultRowsData;

//不同种类时, 条件tableview的高度
@property (nonatomic, assign) NSInteger legalPersonFilterHeight;
@property (nonatomic, assign) NSInteger focusPeopleFilterHeight;

@end

@implementation WLQueryCreditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
//    [self decorateBigCategoryView];
    [self decorateNavigationBarSearchBar];
//    [self decorateFilterView];
//    [self decorateTopView];
    [self decorateSearchResultTaleView];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnDidClicking:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}

- (void)decorateNavigationBarSearchBar
{
    UITextField *searchField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    self.searchField = searchField;
    searchField.delegate = self;
    searchField.borderStyle = UITextBorderStyleRoundedRect;
    NSString *holderText = @"请输入企业法人/法人名称";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, holderText.length)];
    searchField.attributedPlaceholder = placeholder;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    UIImageView *searchLeftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    searchLeftImageView.image = [UIImage imageNamed:@"search"];
    [leftView addSubview:searchLeftImageView];
    searchField.leftViewMode = UITextFieldViewModeAlways;
    
    searchField.leftView = leftView;
    self.navigationItem.titleView = searchField;
    [searchField becomeFirstResponder];
    self.searchKey = @"立科科技";
}

- (void)decorateTopView
{
    NSArray *categoryTitles = @[@"法人信用查询",@"重点人群查询",@"个人身份核实"];
    UISegmentedControl *searchCategory = [[UISegmentedControl alloc]initWithItems:categoryTitles];
    searchCategory.alpha = 0;
    self.searchCategory = searchCategory;
    searchCategory.tintColor = [UIColor redColor];
    searchCategory.frame = CGRectMake(10, 5, self.view.frame.size.width - 50, 30);
    searchCategory.selectedSegmentIndex = 0;
    [searchCategory addTarget:self action:@selector(searchCategorySegmentDidClicking:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:searchCategory];
    
    UIButton *filterBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.searchCategory.frame) + 5, 5, 30, 30)];
    [filterBtn setImage:[UIImage imageNamed:@"filterBtn"] forState:UIControlStateNormal];
    [filterBtn setImage:[UIImage imageNamed:@"filterBtn"] forState:UIControlStateSelected];
    self.filterBtn = filterBtn;
    filterBtn.alpha = 0;
    [self.view addSubview:filterBtn];
//    filterBtn.backgroundColor = [UIColor redColor];
    [filterBtn addTarget:self action:@selector(filterBtnDidClicking:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)decorateFilterView
{
    WLTableView *tableView = [[WLTableView alloc]init];
    self.tableView = tableView;
    tableView.clipsToBounds = YES;
    tableView.cellClass = [WLSearchConditionCell class];
    tableView.wltableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [WLCommonTool makeViewShowingWithRoundCorner:tableView andRadius:10];
    int width = self.view.frame.size.width - 50;
    int x = self.view.frame.size.width * 0.5 - width * 0.5;
    int y = 40;
    int height = 0;
    tableView.frame = CGRectMake(x, y, width, height);
}

- (void)decorateSearchResultTaleView
{
    WLTableView *resultTableView = [[WLTableView alloc]init];
    self.searchResulTableView = resultTableView;
    resultTableView.backgroundColor = [UIColor redColor];
    resultTableView.cellClass = [WLLegalPeopleSearchResultCell class];
    [resultTableView registNibForCell:@"WLLegalPeopleSearchResultCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
//    [resultTableView registNibForCell:@"WLFocusPeopleResultCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
//    [resultTableView registNibForCell:@"WLPersonResultCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
    resultTableView.wltableView.separatorStyle = UITableViewCellSelectionStyleNone;
    resultTableView.delegate = self;
    [self.view addSubview:resultTableView];
    int width = self.view.frame.size.width - 20;
    int x = 10;
    int y = CGRectGetMaxY(self.searchCategory.frame) + 5;
    int height = self.view.frame.size.height - y;
    resultTableView.frame = CGRectMake(x, y, width, height);
    
    [resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)decorateBigCategoryView
{
    UIView *bigCategoryBackView = [[UIView alloc]init];
    self.bigCategoryBackView = bigCategoryBackView;
    [self.view addSubview:bigCategoryBackView];
    int width = self.view.frame.size.width - 50;
    int height = 300;
    int x = self.view.frame.size.width * 0.5 - width * 0.5;
    int y = self.view.frame.size.height * 0.5 - height * 0.6;
    bigCategoryBackView.frame = CGRectMake(x, y, width, height);
    
    NSArray *buttonTitles = @[@"法人信用查询",@"重点人群查询",@"个人身份核实"];
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        [WLCommonTool makeViewShowingWithRoundCorner:button andRadius:10];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"red_background"] forState:UIControlStateNormal];
        [bigCategoryBackView addSubview:button];
        [button addTarget:self action:@selector(bigSearchCategoryDidClicking:) forControlEvents:UIControlEventTouchUpInside];
        
        int width = bigCategoryBackView.frame.size.width;
        int height = 50;
        int x = 0;
        int y = 0 + i * (height + 20);
        button.frame = CGRectMake(x, y, width, height);
        
    }
    
}

- (void)rightBtnDidClicking: (UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)bigSearchCategoryDidClicking: (UIButton *)sender
{
    NSLog(@"选择了大搜索种类");
    self.searchType = sender.tag;
    self.searchCategory.selectedSegmentIndex = sender.tag;
    [self searchCategorySegmentDidClicking:self.searchCategory];
    [UIView animateWithDuration:0.5 animations:^{
        self.bigCategoryBackView.alpha = 0;
        self.searchCategory.alpha = 1;
        self.filterBtn.alpha = 1;
    }];
    self.navigationItem.titleView = self.searchField;

}

- (void)showConditionTableView
{
    self.filterBtn.selected = !self.filterBtn.selected;
    NSInteger height = 100;
    switch (self.searchType)
    {
        case 0:
        {
            height = self.legalPersonFilterHeight;
            break;
        }
        case 1:
        {
            height = self.focusPeopleFilterHeight;
            break;
        }
        case 2:
        {
            height = 0;
            break;
        }

        default:
            break;
    }
    
    
    int width = self.view.frame.size.width - 50;
    int x = self.view.frame.size.width * 0.5 - width * 0.5;
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(x, 40, width, height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissConditionTableView
{
    self.filterBtn.selected = !self.filterBtn.selected;
    int width = self.view.frame.size.width - 50;
    int x = self.view.frame.size.width * 0.5 - width * 0.5;
    int y = 40;
    int height = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)filterBtnDidClicking: (UIButton *)sender
{
    NSLog(@"点击了筛选按钮");
    [self.view bringSubviewToFront:self.tableView];
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        if (self.searchType == 0)
        {
            self.rowsData = @[@{@"condition":@"不限", @"parameter":@"querykey"},
                              @{@"condition":@"企业", @"parameter":@"91"},
                              @{@"condition":@"事业单位", @"parameter":@"12"},
                              @{@"condition":@"民政", @"parameter":@"5"},
                              @{@"condition":@"个体商户", @"parameter":@"92"},];
            self.tableView.rowsData = self.rowsData;
            [self.tableView reloadData];
            self.legalPersonFilterHeight = 44*5;
        }else if (self.searchType == 1)
        {
            if (self.rowsData.count <= 0)
            {
                [self queryFocusPeopleSelect:^(NSDictionary *result, NSError *error) {
                    if (error == nil)
                    {
                        [self showConditionTableView];
                    }
                }];
            }
            
        }
        
        [self showConditionTableView];
    }else
    {
        [self dismissConditionTableView];
    }
}

- (void)searchCategorySegmentDidClicking: (UISegmentedControl *)sender
{
    NSLog(@"点击了搜索种类");
    NSLog(@"%ld",(long)sender.selectedSegmentIndex);
    [self dismissConditionTableView];
    self.searchType = sender.selectedSegmentIndex;
    if (self.searchType == 0)
    {
        [self.searchField becomeFirstResponder];
        self.searchField.placeholder = @"请输入法人";
        self.searchURL = [WLNetworkTool sharedNetworkToolManager].queryAPIList[@"getCompanyList"];
    }else if (self.searchType == 1)
    {
        [self.searchField resignFirstResponder];
        [self queryFocusPeopleSelect:nil];
        self.searchField.placeholder = @"重点人群";
        self.searchURL = [WLNetworkTool sharedNetworkToolManager].queryAPIList[@"getFocusPeople"];
    }else if (self.searchType == 2)
    {
        [self.searchField becomeFirstResponder];
        self.searchField.placeholder = @"请输入姓名";
        self.searchURL = [WLNetworkTool sharedNetworkToolManager].queryAPIList[@"getPersonData"];
    }
    

}

- (NSArray *)constructCellContentDict: (NSDictionary *)dict
{
    NSArray *peoplename = dict[@"personlist"];
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    //    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
    for (int i = 0; i < peoplename.count; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:peoplename[i][@"peoplename"] forKey:@"condition"];
        [constructingDict setObject:peoplename[i][@"datapeoplequerycode"] forKey:@"parameter"];
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.searchResultRowsData[indexPath.row];
    WLLegalPeopleDetailController *vc = [[WLLegalPeopleDetailController alloc]init];
    vc.usercode = dict[@"usercode"];
    vc.creditcode = dict[@"creditcode"];
    [self.navigationController pushViewController:vc animated:YES];
    return;
    
    
    [self dismissConditionTableView];
    
    NSString *para = self.rowsData[indexPath.row][@"parameter"];
    if (self.searchType == 0)
    {
        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"querytype" withString:para];
    }else if (self.searchType == 1)
    {
        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"{typecode}" withString:para];
        if ([self.searchURL containsString:@"need_to_push"])
        {
            self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"need_to_push" withString:@""];
            [self dismissConditionTableView];
            [self querySearchData];
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.searchKey = textField.text;
    self.searchKey = @"立科科技";
    [self querySearchResultData];
    return YES;
}

//-(void)textFieldDidEndEditing:(UITextField *)textField 
//{
//    NSLog(@"开始搜索");
//    if (self.searchType == 0)
//    {
//        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"{querykey}" withString:textField.text];
//    }else if (self.searchType == 1)
//    {
//        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"{querykey}" withString:textField.text];
//        
//        NSString *searchString = textField.text;
//        if (searchString.length > 0)
//        {
//            if ([searchString integerValue])
//            {
//                self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"zczsbh" withString:searchString];
//            }else
//            {
//                self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"zgrxm" withString:searchString];
//            }
//            //如果没有选择类别, 弹窗强制选择
//            if ([self.searchURL containsString:@"{typecode}"])
//            {
//                self.searchURL = [self.searchURL stringByAppendingString:@"need_to_push"];
//                [self showConditionTableView];
//                return;
//            }
//        }
//    }else if (self.searchType == 2)
//    {
//        NSString *inputStr = [self.searchField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        NSArray *fields = [inputStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        
//        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"name" withString:fields.firstObject];
//        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"IDCardNo" withString:fields.lastObject];
//    }
//    
//    [self querySearchData];
//}

- (void)querySearchResultData
{
    [ProgressHUD show];
    [WLApiManager queryCompanyListtype:nil andName:self.searchKey page:1 success:^(id  _Nullable response) {
        [ProgressHUD dismiss];
        NSDictionary *result = (NSDictionary *)response;
        self.searchResultRowsData = [self constructLegalPeopleCellContentDict:result];
        if (self.searchResultRowsData.count > 0)
        {
            self.searchResulTableView.cellClass = [WLLegalPeopleSearchResultCell class];
            self.searchResulTableView.rowsData = self.searchResultRowsData;
            [self.searchResulTableView reloadData];
        }else
        {
            [self showEmptyView];
            
        }
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
        [self showEmptyView];
    }];
}

- (void)querySearchData
{
    WLNetworkTool *networkTool = [WLNetworkTool sharedNetworkToolManager];
//    self.searchURL = @"http://223.100.2.221:8383/credit-webservice-app/restwebservice/app/dataquery/getPersonData/%E7%A7%A6%E9%A2%96/21010217443210023";
    self.searchURL = [self.searchURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [networkTool GET_queryWithURL:self.searchURL andParameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        self.searchResultRowsData = [self constructLegalPeopleCellContentDict:result];
        self.searchResulTableView.cellClass = [WLLegalPeopleSearchResultCell class];
//        if (self.searchType == 0)
//        {
//        }else if (self.searchType == 1)
//        {
//            self.searchResultRowsData = [self constructFocusPeopleCellContentDict:result];
//            self.searchResulTableView.cellClass = [WLFocusPeopleResultCell class];
//        }else if (self.searchType == 2)
//        {
//            self.searchResultRowsData = [self constructPersonCellContentDict:result];
//            self.searchResulTableView.cellClass = [WLPersonResultCell class];
//        }
//        self.searchResultRowsData = [self constructCellContentDict:result];
//        self.searchResulTableView.cellClass = [WLLegalPeopleSearchResultCell class];
        self.searchResulTableView.rowsData = self.searchResultRowsData;
        [self.searchResulTableView reloadData];
        
        self.searchResulTableView.alpha = 1;
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (NSArray *)constructLegalPeopleCellContentDict: (NSDictionary *)dict
{
    NSArray *legalPeople = dict[@"dataList"];
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    for (NSDictionary *dict in legalPeople)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:[WLCommonTool getValue:dict Key:@"企业名称" default:@""] forKey:@"company"];
        [constructingDict setObject:[WLCommonTool getValue:dict Key:@"营业执照注册号" default:@""] forKey:@"usercode"];
        [constructingDict setObject:[WLCommonTool getValue:dict Key:@"信用标识码" default:@""] forKey:@"creditcode"];
        [constructingDict setObject:[WLCommonTool getValue:dict Key:@"法定代表人" default:@""] forKey:@"legalPeople"];
        [constructingDict setObject:[WLCommonTool getValue:dict Key:@"机构地址" default:@""] forKey:@"address"];

        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

- (NSArray *)constructFocusPeopleCellContentDict: (NSDictionary *)dict
{
    NSArray *focusPeople = dict[@"rows"];
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    //    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
    for (int i = 0; i < 10; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:focusPeople[0][@"zgrxm"] forKey:@"name"];
        [constructingDict setObject:focusPeople[0][@"zczsmc"] forKey:@"job"];
        [constructingDict setObject:focusPeople[0][@"zyzgdj"] forKey:@"grade"];
        [constructingDict setObject:focusPeople[0][@"gaid"] forKey:@"idCard"];
        [constructingDict setObject:focusPeople[0][@"zczsbh"] forKey:@"number"];
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

- (NSArray *)constructPersonCellContentDict: (NSDictionary *)dict
{
    NSArray *people = dict[@"rows"];
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    //    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
    for (int i = 0; i < 10; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:people[0][@"grxm"] forKey:@"name"];
        [constructingDict setObject:people[0][@"receivedate"] forKey:@"receiveTime"];
        [constructingDict setObject:people[0][@"sourcetablename"] forKey:@"tableName"];
        [constructingDict setObject:people[0][@"sfzjhm"] forKey:@"idCard"];
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

- (void)queryFocusPeopleSelect:(void (^)(NSDictionary *, NSError *))response
{
    WLNetworkTool *networkTool = [WLNetworkTool sharedNetworkToolManager];
    NSMutableString *URL = [NSMutableString stringWithString:networkTool.queryAPIList[@"getpersonselect"]];
    NSString *urlString = [NSString stringWithString:URL];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [networkTool GET_queryWithURL:urlString andParameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        self.rowsData = [self constructCellContentDict:result];
        self.tableView.rowsData = self.rowsData;
        [self.tableView reloadData];
        self.focusPeopleFilterHeight = self.tableView.rowsData.count * 44;
        if (response != nil)
        {
            response(result, nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        if (response != nil)
        {
            response(nil, error);
        }
        
    }];
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

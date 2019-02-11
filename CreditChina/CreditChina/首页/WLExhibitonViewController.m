//
//  WLExhibitonViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/30.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLExhibitonViewController.h"
#import "WLDoublePublicityViewController.h"
#import "WLRewardsAndPunishListViewController.h"
#import "WLRewardsAndPunishExampleViewController.h"
#import "WLCreditReportViewController.h"
#import "WLNewsViewController.h"
#import "WLCreditPromiseViewController.h"
#import "WLRelatedPolicyViewController.h"
#import "WLQueryCreditInfoViewController.h"
#import <SDCycleScrollView.h>
#import "WLSegmentTableViewController.h"
#import <WLPlatform.h>

@interface WLExhibitonViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSArray *functionBtns;
@property (nonatomic, weak) UIView *topView;

@end

@implementation WLExhibitonViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
    
}

- (void)decorateUI
{
    [self decorateTopView];
    
    UIView *functionView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height + 20, Screen_Width, Screen_Height * 0.25)];
    [self.view addSubview:functionView];

    for (int i = 0; i < self.functionBtns.count; i++)
    {
        UIButton *functionBtn = [[UIButton alloc]init];

        NSDictionary *dict = self.functionBtns[i];
        [functionBtn setTitle:dict[@"title"] forState:UIControlStateNormal];
        [functionBtn setImage:[UIImage imageNamed:dict[@"image"]] forState:UIControlStateNormal];
        functionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [functionBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

        functionBtn.tag = i;
        [functionBtn addTarget:self action:@selector(functionBtnDidClicking:) forControlEvents:UIControlEventTouchUpInside];
        int width = Screen_Width * 0.25;
        int height = functionView.frame.size.height * 0.5;
        int x = i % 4 == 0 ? 0 : Screen_Width * 0.25 * (i % 4);
        int y = i / 4 * height;
        functionBtn.frame = CGRectMake(x, y, width, height);

        functionBtn.titleEdgeInsets = UIEdgeInsetsMake(10, -functionBtn.imageView.frame.size.width, -functionBtn.imageView.frame.size.height, 0);
        functionBtn.imageEdgeInsets = UIEdgeInsetsMake(-functionBtn.titleLabel.intrinsicContentSize.height, 0, 0, -functionBtn.titleLabel.intrinsicContentSize.width);

        [functionView addSubview:functionBtn];

    }
    
        SDCycleScrollView *topView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, CGRectGetMaxY(functionView.frame) + 20, Screen_Width-20, Screen_Height * 0.25) delegate:self placeholderImage:[UIImage imageNamed:@"temp"]];
        NSArray *imagesURLStrings = @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];
        topView.imageURLStringsGroup = imagesURLStrings;
        [self.view addSubview:topView];

    
    
}

- (void)decorateTopView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height / 3)];
    self.topView = topView;
//    topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:topView];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:topView.bounds];
    backImage.image = [UIImage imageNamed:@"2"];
    [topView addSubview:backImage];
    UITextField *searchField = [[UITextField alloc]init];
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

    int width = topView.frame.size.width - 30;
    int height = 40;
    int x = topView.frame.size.width * 0.5 - width * 0.5;
    int y = topView.frame.size.height * 0.5 + height + 10;
    searchField.frame = CGRectMake( x, y, width, height);
    [topView addSubview:searchField];
    
    
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"信用辽宁";
    title.font = [UIFont fontWithName:@"kaiti_GB2312" size:45];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    int titleWidth = topView.frame.size.width - 150;
    int titleHeight = 40;
    int titleX = topView.frame.size.width * 0.5 - titleWidth * 0.5;
    int titleY = topView.frame.size.height * 0.5 - 60;
    title.frame = CGRectMake(titleX, titleY, titleWidth, titleHeight);
    [topView addSubview:title];
    
    NSArray *categoryTitles = @[@"法人信用查询",@"个人身份核实",@"重点人群信用查询"];
    UISegmentedControl *searchCategory = [[UISegmentedControl alloc]initWithItems:categoryTitles];
    searchCategory.tintColor = [UIColor whiteColor];
    searchCategory.frame = CGRectMake(x, y-35, width, 30);
    searchCategory.selectedSegmentIndex = 0;
    [searchCategory addTarget:self action:@selector(searchCategorySegmentDidClicking:) forControlEvents:UIControlEventValueChanged];
    [topView addSubview:searchCategory];
    
}

- (void)searchCategorySegmentDidClicking: (UISegmentedControl *)sender
{
    NSLog(@"点击了搜索种类");
    NSLog(@"%ld",(long)sender.selectedSegmentIndex);
}

- (void)functionBtnDidClicking: (UIButton *)sender
{
    NSLog(@"点击了功能按钮%ld", (long)sender.tag);
    switch (sender.tag)
    {
        case 0:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.titles = @[@"行政许可",@"行政处罚"];
            WLDoublePublicityViewController *vc1 = [[WLDoublePublicityViewController alloc]init];
            vc1.doublePubliciryType = @"2";
            WLDoublePublicityViewController *vc2 = [[WLDoublePublicityViewController alloc]init];
            vc2.doublePubliciryType = @"1";
            segVC.controllers = @[vc1,vc2];
            segVC.title = @"双公示展示";
            [self.navigationController pushViewController:segVC animated:YES];
            break;
        }
        case 1:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.titles = @[@"红名单",@"黑名单"];
            WLRewardsAndPunishListViewController *vc1 = [[WLRewardsAndPunishListViewController alloc]init];
            WLRewardsAndPunishListViewController *vc2 = [[WLRewardsAndPunishListViewController alloc]init];
            segVC.controllers = @[vc1,vc2];
            segVC.title = @"联合奖惩(红黑名单)";
            [self.navigationController pushViewController:segVC animated:YES];
            break;
        }
        case 2:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.titles = @[@"守信激励案例",@"失信惩戒案例"];
            WLRewardsAndPunishExampleViewController *vc1 = [[WLRewardsAndPunishExampleViewController alloc]init];
            vc1.keepOrBreakPromise = @"1";
            WLRewardsAndPunishExampleViewController *vc2 = [[WLRewardsAndPunishExampleViewController alloc]init];
            vc2.keepOrBreakPromise = @"2";
            segVC.controllers = @[vc1,vc2];
            segVC.title = @"联合奖惩案例";
            [self.navigationController pushViewController:segVC animated:YES];
            break;
        }
        case 3:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.titles = @[@"信用报告公示",@"信用报告制度"];
            WLCreditReportViewController *vc1 = [[WLCreditReportViewController alloc]init];
            vc1.publicityOrSystem = @"1";
            WLCreditReportViewController *vc2 = [[WLCreditReportViewController alloc]init];
            vc2.publicityOrSystem = @"2";
            segVC.controllers = @[vc1,vc2];
            segVC.title = @"信用报告";
            [self.navigationController pushViewController:segVC animated:YES];
            break;
        }
        case 4:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.titles = @[@"省内动态",@"国内动态"];
            WLNewsViewController *vc1 = [[WLNewsViewController alloc]init];
            WLNewsViewController *vc2 = [[WLNewsViewController alloc]init];
            WLNewsViewController *vc3 = [[WLNewsViewController alloc]init];
            WLNewsViewController *vc4 = [[WLNewsViewController alloc]init];
            segVC.controllers = @[vc1,vc2, vc3, vc4];
            [self.navigationController pushViewController:segVC animated:YES];
            break;
        }
        case 5:
        {
            WLCreditPromiseViewController *vc = [[WLCreditPromiseViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.titles = @[@"国家政策",@"省内政策",@"市级政策"];
            WLRelatedPolicyViewController *vc1 = [[WLRelatedPolicyViewController alloc]init];
            vc1.policyType = @"1";
            WLRelatedPolicyViewController *vc2 = [[WLRelatedPolicyViewController alloc]init];
            vc2.policyType = @"2";
            WLRelatedPolicyViewController *vc3 = [[WLRelatedPolicyViewController alloc]init];
            vc3.policyType = @"3";
            segVC.controllers = @[vc1,vc2, vc3];
            [self.navigationController pushViewController:segVC animated:YES];
            
            break;
        }
        case 7:
        {
            WLQueryCreditInfoViewController *vc = [[WLQueryCreditInfoViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
    
}

-(NSArray *)functionBtns
{
    if (_functionBtns == nil)
    {
        NSMutableArray *arrTem = [NSMutableArray arrayWithCapacity:8];
        [arrTem addObject:@{@"image":@"doublePublicity", @"title":@"双公示"}];
        [arrTem addObject:@{@"image":@"RewardsAndPunish", @"title":@"红黑名单"}];
        [arrTem addObject:@{@"image":@"RewardsAndPunish1", @"title":@"典型案例"}];
        [arrTem addObject:@{@"image":@"creditReport", @"title":@"信用报告"}];
        [arrTem addObject:@{@"image":@"newsIcon", @"title":@"新闻资讯"}];
        [arrTem addObject:@{@"image":@"creditPromise", @"title":@"信用承诺"}];
        [arrTem addObject:@{@"image":@"relatedPolicy", @"title":@"相关政策"}];
        [arrTem addObject:@{@"image":@"queryInfo", @"title":@"信用信息查询"}];
        _functionBtns = [NSArray arrayWithArray:arrTem];
    }
    return _functionBtns;
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

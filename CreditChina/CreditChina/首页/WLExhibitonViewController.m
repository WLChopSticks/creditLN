//
//  WLExhibitonViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/30.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLExhibitonViewController.h"
#import "WLNewsViewController.h"
#import "WLRelatedPolicyViewController.h"
#import "WLQueryCreditInfoViewController.h"
#import "WLSegmentTableViewController.h"
#import <WLPlatform.h>
#import <WLTableView.h>
#import <CTMediator+Publicity.h>
#import <CTMediator+News.h>
#import "WLExhibitionMessageCell.h"
#import "WLNewsAndPolicyShowInExhibitionController.h"
#import "WLFocusPeopleController.h"
#import "WLCreditInfoController.h"
#import "WLBaseNavigationViewController.h"

@interface WLExhibitonViewController ()<wlTableViewDelegate, UITextFieldDelegate>

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
    UIScrollView *backScroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:backScroll];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor colorWithRed:236.0/250 green:236.0/250 blue:236.0/250 alpha:1];
    [backScroll addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(backScroll);
                make.top.equalTo(backScroll.mas_top).offset(-20);
                make.left.equalTo(backScroll.mas_left);
                make.right.equalTo(backScroll.mas_right);
                make.bottom.equalTo(backScroll.mas_bottom);
        make.width.equalTo(backScroll);
    }];
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(Screen_Height * 0.25);
    }];
    
    UIView *functionBtnView = [[UIView alloc]init];
    functionBtnView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:functionBtnView];
    [functionBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.equalTo(backScroll);
        make.height.mas_equalTo(Screen_Height * 0.25);
    }];
    
    UIView *creditMessageView = [[UIView alloc]init];
    creditMessageView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:creditMessageView];
    [creditMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(functionBtnView.mas_bottom).offset(10);
        make.left.right.equalTo(backScroll);
        make.height.mas_equalTo(150);
    }];
    
    UIView *newsView = [[UIView alloc]init];
    newsView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:newsView];
    [newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(creditMessageView.mas_bottom).offset(10);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(Screen_Height * 0.45);
    }];
    
    UIView *policyView = [[UIView alloc]init];
    policyView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:policyView];
    [policyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newsView.mas_bottom).offset(10);
        make.left.right.equalTo(backScroll);
        make.height.mas_equalTo(230);
        make.bottom.equalTo(backScroll);
    }];
    
    [self decorateTopView:topView];
    [self decorateFunctionButtonsView:functionBtnView];
    [self decorateCreditMessageView:creditMessageView];
    [self decorateNewsInfoView:newsView];
    [self decoratePolicyInfoView:policyView];
}

- (void)decorateTopView: (UIView *)containerView
{
    UIImageView *backImage = [[UIImageView alloc]init];
    backImage.image = [UIImage imageNamed:@"2"];
    [containerView addSubview:backImage];
    
    UIImageView *logo1 = [[UIImageView alloc]init];
    logo1.image = [UIImage imageNamed:@"logo2"];
    logo1.contentMode = UIViewContentModeScaleAspectFit;
    [containerView addSubview:logo1];
    UIImageView *logo2 = [[UIImageView alloc]init];
    logo2.contentMode = UIViewContentModeScaleAspectFit;
    logo2.image = [UIImage imageNamed:@"logo1"];
    [containerView addSubview:logo2];
    [logo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containerView.mas_centerX).offset(-0);
        make.top.equalTo(containerView.mas_top).offset(20);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    [logo1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(logo2.mas_left);
        make.centerY.equalTo(logo2.mas_centerY);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(22);
    }];
    
    UIButton *copyRightBtn = [[UIButton alloc]init];
    [copyRightBtn setImage:[UIImage imageNamed:@"!"] forState:UIControlStateNormal];
    [copyRightBtn addTarget:self action:@selector(copyRightBtnDidClicking:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:copyRightBtn];
    
    [copyRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containerView.mas_left).offset(20);
        make.centerY.equalTo(logo2.mas_centerY);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(22);
    }];
    
    UIButton *profileBtn = [[UIButton alloc]init];
    [profileBtn setImage:[UIImage imageNamed:@"profile"] forState:UIControlStateNormal];
    [profileBtn addTarget:self action:@selector(profileBtnDidClicking:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:profileBtn];
    
    [profileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView.mas_right).offset(-20);
        make.centerY.equalTo(logo2.mas_centerY);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(22);
    }];
    
    UITextField *searchField = [[UITextField alloc]init];
    searchField.borderStyle = UITextBorderStyleRoundedRect;
    NSString *holderText = @"请输入企业名,人名,品牌等关键字";
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
    searchField.delegate = self;
    [containerView addSubview:searchField];
    
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(containerView);
        make.bottom.equalTo(containerView.mas_bottom).offset(-20);
    }];
    
    [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containerView.mas_left).offset(25);
        make.right.equalTo(containerView.mas_right).offset(-25);
        make.bottom.equalTo(containerView);
        make.height.mas_equalTo(40);
    }];
    
    
    
    
    
}


- (void)decorateFunctionButtonsView: (UIView *)containerView
{
    UIView *functionView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height + 20, Screen_Width, Screen_Height * 0.25)];
    
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
        
        [containerView addSubview:functionBtn];
        
    }
}

- (void)decorateCreditMessageView: (UIView *)containerView
{
    UIImageView *leftimage = [[UIImageView alloc]init];
    leftimage.contentMode = UIViewContentModeScaleAspectFit;
    leftimage.image = [UIImage imageNamed:@"star"];
    [containerView addSubview:leftimage];
    UILabel *viewTitle = [[UILabel alloc]init];
    viewTitle.text = @"信用信息";
    [containerView addSubview:viewTitle];
    UILabel *messageCount = [[UILabel alloc]init];
    messageCount.font = [UIFont systemFontOfSize:13];
    messageCount.textAlignment = NSTextAlignmentCenter;
    messageCount.text = @"今天收到3条消息";
    [containerView addSubview:messageCount];
    UIButton *moreBtn = [[UIButton alloc]init];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(creditMoreBtnDidClicking:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:moreBtn];
    
    WLTableView *messageTable = [[WLTableView alloc]init];
    messageTable.delegate = self;
    [containerView addSubview:messageTable];
    messageTable.cellClass = [WLExhibitionMessageCell class];
    messageTable.wltableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [messageTable registNibForCell:@"WLExhibitionMessageCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
    messageTable.rowsData = @[@{@"title":@"您有1条预警消息, 关于被人民法院定位失信被执行人的信息",@"showDetailBtn":@"1"},@{@"title":@"您提交的异议申诉已经进入处理流程, 请耐心等待处理结果",@"showDetailBtn":@"1"}];
    
    [leftimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.left.equalTo(containerView);
        make.width.height.mas_equalTo(30);
    }];
    
    [viewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftimage.mas_centerY);
        make.left.equalTo(leftimage.mas_right).offset(5);
    }];
    
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView.mas_right);
        make.top.equalTo(containerView.mas_top);
        make.width.height.mas_equalTo(30);
    }];
    
    [messageCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftimage.mas_bottom).offset(5);
        make.left.right.equalTo(containerView);
    }];
    
    [messageTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(containerView);
        make.top.equalTo(messageCount.mas_bottom).offset(10);
        make.bottom.equalTo(containerView.mas_bottom);
    }];
    
}

- (void)decorateNewsInfoView: (UIView *)containerView
{
    UIImageView *leftimage = [[UIImageView alloc]init];
    leftimage.contentMode = UIViewContentModeScaleAspectFit;
    leftimage.image = [UIImage imageNamed:@"star"];
    [containerView addSubview:leftimage];
    UILabel *viewTitle = [[UILabel alloc]init];
    viewTitle.text = @"信用动态";
    [containerView addSubview:viewTitle];
    UIButton *moreBtn = [[UIButton alloc]init];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(newsMoreBtnDidClicking:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:moreBtn];
    
    WLSegmentTableViewController *categoryTable = [[WLSegmentTableViewController alloc]init];
    categoryTable.categoryType = @"1";
    categoryTable.titles = @[@"国内动态",@"省内动态"];
    categoryTable.isTitlesEqualWidth = YES;
    WLNewsAndPolicyShowInExhibitionController *vc10 = [[WLNewsAndPolicyShowInExhibitionController alloc]init];
    vc10.showType = @"1";
    vc10.newsType = @"799";
    WLNewsAndPolicyShowInExhibitionController *vc20 = [[WLNewsAndPolicyShowInExhibitionController alloc]init];
    vc20.showType = @"1";
    vc20.newsType = @"798";
//    WLNewsAndPolicyShowInExhibitionController *vc30 = [[WLNewsAndPolicyShowInExhibitionController alloc]init];
//    vc30.showType = @"1";
//    WLNewsAndPolicyShowInExhibitionController *vc40 = [[WLNewsAndPolicyShowInExhibitionController alloc]init];
//    vc40.showType = @"1";
    categoryTable.controllers = @[vc10,vc20];
    categoryTable.categoryWidth = 150;

    [containerView addSubview:categoryTable.view];
    [self addChildViewController:categoryTable];
    
    [leftimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.left.equalTo(containerView);
        make.width.height.mas_equalTo(30);
    }];
    
    [viewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftimage.mas_centerY);
        make.left.equalTo(leftimage.mas_right).offset(5);
    }];
    
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView.mas_right);
        make.top.equalTo(containerView.mas_top);
        make.width.height.mas_equalTo(30);
    }];
    
    [categoryTable.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftimage.mas_bottom).offset(10);
        make.left.right.equalTo(containerView);
        make.bottom.equalTo(containerView.mas_bottom);
    }];
}

- (void)decoratePolicyInfoView: (UIView *)containerView
{
    UIImageView *leftimage = [[UIImageView alloc]init];
    leftimage.contentMode = UIViewContentModeScaleAspectFit;
    leftimage.image = [UIImage imageNamed:@"star"];
    [containerView addSubview:leftimage];
    UILabel *viewTitle = [[UILabel alloc]init];
    viewTitle.text = @"政策法规";
    [containerView addSubview:viewTitle];
    UIButton *moreBtn = [[UIButton alloc]init];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(policyMoreBtnDidClicking:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:moreBtn];

    WLSegmentTableViewController *categoryTable = [[WLSegmentTableViewController alloc]init];
    categoryTable.titles = @[@"国家政策",@"省内政策",@"市级政策"];
    categoryTable.categoryType = @"1";
    categoryTable.isTitlesEqualWidth = YES;
    WLNewsAndPolicyShowInExhibitionController *vc10 = [[WLNewsAndPolicyShowInExhibitionController alloc]init];
    vc10.showType = @"2";
    vc10.policyType = @"800";
    WLNewsAndPolicyShowInExhibitionController *vc20 = [[WLNewsAndPolicyShowInExhibitionController alloc]init];
    vc20.showType = @"2";
    vc20.policyType = @"801";
    WLNewsAndPolicyShowInExhibitionController *vc30 = [[WLNewsAndPolicyShowInExhibitionController alloc]init];
    vc30.showType = @"2";
    vc30.policyType = @"802";
    categoryTable.controllers = @[vc10,vc20,vc30];
    categoryTable.categoryWidth = 200;
    
    [containerView addSubview:categoryTable.view];
    [self addChildViewController:categoryTable];
    
    
    [leftimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.left.equalTo(containerView);
        make.width.height.mas_equalTo(30);
    }];
    
    [viewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftimage.mas_centerY);
        make.left.equalTo(leftimage.mas_right).offset(5);
    }];
    
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView.mas_right);
        make.top.equalTo(containerView.mas_top);
        make.width.height.mas_equalTo(30);
    }];
    
    [categoryTable.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftimage.mas_bottom).offset(10);
        make.left.right.equalTo(containerView);
        make.bottom.equalTo(containerView.mas_bottom);
    }];
    
    
    
}

- (void)creditMoreBtnDidClicking: (UIButton *)sender
{
    WLCreditInfoController *vc = [[WLCreditInfoController alloc]init];
    vc.title = @"信用信息";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)newsMoreBtnDidClicking: (UIButton *)sender
{
    WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
    segVC.title = @"信用动态";
    segVC.titles = @[@"国内动态",@"省内动态"];
    segVC.isTitlesEqualWidth = YES;
    UIViewController *vc1 = [[CTMediator sharedInstance]News_aViewController:@"799"];
    UIViewController *vc2 = [[CTMediator sharedInstance]News_aViewController:@"798"];
    segVC.controllers = @[vc1,vc2];
    [self.navigationController pushViewController:segVC animated:YES];
}

- (void)functionBtnDidClicking: (UIButton *)sender
{
    NSLog(@"点击了功能按钮%ld", (long)sender.tag);
    switch (sender.tag)
    {
            
        case 0:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.isTitlesEqualWidth = YES;
            segVC.titles = @[@"行政许可",@"行政处罚"];
            segVC.showHeadSearchBar = YES;
            segVC.searchField.placeholder = @"请输入要搜索的法人名称";
            UIViewController *vc1 = [[CTMediator sharedInstance]DoublePublicity_aViewController:@"2"];
            UIViewController *vc2 = [[CTMediator sharedInstance]DoublePublicity_aViewController:@"1"];
            segVC.controllers = @[vc1,vc2];
            segVC.title = @"双公示展示";
            [self.navigationController pushViewController:segVC animated:YES];
            break;
        }
        case 1:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.titles = @[@"红名单",@"黑名单"];
            segVC.isTitlesEqualWidth = YES;
            UIViewController *vc1 = [[CTMediator sharedInstance]RewardsAndPunishList_aViewController:@"1"];
            UIViewController *vc2 = [[CTMediator sharedInstance]RewardsAndPunishList_aViewController:@"2"];
            segVC.controllers = @[vc1,vc2];
            segVC.title = @"联合奖惩(红黑名单)";
            [self.navigationController pushViewController:segVC animated:YES];
            break;
        }
        case 2:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.titles = @[@"信用报告公示",@"信用报告制度"];
            UIViewController *vc1 = [[CTMediator sharedInstance]CreditReport_aViewController:@"1"];
            UIViewController *vc2 = [[CTMediator sharedInstance]CreditReport_aViewController:@"2"];
            segVC.controllers = @[vc1,vc2];
            segVC.title = @"信用报告";
            [self.navigationController pushViewController:segVC animated:YES];
            break;
        }
        case 3:
        {
            WLFocusPeopleController *vc = [[WLFocusPeopleController alloc]init];
            vc.title = @"重点人群";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.titles = @[@"守信激励案例",@"失信惩戒案例"];
            segVC.isTitlesEqualWidth = YES;
            UIViewController *vc1 = [[CTMediator sharedInstance]RewardsAndPunishExampleController:@"1"];
            UIViewController *vc2 = [[CTMediator sharedInstance]RewardsAndPunishExampleController:@"2"];
            segVC.controllers = @[vc1,vc2];
            segVC.title = @"联合奖惩案例";
            [self.navigationController pushViewController:segVC animated:YES];
            break;
        }
        case 5:
        {
            UIViewController *vc = [[CTMediator sharedInstance]CreditPromise_aViewController];
            [self.navigationController pushViewController:vc animated:YES];
            
            break;
        }
        case 6:
        {
            WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
            segVC.titles = @[@"国家政策",@"省内政策",@"市级政策"];
            segVC.title = @"政策法规";
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
//    WLQueryCreditInfoViewController *vc = [[WLQueryCreditInfoViewController alloc]init];
    UIViewController *vc = [[CTMediator sharedInstance]QueryCreditInfo_aViewController];
    WLBaseNavigationViewController *nav = [[WLBaseNavigationViewController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:nil];
    return NO;
}

- (void)policyMoreBtnDidClicking: (UIButton *)sender
{
    WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
    segVC.titles = @[@"国家政策",@"省内政策",@"市级政策"];
    segVC.title = @"政策法规";
    WLRelatedPolicyViewController *vc1 = [[WLRelatedPolicyViewController alloc]init];
    vc1.policyType = @"800";
    WLRelatedPolicyViewController *vc2 = [[WLRelatedPolicyViewController alloc]init];
    vc2.policyType = @"801";
    WLRelatedPolicyViewController *vc3 = [[WLRelatedPolicyViewController alloc]init];
    vc3.policyType = @"802";
    segVC.controllers = @[vc1,vc2, vc3];
    segVC.isTitlesEqualWidth = YES;
    [self.navigationController pushViewController:segVC animated:YES];
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"@d");
}

- (void)copyRightBtnDidClicking: (UIButton *)sender
{
    NSLog(@"1");
}

- (void)profileBtnDidClicking: (UIButton *)sender
{
    NSLog(@"1");
    [self.tabBarController setSelectedIndex:3];
}

-(NSArray *)functionBtns
{
    if (_functionBtns == nil)
    {
        NSMutableArray *arrTem = [NSMutableArray arrayWithCapacity:8];
        [arrTem addObject:@{@"image":@"doublePublicity", @"title":@"双公示"}];
        [arrTem addObject:@{@"image":@"lhjc", @"title":@"联合奖惩"}];
        [arrTem addObject:@{@"image":@"xybg", @"title":@"信用报告公示"}];
        [arrTem addObject:@{@"image":@"zdrq", @"title":@"重点人群"}];
        [arrTem addObject:@{@"image":@"dxal", @"title":@"典型案例"}];
        [arrTem addObject:@{@"image":@"xycn", @"title":@"信用承诺"}];
        [arrTem addObject:@{@"image":@"yyss", @"title":@"异议申诉"}];
        [arrTem addObject:@{@"image":@"xyxf", @"title":@"信用修复"}];
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

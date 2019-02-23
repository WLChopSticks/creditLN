//
//  WLProfileCreditViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/30.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLProfileCreditViewController.h"
#import <WLPlatform.h>
#import "WLPofileCreditGradeView.h"
#import <WLTableView.h>
#import "WLProfileCreditGradeBenifitCell.h"


@interface WLProfileCreditViewController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLPofileCreditGradeView *socialManagement;
@property (nonatomic, weak) WLPofileCreditGradeView *businessRegion;
@property (nonatomic, weak) WLPofileCreditGradeView *judicature;
@property (nonatomic, weak) WLPofileCreditGradeView *governmentRegion;
@property (nonatomic, weak) WLPofileCreditGradeView *addition;

@property (nonatomic, strong) NSArray *benefitArray;

@end

@implementation WLProfileCreditViewController

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
    topView.backgroundColor = [UIColor redColor];
    [bgView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(Screen_Height * 0.5);
    }];
    
    UIView *messageView = [[UIView alloc]init];
    messageView.backgroundColor = [UIColor greenColor];
    [bgView addSubview:messageView];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.right.equalTo(backScroll);
        make.height.mas_equalTo(300);
    }];
    
    UIView *functionBtnView = [[UIView alloc]init];
    functionBtnView.backgroundColor = [UIColor blueColor];
    [bgView addSubview:functionBtnView];
    [functionBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(messageView.mas_bottom).offset(10);
        make.left.right.equalTo(backScroll);
        make.height.mas_equalTo(300);
        make.bottom.equalTo(bgView.mas_bottom);
    }];
    
    [self decorateTopView:topView];
    [self decorateMiddleMessageView:messageView];
    
}

- (void)decorateTopView: (UIView *)containerView
{
    UIImageView *backView = [[UIImageView alloc]init];
    [containerView addSubview:backView];
    backView.backgroundColor = [UIColor greenColor];
    
    UIView *gradeView = [[UIView alloc]init];
    [containerView addSubview:gradeView];
    gradeView.backgroundColor = [UIColor yellowColor];
    
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(containerView);
        make.bottom.equalTo(containerView).offset(-20);
    }];
    [gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containerView.mas_left).offset(20);
        make.right.equalTo(containerView.mas_right).offset(-20);
        make.bottom.equalTo(containerView);
        make.height.mas_equalTo(80);
    }];
    
    CGFloat littleViewWidth = (Screen_Width - 40 - 40) / 5;
    WLPofileCreditGradeView *socialManagement = [[WLPofileCreditGradeView alloc]init];
    self.socialManagement = socialManagement;
    [gradeView addSubview:socialManagement];
    socialManagement.gradeLabel.text = @"-10";
    socialManagement.regionLabel.text = @"社会管理";
    
    [socialManagement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(gradeView);
        make.left.equalTo(gradeView.mas_left).offset(20);
        make.width.mas_equalTo(littleViewWidth);
    }];
    
    UIView *border1 = [[UIView alloc]init];
    border1.backgroundColor = [UIColor lightGrayColor];
    [gradeView addSubview:border1];
    [border1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(socialManagement.mas_right);
        make.top.bottom.equalTo(gradeView);;
        make.width.mas_equalTo(0.5);
    }];
    
    WLPofileCreditGradeView *businessRegion = [[WLPofileCreditGradeView alloc]init];
    self.businessRegion = businessRegion;
    [gradeView addSubview:businessRegion];
    businessRegion.gradeLabel.text = @"-10";
    businessRegion.regionLabel.text = @"商务领域";
    
    [businessRegion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(gradeView);
        make.left.equalTo(border1.mas_right);
        make.width.mas_equalTo(littleViewWidth);
    }];
    
    UIView *border2 = [[UIView alloc]init];
    border2.backgroundColor = [UIColor lightGrayColor];
    [gradeView addSubview:border2];
    [border2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(businessRegion.mas_right);
        make.top.bottom.equalTo(gradeView);;
        make.width.mas_equalTo(0.5);
    }];
    WLPofileCreditGradeView *judicature = [[WLPofileCreditGradeView alloc]init];
    self.judicature = judicature;
    [gradeView addSubview:judicature];
    judicature.gradeLabel.text = @"-10";
    judicature.regionLabel.text = @"司法领域";
    
    [judicature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(gradeView);
        make.left.equalTo(border2.mas_right);
        make.width.mas_equalTo(littleViewWidth);
    }];
    
    UIView *border3 = [[UIView alloc]init];
    border3.backgroundColor = [UIColor lightGrayColor];
    [gradeView addSubview:border3];
    [border3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(judicature.mas_right);
        make.top.bottom.equalTo(gradeView);;
        make.width.mas_equalTo(0.5);
    }];
    
    WLPofileCreditGradeView *governmentRegion = [[WLPofileCreditGradeView alloc]init];
    self.governmentRegion = governmentRegion;
    [gradeView addSubview:governmentRegion];
    governmentRegion.gradeLabel.text = @"-10";
    governmentRegion.regionLabel.text = @"政务领域";
    
    [governmentRegion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(gradeView);
        make.left.equalTo(border3.mas_right);
        make.width.mas_equalTo(littleViewWidth);
    }];
    
    UIView *border4 = [[UIView alloc]init];
    border4.backgroundColor = [UIColor lightGrayColor];
    [gradeView addSubview:border4];
    [border4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(governmentRegion.mas_right);
        make.top.bottom.equalTo(gradeView);;
        make.width.mas_equalTo(0.5);
    }];
    
    WLPofileCreditGradeView *addition = [[WLPofileCreditGradeView alloc]init];
    self.addition = addition;
    [gradeView addSubview:addition];
    addition.gradeLabel.text = @"-10";
    addition.regionLabel.text = @"加分项";
    
    [addition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(gradeView);
        make.left.equalTo(border4.mas_right);
        make.width.mas_equalTo(littleViewWidth);
    }];
    
}

- (void)decorateMiddleMessageView: (UIView *)container
{
    [WLCommonTool makeViewShowingWithRoundCorner:container andRadius:10];

    UIImageView *topLeftImage = [[UIImageView alloc]init];
    topLeftImage.backgroundColor = [UIColor redColor];
    [container addSubview:topLeftImage];
    
    UIImageView *topRightImage = [[UIImageView alloc]init];
    topRightImage.backgroundColor = [UIColor redColor];
    [container addSubview:topRightImage];
    
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = @"信用为我带来的优惠";
    [container addSubview:topLabel];
    
    
    WLTableView *benefitTable = [[WLTableView alloc]init];
    benefitTable.delegate = self;
    benefitTable.wltableView.userInteractionEnabled = NO;
    [container addSubview:benefitTable];
    benefitTable.cellClass = [WLProfileCreditGradeBenifitCell class];
    benefitTable.rowsData = self.benefitArray;
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(container.mas_centerX);
        make.top.equalTo(container.mas_top).offset(20);
    }];
    
    [topLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topLabel.mas_left).offset(-5);
        make.centerY.equalTo(topLabel.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
    
    [topRightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topLabel.mas_right).offset(5);
        make.centerY.equalTo(topLabel.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
    
    [benefitTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(10);
        make.left.equalTo(container.mas_left).offset(20);
        make.right.equalTo(container.mas_right).offset(-20);
        make.bottom.equalTo(container.mas_bottom).offset(-10);
    }];
    
}

-(NSArray *)benefitArray
{
    if (!_benefitArray)
    {
        _benefitArray = [NSArray arrayWithObjects:
  @{@"image":@"",@"title":@"免去没必要花的钱",@"contents":@[@"图书借阅免押金"]},
  @{@"image":@"",@"title":@"信用带来的折扣",@"contents":@[@"·公交出行奋勇刷卡打9折",@"·移动,联通,电信充100元话费只需支付95元",@"·公园景区,电影购票,健身娱乐购票打9.5折"]},
  @{@"image":@"",@"title":@"信用带来的绿色通道",@"contents":@[@"·公积金办理可在绿色通道办理",@"·行政审批可在绿色通道办理"]}, nil];
    }
    
    return _benefitArray;
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

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
#import <WLCircleAnimationView.h>
#import "WLKnowCreditGradeViewController.h"
#import "WLPersonalCreditModel.h"


#define FunctionBtnViewHeight 300

@interface WLProfileCreditViewController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLPofileCreditGradeView *socialManagement;
@property (nonatomic, weak) WLPofileCreditGradeView *businessRegion;
@property (nonatomic, weak) WLPofileCreditGradeView *judicature;
@property (nonatomic, weak) WLPofileCreditGradeView *governmentRegion;
@property (nonatomic, weak) WLPofileCreditGradeView *addition;

@property (nonatomic, strong) NSArray *benefitArray;
@property (nonatomic, strong) NSArray *functionBtns;

@property (nonatomic, weak) WLCircleAnimationView *animationView;

@property (nonatomic, strong) WLPersonalCreditModel *model;

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
    [self queryPersonalCreditData];
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
    functionBtnView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:functionBtnView];
    [functionBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(messageView.mas_bottom).offset(10);
        make.left.right.equalTo(backScroll);
        make.height.mas_equalTo(FunctionBtnViewHeight);
        make.bottom.equalTo(bgView.mas_bottom);
    }];
    
    [self decorateTopView:topView];
    [self decorateMiddleMessageView:messageView];
    [self decorateFunctionButtonsView:functionBtnView];
    
}

- (void)decorateTopView: (UIView *)containerView
{
    UIImageView *backView = [[UIImageView alloc]init];
    [containerView addSubview:backView];
    backView.backgroundColor = [UIColor greenColor];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(containerView);
        make.bottom.equalTo(containerView).offset(-20);
    }];
    
    UIButton *knowCreditGrade = [[UIButton alloc]init];
    [containerView addSubview:knowCreditGrade];
    [knowCreditGrade setTitle:@"了解信用分" forState:UIControlStateNormal];
    [knowCreditGrade setBackgroundColor:[UIColor whiteColor]];
    knowCreditGrade.titleLabel.font = [UIFont systemFontOfSize:13];
    [knowCreditGrade setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [WLCommonTool makeViewShowingWithRoundCorner:knowCreditGrade andRadius:10];
    [knowCreditGrade addTarget:self action:@selector(knowCreditGradeBtnDidClicking:) forControlEvents:UIControlEventTouchUpInside];
    
    [knowCreditGrade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView.mas_top).offset(20);
        make.right.equalTo(containerView.mas_right).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(90);
    }];
    
    
    UIView *circleContainer = [[UIView alloc]init];
    [containerView addSubview:circleContainer];
    
    [circleContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(containerView.mas_centerY).offset(0);
        make.centerX.equalTo(containerView.mas_centerX);
        make.width.height.mas_equalTo(Screen_Width * 0.5);
    }];
    
    CGFloat width = Screen_Width * 0.5;
    CGFloat height = width;
    WLCircleAnimationView *animateView = [[WLCircleAnimationView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    animateView.backgroundColor = [UIColor purpleColor];
    animateView.backGroundView = backView;
    [circleContainer addSubview:animateView];
    self.animationView = animateView;
    
    UIView *gradeView = [[UIView alloc]init];
    [containerView addSubview:gradeView];
    gradeView.backgroundColor = [UIColor yellowColor];
    
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

- (void)decorateFunctionButtonsView: (UIView *)containerView
{
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
        int height = FunctionBtnViewHeight / 3;
        int x = i % 4 == 0 ? 0 : Screen_Width * 0.25 * (i % 4);
        int y = i / 4 * height;
        
        if (i >= 8)
        {
            width = Screen_Width * 0.5 - 1;
            x = i % 2  == 0 ? 0 : width * (i % 2);
        }
        
        functionBtn.frame = CGRectMake(x, y, width, height);
        
        functionBtn.titleEdgeInsets = UIEdgeInsetsMake(10, -functionBtn.imageView.width, -functionBtn.imageView.height, 0);
        functionBtn.imageEdgeInsets = UIEdgeInsetsMake(-functionBtn.titleLabel.intrinsicContentSize.height, 0, 0, -functionBtn.titleLabel.intrinsicContentSize.width);
        
        [containerView addSubview:functionBtn];
        
        UIView *bottomBorder = [[UIView alloc]initWithFrame:CGRectMake(0, functionBtn.height, functionBtn.width, 0.5)];
        bottomBorder.backgroundColor = [UIColor lightGrayColor];
        [functionBtn addSubview:bottomBorder];
        
        UIView *rightBorder = [[UIView alloc]initWithFrame:CGRectMake(functionBtn.frame.size.width, 0, 0.5, functionBtn.frame.size.height)];
        rightBorder.backgroundColor = [UIColor lightGrayColor];
        [functionBtn addSubview:rightBorder];
    }
}

- (void)queryPersonalCreditData
{
    [ProgressHUD show];
    [WLApiManager queryMonthReportData:nil failure:nil];
    
    return;
    
    
    [WLApiManager queryPersonalCreditDataWithName:@"陈杰" andIDCard:@"210105196306150639" success:^(id  _Nullable response) {
        [ProgressHUD dismiss];
        NSDictionary *result = (NSDictionary *)response;
        WLPersonalCreditModel *model = [WLPersonalCreditModel getModel:result];
        self.model = model;
        [self fillPageData];
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
        [self showEmptyView];
    }];
}

- (void)fillPageData
{
    self.animationView.score = self.model.person.surplus.integerValue;
}

- (void)functionBtnDidClicking: (UIButton *)sender
{
    NSLog(@"点击了功能按钮%ld", (long)sender.tag);
}

- (void)knowCreditGradeBtnDidClicking: (UIButton *)sender
{
    NSLog(@"点击了了解信用分按钮%ld", (long)sender.tag);
    WLKnowCreditGradeViewController *vc = [[WLKnowCreditGradeViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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

-(NSArray *)functionBtns
{
    if (_functionBtns == nil)
    {
        NSMutableArray *arrTem = [NSMutableArray arrayWithCapacity:8];
        [arrTem addObject:@{@"image":@"doublePublicity", @"title":@"基本信息"}];
        [arrTem addObject:@{@"image":@"lhjc", @"title":@"资格证书"}];
        [arrTem addObject:@{@"image":@"xybg", @"title":@"获得奖项"}];
        [arrTem addObject:@{@"image":@"zdrq", @"title":@"获得称号"}];
        [arrTem addObject:@{@"image":@"dxal", @"title":@"榜上有名红"}];
        [arrTem addObject:@{@"image":@"xycn", @"title":@"榜上有名黑"}];
        [arrTem addObject:@{@"image":@"yyss", @"title":@"行政许可"}];
        [arrTem addObject:@{@"image":@"xyxf", @"title":@"行政处罚"}];
        [arrTem addObject:@{@"image":@"yyss", @"title":@"投资任职图谱"}];
        [arrTem addObject:@{@"image":@"xyxf", @"title":@"历史关联企业"}];
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

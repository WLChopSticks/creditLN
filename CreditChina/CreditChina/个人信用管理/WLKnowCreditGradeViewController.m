//
//  WLKnowCreditGradeViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/25.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLKnowCreditGradeViewController.h"
#import "RadarChart.h"
#import "WLPlatform.h"

@interface WLKnowCreditGradeViewController ()

@property (nonatomic, strong) RadarDataSet * radarDataSet;

@end

@implementation WLKnowCreditGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self decorateUI];
}

- (void)decorateUI
{
    [WLCommonTool makeViewShowingWithRoundCorner:self.bottomView andRadius:10];
    self.topView.backgroundColor = [UIColor colorWithRed:32.0/255 green:143.0/255 blue:236.0/255 alpha:1];
    self.title = @"了解信用分";
    
    _radarDataSet = [[RadarDataSet alloc] init];
    _radarDataSet.indicatorSet = @[RardarIndicatorMake(@"基础分", 115),                       RardarIndicatorMake(@"社会管理", 115),
                                   RardarIndicatorMake(@"政务领域", 115), RardarIndicatorMake(@"加分项", 115),
                                   RardarIndicatorMake(@"司法领域", 115), RardarIndicatorMake(@"商务领域", 115)];
    
    NSNumber * number1 = @(115 - 32);
    NSNumber * number2 = @(115 - 100);
    NSNumber * number3 = @(115 - 5);
    NSNumber * number4 = @(115 - 73.5);
    NSNumber * number5 = @(115 - 10);
    NSNumber * number6 = @(115 - 35);
    
    RadarData * radarData = [[RadarData alloc] init];
    radarData.datas = @[number1, number2, number3, number4, number5, number6];
    radarData.strockColor = [[UIColor whiteColor] colorWithAlphaComponent:.5f];
    radarData.lineWidth = .5f;
    radarData.shapeRadius = 1.5f;
    radarData.shapeLineWidth = .5f;
    radarData.shapeFillColor = [UIColor whiteColor];
    radarData.gradientColors = @[(__bridge id)C_HEXA(0x84C4F3, 0.5f).CGColor,
                                 (__bridge id)C_HEXA(0x84C4F3, 0.5f).CGColor];
    
    RadarData * radarData1 = [[RadarData alloc] init];
    radarData1.datas = @[number1, number2, @(0), @(0), number5, number6];
    radarData1.lineWidth = .0f;
    radarData1.gradientColors = @[(__bridge id)C_HEXA(0x84C4F3, 0.5f).CGColor,
                                  (__bridge id)C_HEXA(0x84C4F3, 0.5f).CGColor];
    
    RadarData * radarData2 = [[RadarData alloc] init];
    radarData2.datas = @[number1, number2, number3, number4, @(0), @(0)];
    radarData2.lineWidth = .0f;
    radarData2.gradientColors = @[(__bridge id)C_HEXA(0x84C4F3, 0.5f).CGColor,
                                  (__bridge id)C_HEXA(0x84C4F3, 0.5f).CGColor];
    
    RadarData * radarData3 = [[RadarData alloc] init];
    radarData3.datas = @[number1, number2, @(0), @(0), @(0), number6];
    radarData3.lineWidth = .0f;
    radarData3.gradientColors = @[(__bridge id)C_HEXA(0x84C4F3, 0.5f).CGColor,
                                  (__bridge id)C_HEXA(0x84C4F3, 0.5f).CGColor];
    //[UIColor colorWithRed:132.0/255 green:196.0/255 blue:243.0/255 alpha:1];
    _radarDataSet.titleFont = [UIFont systemFontOfSize:11];
    _radarDataSet.strockColor = [UIColor whiteColor];
    _radarDataSet.stringColor = [UIColor whiteColor];
    _radarDataSet.lineWidth = 1.0f;
    _radarDataSet.radius = 80;
    _radarDataSet.borderWidth = 1.0f;
    _radarDataSet.splitCount = 0;
    _radarDataSet.isCirlre = NO;
    _radarDataSet.fillColor = [UIColor colorWithRed:32.0/255 green:143.0/255 blue:236.0/255 alpha:1];
    _radarDataSet.radarSet = @[radarData, radarData1, radarData2, radarData3];
    
    RadarChart * radarChart = [[RadarChart alloc] initWithFrame:CGRectMake(0, 0, 250, 220)];
    radarChart.radarData = _radarDataSet;
    radarChart.backgroundColor = [UIColor colorWithRed:32.0/255 green:143.0/255 blue:236.0/255 alpha:1];
    [radarChart drawRadarChart];
    radarChart.center = CGPointMake(self.topView.centerX, self.topView.centerY - 20);
    [self.topView addSubview:radarChart];
    
    
//    [radarChart mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.topView.mas_centerX);
//        make.centerY.equalTo(self.topView.mas_centerY);
//        make.height.width.mas_equalTo(200);x
//    }];
    
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

//
//  WLKnowCreditGradeViewController.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/25.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLKnowCreditGradeViewController : WLBaseUIViewController
@property (weak, nonatomic) IBOutlet UILabel *gradeExtremeLow;
@property (weak, nonatomic) IBOutlet UILabel *gradeLow;
@property (weak, nonatomic) IBOutlet UILabel *gradeNormal;
@property (weak, nonatomic) IBOutlet UILabel *gradeHigh;
@property (weak, nonatomic) IBOutlet UILabel *gradeExtremeHigh;
@property (weak, nonatomic) IBOutlet UIProgressView *gradeProgress;
@property (weak, nonatomic) IBOutlet UIImageView *myCreditTopLeftImage;
@property (weak, nonatomic) IBOutlet UIImageView *myCreditTopRightImage;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, assign) NSInteger myCreditGrade;

@end

NS_ASSUME_NONNULL_END

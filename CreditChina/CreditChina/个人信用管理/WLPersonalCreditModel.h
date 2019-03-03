//
//  WLPersonalCreditModel.h
//  CreditChina
//
//  Created by 王磊 on 2019/3/3.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WLPersonalCreditPersonModel : NSObject

@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *evaluate;
@property (nonatomic, strong) NSString *filters;
@property (nonatomic, strong) NSString *lxdh;
@property (nonatomic, strong) NSString *mzdm;
@property (nonatomic, strong) NSString *pageNumber;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *rks;
@property (nonatomic, strong) NSString *sortColumns;
@property (nonatomic, strong) NSString *sortInfos;
@property (nonatomic, strong) NSString *surplus;
@property (nonatomic, strong) NSString *szdq;
@property (nonatomic, strong) NSString *xbdm;
@property (nonatomic, strong) NSString *xm;
@property (nonatomic, strong) NSString *xzz_mlxxdz;
@property (nonatomic, strong) NSString *zjhm;

@end

@interface WLPersonalCreditSocialDetailModel : NSObject
@property (nonatomic, strong) NSString *belowOnline;
@property (nonatomic, strong) NSString *evaluateCriterionCode;
@property (nonatomic, strong) NSString *evaluateCriterionName;
@property (nonatomic, strong) NSString *evaluateCriterionNote;
@property (nonatomic, strong) NSString *evaluateCriterionOrder;
@property (nonatomic, strong) NSString *evaluateCriterionScore;
@property (nonatomic, strong) NSString *isSingle;
@property (nonatomic, strong) NSString *scoreItemCode;
@property (nonatomic, strong) NSString *toTable;
@property (nonatomic, strong) NSString *upOnline;
@end

@interface WLPersonalCreditCategoryMapModel : NSObject

@property (nonatomic, strong) NSArray *socialRegion;
@property (nonatomic, strong) NSArray *businessRegion;
@property (nonatomic, strong) NSArray *judicialRegion;
@property (nonatomic, strong) NSArray *additionRegion;

@end

@interface WLPersonalCreditModel : NSObject

@property (nonatomic, strong) WLPersonalCreditPersonModel *person;
@property (nonatomic, strong) WLPersonalCreditCategoryMapModel *evaluateCategoryMap;

+(instancetype)getModel: (NSDictionary *)dict;

@end



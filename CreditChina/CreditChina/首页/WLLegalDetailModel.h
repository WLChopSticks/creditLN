//
//  WLLegalDetailModel.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLEnterpriseInfo : NSObject
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *creditNo;
@property (nonatomic, strong) NSString *uniqueCreditNo;
@property (nonatomic, strong) NSString *legalPeople;
@property (nonatomic, strong) NSString *IDCardNo;
@property (nonatomic, strong) NSString *foundDate;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *business;
@end

@interface WLEnterpriseIndexSetInfo : NSObject
@property (nonatomic, strong) NSString *xytype;
@property (nonatomic, strong) NSString *shortname;
@property (nonatomic, strong) NSString *typeshortcnname;
@property (nonatomic, strong) NSString *typedepartmentname;
@property (nonatomic, strong) NSString *shortcnname;
@property (nonatomic, strong) NSString *departmentname;
@property (nonatomic, strong) NSString *etablename;
@property (nonatomic, strong) NSString *ctablename;
@property (nonatomic, strong) NSString *personinfo;
@property (nonatomic, strong) NSString *personfield;
@property (nonatomic, strong) NSString *gxsjtime;
@end

@interface WLEnterpriseIndexSetData : NSObject
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSString *organiseName;
@property (nonatomic, strong) NSString *organiseCode;
@property (nonatomic, strong) NSString *organiseAddress;
@property (nonatomic, strong) NSString *legalPeople;
@property (nonatomic, strong) NSString *gszch;
@property (nonatomic, strong) NSString *firstCertificateDate;
@property (nonatomic, strong) NSString *validStartDate;
@property (nonatomic, strong) NSString *validEndDate;
@property (nonatomic, strong) NSString *latestReviewDate;
@end

@interface WLEnterpriseIndexSet : NSObject
@property (nonatomic, strong) NSArray *indexedSetData;
@property (nonatomic, strong) WLEnterpriseIndexSetInfo *indexedSetInfo;
@property (nonatomic, assign) NSInteger indexedSetDataCount;
@end

@interface WLEnterpriseDetailBlock : NSObject
@property (nonatomic, strong) NSArray *indexedSets;
@property (nonatomic, strong) NSString *typedepartmentname;
@property (nonatomic, strong) NSString *typeshortcnname;
@property (nonatomic, assign) NSInteger xytype;
@end

@interface WLEnterpriseXzDetail : NSObject
@property (nonatomic, strong) NSArray *enterpriseXzDetail;
@end

@interface WLLegalDetailModel : NSObject

@property (nonatomic, strong) WLEnterpriseInfo *enterpriseInfo;
@property (nonatomic, strong) WLEnterpriseXzDetail *enterpriseXzDetail;


+ (instancetype)getEnterproseDetailModel: (NSDictionary *)dict;

@end



//
//  WLNewsAndPolicyShowInExhibitionController.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/17.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLNewsAndPolicyShowInExhibitionController : UIViewController

//1为新闻, 2为政策法规
@property (nonatomic, strong) NSString *showType;
//1为国家, 2为省级
@property (nonatomic, strong) NSString *newsType;
//1为国家, 2为省级, 3为市级
@property (nonatomic, strong) NSString *policyType;

@end

NS_ASSUME_NONNULL_END

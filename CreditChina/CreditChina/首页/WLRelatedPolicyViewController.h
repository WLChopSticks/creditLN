//
//  WLRelatedPolicyViewController.h
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLRelatedPolicyViewController : WLBaseUIViewController

//1为国家政策, 2为省内政策, 3为市级政策
@property (nonatomic, strong) NSString *policyType;

@end

NS_ASSUME_NONNULL_END

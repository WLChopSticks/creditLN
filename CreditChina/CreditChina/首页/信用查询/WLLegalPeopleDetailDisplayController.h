//
//  WLLegalPeopleDetailDisplayController.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseUIViewController.h"
#import <WLPlatform.h>
#import <WLBaseTableViewCell.h>
#import "WLLegalDetailModel.h"

@interface WLLegalPeopleInfoSourceCell : WLBaseTableViewCell

@end

@interface WLLegalPeopleDetailDisplayController : WLBaseUIViewController

@property (nonatomic, strong) WLEnterpriseDetailBlock *block;
@property (nonatomic, assign) CGFloat lastHeight;
@property (nonatomic, assign) CGFloat actualHeight;

@end



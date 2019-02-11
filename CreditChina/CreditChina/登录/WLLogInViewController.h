//
//  WLLogInViewController.h
//  CreditChina
//
//  Created by 王磊 on 2019/1/29.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLPlatform.h"
#import <WLBaseUIViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLLogInViewController : WLBaseUIViewController
@property (weak, nonatomic) IBOutlet UIButton *wechatLogin;
@property (weak, nonatomic) IBOutlet UIButton *cellPhoneLogin;
@property (weak, nonatomic) IBOutlet UIButton *faceIdentityLogin;
@property (weak, nonatomic) IBOutlet UIButton *getCaptcha;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *cellPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *captchaTextField;

@end

NS_ASSUME_NONNULL_END

//
//  WLLogInViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/29.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLogInViewController.h"


@interface WLLogInViewController ()

@end

@implementation WLLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self decorateUI];
}

- (void)decorateUI
{
    [self.loginBtn setBackgroundColor:RedBackground];
    [self.loginBtn setTitleColor:WhiteStyle forState:UIControlStateNormal];
    [WLCommonTool makeViewShowingWithRoundCorner:self.loginBtn andRadius:10];
    [self.getCaptcha setBackgroundColor:RedBackground];
    [self.getCaptcha setTitleColor:WhiteStyle forState:UIControlStateNormal];
    [self.getCaptcha setTitleColor:LightGrayStyle forState:UIControlStateSelected];
    [WLCommonTool makeViewShowingWithRoundCorner:self.getCaptcha andRadius:10];
}
- (IBAction)getCaptchaBtnDidClicking:(UIButton *)sender
{
    NSLog(@"点击了获取验证码");
    //按钮点击后更改状态, 并且进入倒计时, 并跳转处理逻辑
    //if (self.cellPhoneTextField.text.length == 11)
    {
        sender.selected = YES;
        [self.captchaTextField becomeFirstResponder];
        [self createCountdown:sender];
    }
    
}

- (IBAction)loginBtnDidClicking:(id)sender
{
    NSLog(@"点击了登录按钮");
}


// 开启倒计时效果
-(void)createCountdown: (UIButton *)sender
{
    __block NSInteger time = CountDownTime; //倒计时时间
    [WLCommonTool createEverySecondTimer:^(dispatch_source_t timer) {
        //倒计时结束，关闭
        if(time <= 0)
        {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                sender.selected = NO;
            });
        }else
        {
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [sender setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateSelected];
                sender.userInteractionEnabled = NO;
            });
            time--;
        }
    }];
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

//
//  WLNewFeatureViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/30.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLNewFeatureViewController.h"
#import <WLPlatform.h>

@interface WLNewFeatureViewController ()<UIScrollViewDelegate>

@end

@implementation WLNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    UIScrollView *newFeaturesView = [[UIScrollView alloc]initWithFrame:Screen_Bounds];
    newFeaturesView.pagingEnabled = YES;
    [self.view addSubview:newFeaturesView];
    newFeaturesView.contentSize = CGSizeMake(3 * Screen_Width, Screen_Height);
    
    for (int i = 0; i < 3; i++)
    {
        UIView *container = [[UIView alloc]initWithFrame:Screen_Bounds];
        UIImageView *newFeature = [[UIImageView alloc]initWithFrame:container.bounds];
        container.frame = CGRectMake(i * Screen_Width, 0, Screen_Width, Screen_Height);
        newFeature.backgroundColor = i % 2 == 0 ? [UIColor yellowColor]: [UIColor greenColor];
        [newFeaturesView addSubview:container];
        [container addSubview:newFeature];
        
        if (i == 2)
        {
            UIButton *enterBtn = [[UIButton alloc]init];
            [enterBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            [container addSubview:enterBtn];
            enterBtn.frame = CGRectMake(Screen_Width * 0.5 - 50, Screen_Height - 50, 100, 50);
            [enterBtn addTarget:self action:@selector(enterBtnDidClicking) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
}

- (void)enterBtnDidClicking
{
    NSLog(@"立即体验按钮点击了");
    [[UIApplication sharedApplication]delegate].window.rootViewController = self.rootVC;
    [[[UIApplication sharedApplication]delegate].window makeKeyWindow];
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:YES] forKey:@"old_enter"];

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

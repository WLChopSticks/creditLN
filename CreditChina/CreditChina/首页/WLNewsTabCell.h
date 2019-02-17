//
//  WLNewsTabCell.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/17.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLNewsTabCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *lookTime;
@property (weak, nonatomic) IBOutlet UIButton *remark;


-(void)fillCellContent:(NSDictionary *)contentDict withCollectionView:(UICollectionView *)collectionView;

@end

NS_ASSUME_NONNULL_END

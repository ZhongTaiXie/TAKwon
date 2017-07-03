//
//  HotGalleryTableViewCell.h
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/6/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotGalleryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIImageView *myImageviewOne;
@property (weak, nonatomic) IBOutlet UIImageView *myImageviewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *myImageviewThree;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moreImage;

@end

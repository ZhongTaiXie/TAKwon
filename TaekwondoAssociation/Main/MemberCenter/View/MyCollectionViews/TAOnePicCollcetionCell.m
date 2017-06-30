//
//  TAOnePicCollcetionCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/30.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAOnePicCollcetionCell.h"

@interface TAOnePicCollcetionCell()

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeAndFromLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookNumBtn;


@end



@implementation TAOnePicCollcetionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.timeAndFromLabel.text = @"2017年03月04日 人民网";
    [self.lookNumBtn setImage:[[UIImage imageNamed:@"Browser"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.lookNumBtn setTitle:@"3444" forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

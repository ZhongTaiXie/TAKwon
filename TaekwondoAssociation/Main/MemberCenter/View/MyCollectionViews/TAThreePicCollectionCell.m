//
//  TAThreePicCollectionCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/30.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAThreePicCollectionCell.h"


@interface TAThreePicCollectionCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeAndFromLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookNumBtn;
@property (weak, nonatomic) IBOutlet UIImageView *firstNewsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondNewsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdNewsImageView;


@end

@implementation TAThreePicCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLabel.text = @"oiawnrognaworgnaoirmgoi'3mrg'iwj3m5io5jowirengvoij34o";
    self.timeAndFromLabel.text = @"2017年03月04日 人民网";
    [self.lookNumBtn setImage:[[UIImage imageNamed:@"Browser"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.lookNumBtn setTitle:@"3444" forState:UIControlStateNormal];
    self.lookNumBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,self.lookNumBtn.titleLabel.bounds.size.width);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

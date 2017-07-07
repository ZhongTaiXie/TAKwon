//
//  TAMemberIconCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAMemberIconCell.h"

@interface TAMemberIconCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end


@implementation TAMemberIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    self.iconImageView.image = iconImage;
}

@end

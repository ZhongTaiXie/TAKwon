//
//  TAPersonalCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/27.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAPersonalCell.h"

@interface TAPersonalCell()
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end



@implementation TAPersonalCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    self.titleImageView.image = [UIImage imageNamed:title];
}


@end

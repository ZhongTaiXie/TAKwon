//
//  TAGongGaoCollectionCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/30.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAGongGaoCollectionCell.h"
@interface TAGongGaoCollectionCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation TAGongGaoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.text = @"oiawnrognaworgnaoirmgoi'3mrg'iwj3m5io5jowirengvoij34o";
    self.timeLabel.text = @"2017年03月04日 人民网";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

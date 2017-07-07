//
//  TALessonTimeCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TALessonTimeCell.h"

@interface TALessonTimeCell()

//@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end


@implementation TALessonTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
}


@end

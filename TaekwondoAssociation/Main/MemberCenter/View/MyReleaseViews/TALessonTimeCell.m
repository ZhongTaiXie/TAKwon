//
//  TALessonTimeCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TALessonTimeCell.h"

@interface TALessonTimeCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

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
    self.timeLabel.textColor = timeStr.length == 0 ? [WQTools colorWithHexString:@"cbcbcd"] : [WQTools colorWithHexString:@"666666"];
    self.timeLabel.text = timeStr.length == 0 ? @"请选择时间" : timeStr;
}

@end

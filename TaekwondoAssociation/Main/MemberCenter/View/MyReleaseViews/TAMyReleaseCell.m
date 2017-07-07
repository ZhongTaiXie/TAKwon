//
//  TAMyReleaseCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/4.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAMyReleaseCell.h"

@interface TAMyReleaseCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end


@implementation TAMyReleaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setActivityModel:(TAActivityModel *)activityModel{
    _activityModel = activityModel;
    self.titleLabel.text = activityModel.title;
    self.timeLabel.text = activityModel.CreatedTime;
}

-(void)setLessonModel:(TALessonModel *)lessonModel{
    _lessonModel = lessonModel;
    self.titleLabel.text = lessonModel.title;
    self.timeLabel.text = lessonModel.CreatedTime;
}

@end

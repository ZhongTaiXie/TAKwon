//
//  TAActivityTimeCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAActivityTimeCell.h"

@interface TAActivityTimeCell()

@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;

@end


@implementation TAActivityTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)starBtnClick:(id)sender {
    self.startTimeBtnClick(@"");
}
- (IBAction)endBtnClick:(id)sender {
    self.endTimeBtnClick(@"");
}


-(void)setStartTimeStr:(NSString *)startTimeStr{
    _startTimeStr = startTimeStr;
    [self.startTimeBtn setTitle:startTimeStr.length == 0 ? @"开始时间" : startTimeStr forState:UIControlStateNormal];
}

-(void)setEndTimeStr:(NSString *)endTimeStr{
    _endTimeStr = endTimeStr;
    
    [self.endTimeBtn setTitle:endTimeStr.length == 0 ? @"结束时间" : endTimeStr forState:UIControlStateNormal];
}

@end

//
//  WeightInfoCell.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/5.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "WeightInfoCell.h"

@implementation WeightInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString* Id = @"weightInfoCellId";
    WeightInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[WeightInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupDetailView];
    }
    
    return self;
}

- (void)setupDetailView
{
    // textfield
    _tfView = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, KTA_Screen_Width - 70, 44)];
    _tfView.leftView = _leftLb;
    _tfView.leftViewMode = UITextFieldViewModeAlways;
    _tfView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tfView.placeholder = @"请输入体重(kg)";
    _tfView.font = [UIFont systemFontOfSize:14];
    
    // 右边label
    _rightLb = [[UILabel alloc] initWithFrame:CGRectMake(KTA_Screen_Width - 70, 0, 60, 44)];
    _rightLb.font = [UIFont systemFontOfSize:14];
    _rightLb.textColor = [UIColor grayColor];
    NSString* str = @"＊(必填)";
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:@"＊"]];
    _rightLb.attributedText = attStr;
    
    // 左边label
    _leftLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    _leftLb.text = @"体重:";
    _leftLb.textColor = [UIColor lightGrayColor];
    _leftLb.font = [UIFont systemFontOfSize:14];
    _tfView.leftView = _leftLb;
    
    [self.contentView addSubview:_tfView];
    [self.contentView addSubview:_rightLb];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  TrainingContentCell.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TrainingContentCell.h"

@implementation TrainingContentCell

+ (instancetype)cellWithTableview:(UITableView *)tableView
{
    static NSString* cellId = @"trainingContentCellId";
    TrainingContentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[TrainingContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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
    NSArray* dataArr = @[@"国际段位考试",@"一级裁判员"];
    // leftLabel
    _leftLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
    _leftLb.font = [UIFont systemFontOfSize:14];
    _leftLb.textColor = [UIColor darkGrayColor];
    NSString* colorStr = @"培训内容＊";
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:colorStr];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[colorStr rangeOfString:@"＊"]];
    _leftLb.attributedText = attStr;
    
    // rightBtn
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(KTA_Screen_Width - 120, 0, 110, 44);
    [_rightBtn setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    [_rightBtn setImage:[UIImage imageNamed:@"yuan_selected"] forState:UIControlStateSelected];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightBtn setTitle:dataArr[1] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // leftBtn
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(KTA_Screen_Width - 230, 0, 110, 44);
    [_leftBtn setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage imageNamed:@"yuan_selected"] forState:UIControlStateSelected];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_leftBtn setTitle:dataArr[0] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_leftLb];
    [self.contentView addSubview:_leftBtn];
    [self.contentView addSubview:_rightBtn];
    
}

- (void)leftBtnClick:(UIButton*)btn
{
    _leftBtn.selected = YES;
    _rightBtn.selected = NO;
}

- (void)rightBtnClick:(UIButton*)btn
{
    _rightBtn.selected = YES;
    _leftBtn.selected = NO;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ApplyTextFieldCell.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/7.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "ApplyTextFieldCell.h"

@implementation ApplyTextFieldCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString* CellId = @"applyTextFieldCellId";
    ApplyTextFieldCell* cell = [tableview dequeueReusableCellWithIdentifier:CellId];
    if (!CellId) {
        cell = [[ApplyTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
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
    // leftLb
    _leftLb = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 80, 44)];
    _leftLb.textColor = [UIColor darkGrayColor];
    _leftLb.font = [UIFont systemFontOfSize:14];
    
    // tfView
    _tfView = [[UITextField alloc] initWithFrame:CGRectMake(KTA_Screen_Width - 100 , 0, KTA_Screen_Width - 115, 44)];
    _tfView.textAlignment = NSTextAlignmentRight;
    _tfView.font = [UIFont systemFontOfSize:14];
    _tfView.textColor = [UIColor lightGrayColor];
    
    
    [self.contentView addSubview:_leftLb];
    [self.contentView addSubview:_tfView];
}

- (void)setLeftLbText:(NSString *)leftLbText
{
    _leftLbText = leftLbText;
    
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:_leftLbText attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    
    [attStr fixAttributesInRange:[_leftLbText rangeOfString:@"＊"]];
    _leftLb.attributedText = attStr;
    
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

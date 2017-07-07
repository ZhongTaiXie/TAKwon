//
//  TAReleaseLessonCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAReleaseLessonCell.h"

@implementation TAReleaseLessonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title placeHolder:(NSString *)placeHolder{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUIWithTitle:title placeHolder:placeHolder];
    }
    return self;
}

-(void)setupUIWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder{
    UILabel *titleLabel = [WQFactoryUI createLabelWithtextFont:15 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(10, 0, 70, 45)  text:title];
    [self addSubview:titleLabel];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, 0,KTA_Screen_Width - 125, 45)];
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.textColor = [WQTools colorWithHexString:@"666666"];
    self.textField.placeholder = placeHolder;
    [self addSubview:self.textField];
    
}

@end

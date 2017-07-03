//
//  TATaekwondoAuthCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/28.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TATaekwondoAuthCell.h"

@interface TATaekwondoAuthCell(){
    UILabel *titleLabel;
    
}


@end



@implementation TATaekwondoAuthCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title placeholder:(NSString *)placeholder{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUIWithTitle:title placeholder:placeholder];
    }
    return self;
}

-(void)setupUIWithTitle:(NSString *)title placeholder:(NSString *)placeholder{
    titleLabel = [WQFactoryUI createLabelWithtextFont:13 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(15, 0, 80, 45) text:title];
    [self addSubview:titleLabel];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 10, 0, KTA_Screen_Width - 110, 45)];
    self.textField.placeholder = placeholder;
    self.textField.font = [UIFont systemFontOfSize:13];
    self.textField.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.textField];
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

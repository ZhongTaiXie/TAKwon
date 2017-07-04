//
//  TAMyReleaseTitleCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAMyReleaseTitleCell.h"

@implementation TAMyReleaseTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUIWithTitle:title];
    }
    return self;
}

-(void)setupUIWithTitle:(NSString *)title{
    
    self.backgroundColor = [WQTools colorWithHexString:@"f5f5f5"];
    
    UIView *view = [WQFactoryUI createViewWithFrame:CGRectMake(0, 12, 5, 21) viewBackgroundColor:MAINCOLOR];
    
    [self addSubview:view];
    
    UILabel *titleLabel = [WQFactoryUI createLabelWithtextFont:15 textBackgroundColor:[UIColor clearColor] textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(15, 0, 100, 45) text:title];
    [self addSubview:titleLabel];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(KTA_Screen_Width - 35, 10, 25, 25)];
    [addBtn setImage:[UIImage imageNamed:@"add_gray"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addRelease) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)addRelease{
    self.addBtnClick(@"");
}

@end

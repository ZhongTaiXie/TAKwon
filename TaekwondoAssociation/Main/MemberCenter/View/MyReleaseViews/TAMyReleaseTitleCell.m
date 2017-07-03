//
//  TAMyReleaseTitleCell.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAMyReleaseTitleCell.h"

@implementation TAMyReleaseTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title image:(NSString *)imageName{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUIWithTitle:title image:imageName];
    }
    return self;
}

-(void)setupUIWithTitle:(NSString *)title image:(NSString *)imageName{
    UIImageView *imageView = [WQFactoryUI createImageViewWithFrame:CGRectMake(10, 10, 25, 25) imageName:imageName borderWidth:0 borderColor:WHITECOLOR cornerRadius:0];
    [self addSubview:imageView];
    
    UILabel *titleLabel = [WQFactoryUI createLabelWithtextFont:15 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(40, 0, 100, 45) text:title];
    [self addSubview:titleLabel];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(KTA_Screen_Width - 35, 10, 25, 25)];
    [addBtn setImage:[UIImage imageNamed:@"addPic"] forState:UIControlStateNormal];
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

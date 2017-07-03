//
//  TAuploadPicView.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/28.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAuploadPicView.h"

@interface TAuploadPicView(){
    UILabel *titleLabel;
    UIButton *addBtn;
}

@end

@implementation TAuploadPicView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageArray:(NSArray *)imageArray{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = WHITECOLOR;
        [self setupUIWithFrame:frame title:title imageArray:(NSArray *)imageArray];
    }
    return self;
}

-(void)setupUIWithFrame:(CGRect)frame title:(NSString *)title imageArray:(NSArray *)imageArray{
    titleLabel = [WQFactoryUI createLabelWithtextFont:13 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(15, 0, 200, 30) text:title];
    [self addSubview:titleLabel];
    
    CGFloat width = (KTA_Screen_Width - 40) / 3;
    CGFloat height = width * 68 / 100;
    
    addBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, width, height)];
    [addBtn setImage:[UIImage imageNamed:@"add-big"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
}

-(void)addPic{
    self.addPicBtnClick(@"");
}

@end

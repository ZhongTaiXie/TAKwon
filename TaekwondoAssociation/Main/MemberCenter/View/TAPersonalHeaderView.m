//
//  WQPersonalHeaderView.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/27.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAPersonalHeaderView.h"


@interface TAPersonalHeaderView(){
    UIImageView *bgImageView;
    UIImageView *headerImagView;
    UILabel *nickNameLabel;
    
}

@end


@implementation TAPersonalHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUIWithFrame:frame];
    }
    return self;
}

-(void)setupUIWithFrame:(CGRect)frame{
    //背景图
    bgImageView = [WQFactoryUI createImageViewWithFrame:CGRectMake(0, -20, KTA_Screen_Width, 200) imageName:@"header_bg" borderWidth:0 borderColor:WHITECOLOR cornerRadius:0];
    bgImageView.userInteractionEnabled = YES;
    [bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgImageViewClick)]];
    [self addSubview:bgImageView];
    
    //头像
    headerImagView = [WQFactoryUI createImageViewWithFrame:CGRectMake((KTA_Screen_Width - 70) / 2, 20, 70, 70) imageName:@"header" borderWidth:0 borderColor:WHITECOLOR cornerRadius:35];
    headerImagView.userInteractionEnabled = YES;
    [headerImagView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImagViewClick)]];
    [self addSubview:headerImagView];
    
    //昵称
    nickNameLabel = [WQFactoryUI createLabelWithtextFont:16 textBackgroundColor:[UIColor clearColor] textAliment:NSTextAlignmentCenter textColor:WHITECOLOR textFrame:CGRectMake(0, CGRectGetMaxY(headerImagView.frame) + 10, KTA_Screen_Width, 30) text:@"昵称"];
    [self addSubview:nickNameLabel];
    
    int a = 1, b = 10;
    if (a == 1) {  //个人
        UIView *bgview = [WQFactoryUI createViewWithFrame:CGRectMake((KTA_Screen_Width - 190) / 2, CGRectGetMaxY(nickNameLabel.frame) + 10, 90, 20) viewBackgroundColor:WHITECOLOR];
        bgview.layer.cornerRadius = 10;
        bgview.layer.masksToBounds = YES;
        [self addSubview:bgview];
        
        NSString *imgName = b == 10 ? @"zuanshi" : @"zuanshi";
        NSString *title = b == 10 ? @"教练员" : @"学生";
        UIImageView *imageView = [WQFactoryUI createImageViewWithFrame:CGRectMake(10, 3, 14, 14) imageName:imgName borderWidth:0 borderColor:WHITECOLOR cornerRadius:0];
        [bgview addSubview:imageView];
        
        UILabel *titleLabel = [WQFactoryUI createLabelWithtextFont:13 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(30, 0, bgview.frame.size.width - 30, 20) text:title];
        [bgview addSubview:titleLabel];
        
        
        UIView *bgview2 = [WQFactoryUI createViewWithFrame:CGRectMake(CGRectGetMaxX(bgview.frame) + 10, CGRectGetMaxY(nickNameLabel.frame) + 10, 80, 20) viewBackgroundColor:WHITECOLOR];
        bgview2.layer.cornerRadius = 10;
        bgview2.layer.masksToBounds = YES;
        [self addSubview:bgview2];
        
        NSString *imgName2 = b == 10 ? @"已认证" : @"未认证";
        NSString *title2 = b == 10 ? @"已认证" : @"未认证";
        UIImageView *imageView2 = [WQFactoryUI createImageViewWithFrame:CGRectMake(10, 2, 16, 16) imageName:imgName2 borderWidth:0 borderColor:WHITECOLOR cornerRadius:0];
        [bgview2 addSubview:imageView2];
        
        UILabel *titleLabel2 = [WQFactoryUI createLabelWithtextFont:13 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(30, 0, bgview2.frame.size.width - 30, 20) text:title2];
        [bgview2 addSubview:titleLabel2];
        
        
    }else{  //道馆
        UIView *bgview = [WQFactoryUI createViewWithFrame:CGRectMake((KTA_Screen_Width - 80) / 2, CGRectGetMaxY(nickNameLabel.frame) + 10, 80, 20) viewBackgroundColor:WHITECOLOR];
        bgview.layer.cornerRadius = 10;
        bgview.layer.masksToBounds = YES;
        [self addSubview:bgview];
        
        NSString *imgName = b == 10 ? @"已认证" : @"未认证";
        NSString *title = b == 10 ? @"已认证" : @"未认证";
        UIImageView *imageView = [WQFactoryUI createImageViewWithFrame:CGRectMake(10, 2, 16, 16) imageName:imgName borderWidth:0 borderColor:WHITECOLOR cornerRadius:0];
        [bgview addSubview:imageView];
        
        UILabel *titleLabel = [WQFactoryUI createLabelWithtextFont:13 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(30, 0, bgview.frame.size.width - 30, 20) text:title];
        [bgview addSubview:titleLabel];
        
    }
    
}

-(void)bgImageViewClick{
    self.bgImageViewDidClick(@"bgImageViewDidClick");
}

-(void)headerImagViewClick{
    self.headerImageViewClick(@"headerImageViewClick");
}

@end

//
//  TAMemberInfoView.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/27.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAMemberInfoView.h"

@implementation TAMemberInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
        [self setupUIWithFrame:frame];
    }
    return self;
}

-(void)setupUIWithFrame:(CGRect)frame{
    CGFloat width = (KTA_Screen_Width - 2) / 3;
    
    //会员等级View
    UIView *memberGradeView = [WQFactoryUI createViewWithFrame:CGRectMake(0, 0, width, frame.size.height) viewBackgroundColor:WHITECOLOR];
    //点击View
    [memberGradeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(memberGradeViewClick)]];
    
    //会员等级label
    UILabel *memberGradeLabel = [WQFactoryUI createLabelWithtextFont:18 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentCenter textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(0, 0, width, 40) text:@"会员等级"];
    memberGradeLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [memberGradeView addSubview:memberGradeLabel];
    
    //会员等级label
    UILabel *memberGradeLabel2 = [WQFactoryUI createLabelWithtextFont:16 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentCenter textColor:[WQTools colorWithHexString:@"7a7e83"] textFrame:CGRectMake(0, CGRectGetMaxY(memberGradeLabel.frame) + 10, width, 20) text:@"青铜会员"];
    [memberGradeView addSubview:memberGradeLabel2];
    
    [self addSubview:memberGradeView];
    
    //积分的View
    UIView *integrationView = [WQFactoryUI createViewWithFrame:CGRectMake(CGRectGetMaxX(memberGradeView.frame) + 1, 0, width, frame.size.height) viewBackgroundColor:WHITECOLOR];
    //点击View
    [integrationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(integrationViewClick)]];
    
    
    //积分的label
    UILabel *integrationLabel = [WQFactoryUI createLabelWithtextFont:18 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentCenter textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(0, 0, width, 40) text:@"积分"];
    integrationLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [integrationView addSubview:integrationLabel];
    //积分的label
//    UILabel *integrationLabel2 = [WQFactoryUI createLabelWithtextFont:16 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentCenter textColor:[UIColor blackColor] textFrame:CGRectMake(0, CGRectGetMaxY(integrationLabel.frame) + 10, width, 20) text:@"500"];
    UILabel *integrationLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(integrationLabel.frame) + 10, width, 20)];
    integrationLabel2.text = @"500";
    integrationLabel2.font = [UIFont systemFontOfSize:16];
    integrationLabel2.textColor = [WQTools colorWithHexString:@"7a7e83"];
    integrationLabel2.textAlignment = NSTextAlignmentCenter;
    [integrationView addSubview:integrationLabel2];
    [self addSubview:integrationView];
    
    
    
    //二维码View
    UIView *QRCodeView = [WQFactoryUI createViewWithFrame:CGRectMake(CGRectGetMaxX(integrationView.frame) + 1, 0, width, frame.size.height) viewBackgroundColor:WHITECOLOR];
    //点击View
    [QRCodeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QRCodeViewClick)]];
    
    
    //二维码label
    UILabel *QRCodeLabel = [WQFactoryUI createLabelWithtextFont:18 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentCenter textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(0, 0, width, 40) text:@"二维码"];
    QRCodeLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [QRCodeView addSubview:QRCodeLabel];
    
    //二维码imageView
    UIImageView *QRCodeImageView = [WQFactoryUI createImageViewWithFrame:CGRectMake((width - 30) / 2, CGRectGetMaxY(QRCodeLabel.frame) + 5, 30, 30) imageName:@"QRCode" borderWidth:0 borderColor:WHITECOLOR cornerRadius:0];
    [QRCodeView addSubview:QRCodeImageView];
    
    [self addSubview:QRCodeView];
}

//点击会员等级View
-(void)memberGradeViewClick{
    self.memberGradeViewDidClick();
}
//点击积分的View
-(void)integrationViewClick{
    self.integrationViewDidClick();
}
//点击二维码View
-(void)QRCodeViewClick{
    self.QRCodeViewDidClick();
}

@end

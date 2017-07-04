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
    
    for (int i = 0; i < imageArray.count; i++) {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(index * (width + 10) + 10, page  * (height + 10) + 30, width, height)];
        imgview.userInteractionEnabled = YES;
        imgview.image = imageArray[i];
        
        //删除按钮的实现
        UIButton *delBtn =  [[UIButton alloc] initWithFrame:CGRectMake(imgview.frame.size.width - 21,1, 20, 20)];
        delBtn.tag = 100 + i;
        [delBtn setImage:[UIImage imageNamed:@"icon_find_phone_del"] forState:UIControlStateNormal];
        [delBtn addTarget:self action:@selector(delPic:) forControlEvents:UIControlEventTouchUpInside];
        [imgview addSubview:delBtn];
        
        [self addSubview:imgview];
    }
    
    int row = 0;
    row = (int)imageArray.count / 3 + 1;
    
    addBtn = [[UIButton alloc] initWithFrame:CGRectMake(10 + (10 + width) * (imageArray.count % 3), 30 + height * (row - 1) + 10 * (row - 1),width,height)];
    [addBtn setImage:[UIImage imageNamed:@"add-big"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    
    if ([title containsString:@"身份证"]) {
        if (imageArray.count == 2) {
            addBtn.hidden = YES;
        }else{
            addBtn.hidden = NO;
        }
    }else{
        if (imageArray.count == 1) {
            addBtn.hidden = YES;
        }else{
            addBtn.hidden = NO;
        }
    }
    
    
}

-(void)addPic{
    self.addPicBtnClick(@"");
}

-(void)delPic:(UIButton *)btn{
    if ([titleLabel.text containsString:@"身份证"]) {
        self.delPicBtnClick(@"1",btn.tag);
    }else{
        self.delPicBtnClick(@"2",btn.tag);
    }
    
    
    
}

@end

//
//  SYDatePicker.m
//  DatePickerDemo
//
//  Created by Apple on 16/3/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SYDatePicker.h"

@implementation SYDatePicker

- (void)showInView:(UIView *)view withFrame:(CGRect)frame andDatePickerMode:(UIDatePickerMode)mode withTitle:(NSString *)title{
    self.frame = frame;
    self.backgroundColor = [UIColor lightGrayColor];
    
    if(!self.picker){
        self.picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 200)];
    }
    
    self.picker.datePickerMode = mode;
    [self.picker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.picker];
    
    //取消按钮
    UIButton *cancleBtn = [WQFactoryUI createButtonWithTitleFont:16 buttonBackgroundColor:[UIColor lightGrayColor] titleColor:[UIColor whiteColor] buttonFrame:CGRectMake(0, 8, 50, 30) text:@"取消" cornerRadius:0];
    [cancleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    
    //显示文字
    UILabel *label = [WQFactoryUI createLabelWithtextFont:18 textBackgroundColor:[UIColor lightGrayColor] textAliment:NSTextAlignmentCenter textColor:[UIColor whiteColor] textFrame:CGRectMake(50, 8, KTA_Screen_Width - 100, 30) text:title];
    [self addSubview:label];
    
    //完成按钮
    UIButton *btnDone = [WQFactoryUI createButtonWithTitleFont:16 buttonBackgroundColor:[UIColor lightGrayColor] titleColor:[UIColor whiteColor] buttonFrame:CGRectMake(self.bounds.size.width - 50, 8, 50, 30) text:@"完成" cornerRadius:0];
    [btnDone addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnDone];
    [view addSubview:self];
}

- (void)dismiss{
    [self removeFromSuperview];
}

- (void)ok{
    [self removeFromSuperview];
    if([self.delegate respondsToSelector:@selector(ok:)]){
        [self.delegate ok:self.picker.date];
    }
}

- (void)valueChanged:(UIDatePicker *)picker{
    if([self.delegate respondsToSelector:@selector(picker:ValueChanged:)]){
        [self.delegate picker:picker ValueChanged:picker.date];
    }
}

@end

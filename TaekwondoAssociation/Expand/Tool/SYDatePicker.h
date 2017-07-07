//
//  SYDatePicker.h
//  DatePickerDemo
//
//  Created by Apple on 16/3/8.
//  Copyright © 2016年 Apple. All rights reserved.
//
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#import <UIKit/UIKit.h>

@protocol SYDatePickerDelegate <NSObject>

@optional
//当UIDatePicker值变化时所用到的代理
- (void)picker:(UIDatePicker *)picker ValueChanged:(NSDate *)date;
-(void)ok:(NSDate *)date;
@end

@interface SYDatePicker : UIView

@property  (weak, nonatomic) id<SYDatePickerDelegate> delegate;

@property  (strong, nonatomic) UIDatePicker *picker;

- (void)showInView:(UIView *)view withFrame:(CGRect)frame andDatePickerMode:(UIDatePickerMode)mode withTitle:(NSString *)title;

- (void)dismiss;

- (void)valueChanged:(UIDatePicker *)picker;



@end

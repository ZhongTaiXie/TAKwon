//
//  TAFeedbackViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAFeedbackViewController.h"

@interface TAFeedbackViewController ()<UITextViewDelegate>{
    UILabel *label;
}

@property (nonatomic,strong) UITextView *feedTextView;
@property (nonatomic,strong) UITextField *phoneNumTextField;

@end

@implementation TAFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupContentView];
}

-(void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"我的发布";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = okItem;
}

-(void)setupContentView{
    self.view.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    
    UIView *bgview = [WQFactoryUI createViewWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 220) viewBackgroundColor:WHITECOLOR];
    self.feedTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, KTA_Screen_Width - 20, 200)];
    self.feedTextView.delegate = self;
    label = [WQFactoryUI createLabelWithtextFont:15 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"999999"] textFrame:CGRectMake(10, 0, KTA_Screen_Width - 20, 30) text:@""];
    label.text = @"请详尽描述您的问题，方便快速处理";
    [self.feedTextView addSubview:label];
    
    [bgview addSubview:self.feedTextView];
    [self.view addSubview:bgview];
    
    
    UIView *bgview2 = [WQFactoryUI createViewWithFrame:CGRectMake(0, CGRectGetMaxY(bgview.frame) + 10, KTA_Screen_Width, 40) viewBackgroundColor:WHITECOLOR];
    self.phoneNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, KTA_Screen_Width - 20, 40)];
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTextField.placeholder = @"联系方式(手机号码)";
    self.phoneNumTextField.font = [UIFont systemFontOfSize:15];
    [bgview2 addSubview:self.phoneNumTextField];
    [self.view addSubview:bgview2];
    
    
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submit{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""]) {
        label.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        label.hidden = NO;
    }
    
    return YES;
}

@end

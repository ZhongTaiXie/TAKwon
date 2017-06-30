//
//  TARegistViewController.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TARegistViewController.h"
#import "ConstColor.h"
#import "AgreementViewController.h"
@interface TARegistViewController ()<UITextFieldDelegate>
{
    UIButton *personalBtn;//个人注册按钮
    UIButton *taekwondoBtn;//道馆注册按钮
    UILabel *lineLeftLab;//按钮下线
    UILabel *lineRightLab;
    UITextField *accountNumberTF;//输入框手机号邮箱输入框
    UITextField *verificationCodeTF;//验证码输入框
    UITextField *passwordTF;//密码输入框
    UITextField *confirmPasswordTF;//确认密码输入框
    UIButton *checkBoxBtn;//注册页的同意协议按钮box
    BOOL isForgot;//标示box的状态
}
@end
@implementation TARegistViewController
#pragma mark - lifeClicle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithTopBtn];
    [self personalBtnClick];
    [self initWithUI];
}
#pragma mark - 初始化头部切换按钮
- (void)initWithTopBtn
{
    // 个人
    personalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    personalBtn.frame = CGRectMake(0, 64, KTA_Screen_Width/2, 40);
    [personalBtn addTarget:self action:@selector(personalBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [personalBtn setTitle:@"个人" forState:UIControlStateNormal];
    personalBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [personalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:personalBtn];
    lineLeftLab = [[UILabel alloc]initWithFrame:CGRectMake(0, personalBtn.frame.origin.y + personalBtn.frame.size.height - 2, personalBtn.frame.size.width, 2)];
    lineLeftLab.backgroundColor = RGB(0, 120, 251);
    [self.view addSubview:lineLeftLab];
    //道馆
    taekwondoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    taekwondoBtn.frame = CGRectMake(KTA_Screen_Width/2, 64, KTA_Screen_Width/2, 40);
    [taekwondoBtn addTarget:self action:@selector(taekwondoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [taekwondoBtn setTitle:@"道馆" forState:UIControlStateNormal];
    [taekwondoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    taekwondoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:taekwondoBtn];
    lineRightLab = [[UILabel alloc]initWithFrame:CGRectMake(personalBtn.frame.size.width, personalBtn.frame.origin.y + personalBtn.frame.size.height - 2, personalBtn.frame.size.width, 2)];
    lineRightLab.backgroundColor = RGB(0, 120, 251);
    [self.view addSubview:lineRightLab];
}
#pragma mark - 初始化UI
- (void)initWithUI
{
    //手机号或邮箱输入框
    accountNumberTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 154, KTA_Screen_Width-40, 40)];
    accountNumberTF.placeholder = @"请输入/手机号码/邮箱";
    accountNumberTF.delegate = self;
    accountNumberTF.tag = 1;
    [accountNumberTF.layer setBorderColor:[ConstColor themeColor].CGColor];
    [accountNumberTF setFont:[UIFont systemFontOfSize:15]];
    UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    accountNumberTF.leftView = leftView;
    accountNumberTF.leftViewMode = UITextFieldViewModeAlways;
    accountNumberTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [accountNumberTF.layer setBorderWidth:0.5];
    accountNumberTF.layer.cornerRadius = 4;
    [self.view addSubview:accountNumberTF];
    //验证码
    verificationCodeTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 154+40+20, KTA_Screen_Width-150, 40)];
    verificationCodeTF.delegate = self;
    verificationCodeTF.tag = 2;
    verificationCodeTF.placeholder = @"请输入验证码";
    [verificationCodeTF.layer setBorderColor:[ConstColor dividerColor].CGColor];
    [verificationCodeTF setFont:[UIFont systemFontOfSize:15]];
    UILabel *codeLeftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    codeLeftView.backgroundColor = [UIColor clearColor];
    verificationCodeTF.leftView = codeLeftView;
    verificationCodeTF.leftViewMode = UITextFieldViewModeAlways;
    verificationCodeTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [verificationCodeTF.layer setBorderWidth:0.5];
    verificationCodeTF.layer.cornerRadius = 4;
    [self.view addSubview:verificationCodeTF];
    //获取验证码
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.frame = CGRectMake(verificationCodeTF.frame.origin.x + verificationCodeTF.frame.size.width + 20, verificationCodeTF.frame.origin.y, 90, 40);
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    codeBtn.backgroundColor = RGB(57, 135, 251);
    codeBtn.layer.cornerRadius = 4;
    [codeBtn addTarget:self action:@selector(verificationCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeBtn];
    //密码
    passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(20, verificationCodeTF.frame.origin.y + verificationCodeTF.frame.size.height + 20, KTA_Screen_Width-40, 40)];
    passwordTF.delegate = self;
    passwordTF.tag = 3;
    passwordTF.placeholder = @"请输入密码";
    [passwordTF.layer setBorderColor:[ConstColor dividerColor].CGColor];
    [passwordTF setFont:[UIFont systemFontOfSize:15]];
    UILabel *passwordLeftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    codeLeftView.backgroundColor = [UIColor clearColor];
    passwordTF.leftView = passwordLeftView;
    passwordTF.leftViewMode = UITextFieldViewModeAlways;
    passwordTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [passwordTF.layer setBorderWidth:0.5];
    passwordTF.layer.cornerRadius = 4;
    [self.view addSubview:passwordTF];
    //确认密码
    confirmPasswordTF = [[UITextField alloc]initWithFrame:CGRectMake(20, passwordTF.frame.origin.y + passwordTF.frame.size.height + 20, KTA_Screen_Width-40, 40)];
    confirmPasswordTF.delegate = self;
    confirmPasswordTF.tag = 4;
    confirmPasswordTF.placeholder = @"确认新密码";
    [confirmPasswordTF.layer setBorderColor:[ConstColor dividerColor].CGColor];
    [confirmPasswordTF setFont:[UIFont systemFontOfSize:15]];
    UILabel *confirmPasswordLeftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    confirmPasswordLeftView.backgroundColor = [UIColor clearColor];
    confirmPasswordTF.leftView = confirmPasswordLeftView;
    confirmPasswordTF.leftViewMode = UITextFieldViewModeAlways;
    confirmPasswordTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [confirmPasswordTF.layer setBorderWidth:0.5];
    confirmPasswordTF.layer.cornerRadius = 4;
    [self.view addSubview:confirmPasswordTF];
    //注册
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(20, confirmPasswordTF.frame.origin.y + confirmPasswordTF.frame.size.height + 50, KTA_Screen_Width-40, 40);
    if ([_isRegister isEqualToString:@"1"]) {
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    }
    else
    {
        [registerBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    registerBtn.backgroundColor = RGB(57, 135, 251);
    registerBtn.layer.cornerRadius = 4;
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    //判断是不是注册页  如果是就显示协议
    if ([_isRegister isEqualToString:@"1"]) {
        //checkBox
        checkBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        checkBoxBtn.frame = CGRectMake(20, registerBtn.frame.origin.y + 40 + 20, 20, 20);
//        checkBoxBtn.backgroundColor = [UIColor redColor];
        [checkBoxBtn setImage:[UIImage imageNamed:@"login_forgot"] forState:UIControlStateNormal];
        [checkBoxBtn addTarget:self action:@selector(checkBoxBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:checkBoxBtn];
        //同意协议
        UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreeBtn.frame = CGRectMake(checkBoxBtn.frame.origin.x + checkBoxBtn.frame.size.width + 10, checkBoxBtn.frame.origin.y, 60, 20);
        [agreeBtn setTitle:@"同意协议" forState:UIControlStateNormal];
        agreeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [agreeBtn setTitleColor:RGB(148, 148, 148) forState:UIControlStateNormal];
        [agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:agreeBtn];
    }
}
#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSInteger tag = textField.tag;
    switch (tag) {
        case 1:{//用户名
            accountNumberTF.layer.borderColor = [ConstColor themeColor].CGColor;
            verificationCodeTF.layer.borderColor = [ConstColor dividerColor].CGColor;
            passwordTF.layer.borderColor = [ConstColor dividerColor].CGColor;
            confirmPasswordTF.layer.borderColor = [ConstColor dividerColor].CGColor;
        }
            break;
        case 2:{//验证码
            accountNumberTF.layer.borderColor = [ConstColor dividerColor].CGColor;
            verificationCodeTF.layer.borderColor = [ConstColor themeColor].CGColor;
            passwordTF.layer.borderColor = [ConstColor dividerColor].CGColor;
            confirmPasswordTF.layer.borderColor = [ConstColor dividerColor].CGColor;
        }
            break;
        case 3:{//密码
            accountNumberTF.layer.borderColor = [ConstColor dividerColor].CGColor;
            verificationCodeTF.layer.borderColor = [ConstColor dividerColor].CGColor;
            passwordTF.layer.borderColor = [ConstColor themeColor].CGColor;
            confirmPasswordTF.layer.borderColor = [ConstColor dividerColor].CGColor;
        }
            break;
        case 4:{//确认密码
            accountNumberTF.layer.borderColor = [ConstColor dividerColor].CGColor;
            verificationCodeTF.layer.borderColor = [ConstColor dividerColor].CGColor;
            passwordTF.layer.borderColor = [ConstColor dividerColor].CGColor;
            confirmPasswordTF.layer.borderColor = [ConstColor themeColor].CGColor;
        }
            break;
        default:
            break;
    }
}
#pragma mark - 个人注册点击事件
- (void)personalBtnClick
{
    taekwondoBtn.backgroundColor = RGB(233, 233, 233);
    personalBtn.backgroundColor = [UIColor whiteColor];
    lineRightLab.hidden = YES;
    lineLeftLab.hidden = NO;
    
    
    
}

#pragma mark - 道馆注册点击事件
- (void)taekwondoBtnClick
{
    personalBtn.backgroundColor = RGB(233, 233, 233);
    taekwondoBtn.backgroundColor = [UIColor whiteColor];
    lineLeftLab.hidden = YES;
    lineRightLab.hidden = NO;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - 获取验证码点击事件
- (void)verificationCodeBtnClick
{
    
}
#pragma mark - 注册或改密码
- (void)registerBtnClick
{
    if ([_isRegister isEqualToString:@"1"]) {
        //注册
        // 确认密码 和  密码一直
        if ([passwordTF.text isEqualToString:confirmPasswordTF.text]) {
            
            
        }else {
            
        }
        
    }
    else
    {
        //修改密码
    }
}
#pragma mark - 协议勾选
- (void)checkBoxBtnClick
{
    if (isForgot) {
        [checkBoxBtn setImage:[UIImage imageNamed:@"login_forgot"] forState:UIControlStateNormal];
        isForgot = NO;
    }
    else
    {
        
        [checkBoxBtn setImage:[UIImage imageNamed:@"login_noForgot"] forState:UIControlStateNormal];
        isForgot = YES;
    }
    
}
#pragma mark - 查看协议按钮点击事件
- (void)agreeBtnClick
{
    AgreementViewController *agreementVC = [[AgreementViewController alloc]init];
    [self.navigationController pushViewController:agreementVC animated:YES];
}
@end

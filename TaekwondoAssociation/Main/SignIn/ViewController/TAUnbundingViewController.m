//
//  TAUnbundingViewController.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//


//  解绑手机号   或者  绑定手机号  

#import "TAUnbundingViewController.h"
#import "ConstColor.h"
#import "NSString+Util.h"
#import "MBProgressHUD.h"
#import "TARequestManager.h"

@interface TAUnbundingViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField *numberTextField;

@property (nonatomic,strong)UITextField *VerTextField;

@property (nonatomic,strong)UITextField *passwordTextField;

@property (nonatomic,strong)UIButton *codeBtn;

@property (nonatomic,strong)UIButton *tureBtn;

@property (nonatomic,strong)UIButton *secTureBtn;
@end

@implementation TAUnbundingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"绑定手机号";
    
    [self createUI];
    
}

- (void)createUI {
    
    [self.view addSubview:self.numberTextField];
    [self.view addSubview:self.tureBtn];
    
}

- (UITextField *)numberTextField {
    
    if (_numberTextField== nil) {
        _numberTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, KTA_Screen_Width-40, 40)];
        _numberTextField.placeholder = @"请输入手机号码";
        _numberTextField.tag = 1;
        _numberTextField.delegate = self;
        [_numberTextField.layer setBorderColor:[ConstColor themeColor].CGColor];
        [_numberTextField setFont:[UIFont systemFontOfSize:15]];
        UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView.backgroundColor = [UIColor clearColor];
        _numberTextField.leftView = leftView;
        _numberTextField.leftViewMode = UITextFieldViewModeAlways;
        _numberTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_numberTextField.layer setBorderWidth:0.5];
        _numberTextField.layer.cornerRadius = 4;
        [self.view addSubview:_numberTextField];
    }
    return _numberTextField;
}

- (UITextField *)VerTextField {
    
    if (_VerTextField== nil) {
        _VerTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 160, KTA_Screen_Width-130, 40)];
        _VerTextField.placeholder = @"请输入验证码";
        _VerTextField.tag = 2;
        _VerTextField.delegate = self;
        [_VerTextField.layer setBorderColor:[ConstColor dividerColor].CGColor];
        [_VerTextField setFont:[UIFont systemFontOfSize:15]];
        UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView.backgroundColor = [UIColor clearColor];
        _VerTextField.leftView = leftView;
        _VerTextField.leftViewMode = UITextFieldViewModeAlways;
        _VerTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_VerTextField.layer setBorderWidth:0.5];
        _VerTextField.layer.cornerRadius = 4;
        [self.view addSubview:_VerTextField];
    }
    return _VerTextField;
}

- (UITextField *)passwordTextField {
    
    
    if (_passwordTextField== nil) {
        _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 220, KTA_Screen_Width-40, 40)];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.tag = 3;
        _passwordTextField.delegate = self;
        [_passwordTextField.layer setBorderColor:[ConstColor dividerColor].CGColor];
        [_passwordTextField setFont:[UIFont systemFontOfSize:15]];
        UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView.backgroundColor = [UIColor clearColor];
        _passwordTextField.leftView = leftView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_passwordTextField.layer setBorderWidth:0.5];
        _passwordTextField.layer.cornerRadius = 4;
        [self.view addSubview:_passwordTextField];
    }
    return _passwordTextField;

}

- (UIButton *)codeBtn {
    
    if (_codeBtn == nil) {
        _codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(KTA_Screen_Width-100, 160, 80, 40)];
        [_codeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_codeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _codeBtn.backgroundColor = [ConstColor themeColor];
        _codeBtn.layer.cornerRadius = 5;
        _codeBtn.clipsToBounds = YES;
        [_codeBtn addTarget:self action:@selector(codeAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _codeBtn;

}


- (UIButton *)tureBtn {
    
    if (_tureBtn == nil) {
        _tureBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 180, KTA_Screen_Width-40, 40)];
        [_tureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        [_tureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _tureBtn.backgroundColor = [ConstColor themeColor];
        _tureBtn.layer.cornerRadius = 5;
        _tureBtn.clipsToBounds = YES;
        [_tureBtn addTarget:self action:@selector(tureAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _tureBtn;
}

- (UIButton *)secTureBtn {
    
    if (_secTureBtn == nil) {
        _secTureBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 340, KTA_Screen_Width-40, 40)];
        [_secTureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        [_secTureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _secTureBtn.backgroundColor = [ConstColor themeColor];
        _secTureBtn.layer.cornerRadius = 5;
        _secTureBtn.clipsToBounds = YES;
        [_secTureBtn addTarget:self action:@selector(sectureAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _secTureBtn;
}


#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSInteger tag = textField.tag;
    switch (tag) {
        case 1:{//用户名
            _numberTextField.layer.borderColor = [ConstColor themeColor].CGColor;
            _VerTextField.layer.borderColor = [ConstColor dividerColor].CGColor;
            _passwordTextField.layer.borderColor = [ConstColor dividerColor].CGColor;
           
        }
            break;
        case 2:{//验证码
            _numberTextField.layer.borderColor = [ConstColor dividerColor].CGColor;
            _VerTextField.layer.borderColor = [ConstColor themeColor].CGColor;
            _passwordTextField.layer.borderColor = [ConstColor dividerColor].CGColor;
            
        }
            break;
        case 3:{//密码
            _numberTextField.layer.borderColor = [ConstColor dividerColor].CGColor;
            _VerTextField.layer.borderColor = [ConstColor dividerColor].CGColor;
            _passwordTextField.layer.borderColor = [ConstColor themeColor].CGColor;
        }
            break;
       
        default:
            break;
    }
}

// 发送验证码
- (void)codeAction {
    
    
    
}



- (void)tureAction {
    
    if ([_numberTextField.text isMoblePhoneNumber]) {
        // 请求网络
        [self requestNetwork];
//        [self createView];
        
    }else {
        
        MBProgressHUD *progressView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progressView.mode = MBProgressHUDModeText;
        
        progressView.mode = MBProgressHUDModeText;
        progressView.label.text  = @"您输入的手机号不正确";
        [progressView hideAnimated:YES afterDelay:1];
    }
    
}

-(void)sectureAction {
    // 确定绑定手机号 如果是新手机号 就走这里
    
}


- (void)requestNetwork {
    
    NSDictionary *dic = @{@"uuid":self.uuid,@"phone":_numberTextField.text};
    
    [TARequestManager TARequestCompletedWithPath:nil Parameters:dic sucee:^(NSDictionary *dic) {
        
        // 1.您的手机号已经绑定过
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        
        [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            //  解绑手机号   从新绑定
            [self createView];
            _passwordTextField.placeholder = @"可以通过密码绑定手机号";
            _VerTextField.placeholder = @"可以通过验证码绑定手机号";
        }];
        
        [self .navigationController pushViewController:alertVC animated:YES];
        

        
        // 2.您的手机号没有绑定过
        
        [self createView];
        
        
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)createView {
    
    [self.tureBtn removeFromSuperview];
    [self.view addSubview:self.secTureBtn];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.VerTextField];
    [self.view addSubview:self.codeBtn];

    
}

@end

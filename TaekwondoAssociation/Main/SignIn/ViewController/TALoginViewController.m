//
//  TALoginViewController.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TALoginViewController.h"
#import "UIApplication+TAAppDelegate.h"
#import "TARegistViewController.h"
#import "ConstColor.h"
#import <ShareSDK/ShareSDK.h>
#import "TARequestManager.h"


@interface TALoginViewController ()<UITextFieldDelegate>
// 登录模式是个人或者道馆,网络请求时候用到的
@property (nonatomic ,copy)NSString *loginway;

@property (nonatomic ,strong)UIButton *personBut;

@property (nonatomic ,strong)UIButton *teakwonBut;

@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic ,strong)UITextField *accuntTextFiled;

@property (nonatomic ,strong)UITextField *passTextFiled;

@property (nonatomic ,strong)UIButton *loginBut;
@property (nonatomic,strong)UIButton *touristLoginBtn;//游客登录按钮
@property (nonatomic,strong)UIButton *forgotPasswordBtn;//忘记密码按钮
@property (nonatomic,strong)UILabel *thirdPartyLabel;//第三方登录label
@property (nonatomic,strong)UIButton *qqBtn;//qq登录按钮
@property (nonatomic,strong)UIButton *chatBtn;//微信登录按钮
@property (nonatomic,strong)UIButton *sinaBtn;//新浪微博登录按钮
@property (nonatomic,strong)UIView *thirdPartyView;//第三方登录按钮大的view
@end

@implementation TALoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:(UIBarButtonItemStyleDone) target:self action:@selector(itemAction)];

    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.title  = @"登录";
    
    [self createUI];
}
//  注册
- (void)itemAction {
    
    TARegistViewController *registVC = [[TARegistViewController alloc]init];
    registVC.title = @"注册";
    registVC.isRegister = @"1";
    [self.navigationController pushViewController:registVC animated:YES];
    
}
#pragma mark - 初始化UI
- (void)createUI {
    
//    [self.view addSubview:self.personBut];
//    [self.view addSubview:self.teakwonBut];
//    [self.view addSubview:self.lineView];
    [self.view addSubview:self.accuntTextFiled];
    [self.view addSubview:self.passTextFiled];
    [self.view addSubview:self.loginBut];
    [self.view addSubview:self.touristLoginBtn];//游客登录
    [self.view addSubview:self.forgotPasswordBtn];//忘记密码按钮
    [self.view addSubview:self.thirdPartyLabel];//第三方登录label
    [self.view addSubview:self.thirdPartyView];//第三方登录大的view
}

- (UIView *)lineView {
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 103, KTA_Screen_Width/2.0, 1.5)];
        _lineView.backgroundColor = [ConstColor themeColor];
    }
    
    return _lineView;
}

- (UIButton *)personBut {
    
    if (_personBut == nil) {
        _personBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 64,KTA_Screen_Width/2.0 , 40)];
        _personBut.backgroundColor = [UIColor whiteColor];
        [_personBut setTitle:@"个人" forState:(UIControlStateNormal)];
        [_personBut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _personBut.selected = NO;
        [_personBut addTarget:self action:@selector(personButAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _personBut;
}

- (UIButton *)teakwonBut {
    
    if (_teakwonBut == nil) {
        _teakwonBut = [[UIButton alloc]initWithFrame:CGRectMake(KTA_Screen_Width/2.0, 64, KTA_Screen_Width/2.0, 40)];
        [_teakwonBut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_teakwonBut setTitle:@"道馆" forState:(UIControlStateNormal)];
        _teakwonBut.backgroundColor = [ConstColor dividerColor];
        _teakwonBut.selected = YES;
        [_teakwonBut addTarget:self action:@selector(terwonButAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _teakwonBut;
}

- (UITextField *)accuntTextFiled {
    
    if (_accuntTextFiled == nil) {
        _accuntTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, 114, KTA_Screen_Width-40, 40)];
        _accuntTextFiled.placeholder = @"请输入手机号码／会员号／邮箱";
        _accuntTextFiled.delegate = self;
        _accuntTextFiled.tag = 1;
        _accuntTextFiled.leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 7, 26)];
//        _accuntTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _accuntTextFiled.layer.borderWidth = 1.0;
        _accuntTextFiled.layer.borderColor = [ConstColor themeColor].CGColor;
        _accuntTextFiled.clipsToBounds = YES;
        _accuntTextFiled.layer.cornerRadius = 4;
        _accuntTextFiled.leftViewMode = UITextFieldViewModeAlways;

        
    }
    
    return _accuntTextFiled;
}

- (UITextField *)passTextFiled {
    
    if (_passTextFiled == nil) {
        _passTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, 174, KTA_Screen_Width-40, 40)];
        _passTextFiled.placeholder = @"请输入密码";
        _passTextFiled.delegate = self;
        _passTextFiled.tag = 2;
        _passTextFiled.leftViewMode = UITextFieldViewModeAlways;
        _passTextFiled.layer.borderWidth = 1.0;
        _passTextFiled.layer.borderColor = [ConstColor dividerColor].CGColor;
        _passTextFiled.clipsToBounds = YES;
        _passTextFiled.leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 7, 26)];
        _passTextFiled.layer.cornerRadius = 5;
    }
    
    return _passTextFiled;
}

- (UIButton *)loginBut {
    
    if (_loginBut == nil) {
        _loginBut = [[UIButton alloc]initWithFrame:CGRectMake(20, 254, KTA_Screen_Width-40, 40)];
        [_loginBut setTitle:@"登录" forState:(UIControlStateNormal)];
        [_loginBut setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _loginBut.backgroundColor = [ConstColor themeColor];
        _loginBut.layer.cornerRadius = 5;
        _loginBut.clipsToBounds = YES;
        [_loginBut addTarget:self action:@selector(LoginbutAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginBut;
}
//游客登录按钮
- (UIButton *)touristLoginBtn
{
    if (_touristLoginBtn == nil) {
        _touristLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _touristLoginBtn.frame = CGRectMake(20, _loginBut.frame.origin.y + _loginBut.frame.size.height + 20, 120, 30);
        [_touristLoginBtn setTitle:@"暂不注册，游客登录" forState:UIControlStateNormal];
        _touristLoginBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_touristLoginBtn setTitleColor:[ConstColor themeColor] forState:UIControlStateNormal];
        [_touristLoginBtn addTarget:self action:@selector(touristLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _touristLoginBtn;
}
//忘记密码按钮
- (UIButton *)forgotPasswordBtn
{
    if (_forgotPasswordBtn == nil) {
        _forgotPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgotPasswordBtn.frame = CGRectMake(KTA_Screen_Width - 90, _touristLoginBtn.frame.origin.y, 70, 30);
        [_forgotPasswordBtn setTitleColor:RGB(135, 135, 135) forState:UIControlStateNormal];
        [_forgotPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _forgotPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_forgotPasswordBtn addTarget:self action:@selector(forgotPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgotPasswordBtn;
}
//第三方登录label
- (UILabel *)thirdPartyLabel
{
    if (_thirdPartyLabel == nil) {
        _thirdPartyLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, _touristLoginBtn.frame.origin.y + _touristLoginBtn.frame.size.height + 50, KTA_Screen_Width - 200, 40)];
        _thirdPartyLabel.text = @"第三方快速登录";
        _thirdPartyLabel.textColor = RGB(104, 104, 104);
        _thirdPartyLabel.font = [UIFont systemFontOfSize:15];
        _thirdPartyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _thirdPartyLabel;
}
//第三方登录大的view
- (UIView *)thirdPartyView
{
    if (_thirdPartyView == nil) {
        _thirdPartyView = [[UIView alloc]initWithFrame:CGRectMake((KTA_Screen_Width - 230)/2, _thirdPartyLabel.frame.origin.y + _thirdPartyLabel.frame.size.height + 10, 230, 80)];
//        _thirdPartyView.backgroundColor = [UIColor redColor];
        [_thirdPartyView addSubview:self.qqBtn];
        [_thirdPartyView addSubview:self.chatBtn];
        [_thirdPartyView addSubview:self.sinaBtn];
    }
    return _thirdPartyView;
}
//qq登录按钮
- (UIButton *)qqBtn
{
    if (_qqBtn == nil) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _qqBtn.frame = CGRectMake(0, 0, 70, 80);
//        _qqBtn.backgroundColor = [UIColor yellowColor];
        [_qqBtn addTarget:self action:@selector(qqBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *qqImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 60, 60)];
//        qqImageView.backgroundColor = [UIColor greenColor];
        qqImageView.image = [UIImage imageNamed:@"login_QQ"];
        [_qqBtn addSubview:qqImageView];
        UILabel *qqLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 70, 20)];
        qqLabel.text = @"QQ登录";
        qqLabel.font = [UIFont systemFontOfSize:13];
        qqLabel.textColor = RGB(104, 104, 104);
        qqLabel.textAlignment = NSTextAlignmentCenter;
        [_qqBtn addSubview:qqLabel];
    }
    return _qqBtn;
}
//微信登录按钮
- (UIButton *)chatBtn
{
    if (_chatBtn == nil) {
        _chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chatBtn.frame = CGRectMake(80, 0, 70, 80);
//        _chatBtn.backgroundColor = [UIColor yellowColor];
        [_chatBtn addTarget:self action:@selector(chatBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *chatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 60, 60)];
//        chatImageView.backgroundColor = [UIColor greenColor];
        chatImageView.image = [UIImage imageNamed:@"login_chat"];
        [_chatBtn addSubview:chatImageView];
        UILabel *chatLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 70, 20)];
        chatLabel.text = @"微信登录";
        chatLabel.font = [UIFont systemFontOfSize:13];
        chatLabel.textColor = RGB(104, 104, 104);
        chatLabel.textAlignment = NSTextAlignmentCenter;
        [_chatBtn addSubview:chatLabel];
    }
    return _chatBtn;
}
//新浪登录按钮
- (UIButton *)sinaBtn
{
    if (_sinaBtn == nil) {
        _sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sinaBtn.frame = CGRectMake(160, 0, 70, 80);
//        _sinaBtn.backgroundColor = [UIColor yellowColor];
        [_sinaBtn addTarget:self action:@selector(sinaBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *sinaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 60, 60)];
//        sinaImageView.backgroundColor = [UIColor greenColor];
        sinaImageView.image = [UIImage imageNamed:@"login_sina"];
        [_sinaBtn addSubview:sinaImageView];
        UILabel *sinaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 70, 20)];
        sinaLabel.text = @"新浪微博";
        sinaLabel.font = [UIFont systemFontOfSize:13];
        sinaLabel.textColor = RGB(104, 104, 104);
        sinaLabel.textAlignment = NSTextAlignmentCenter;
        [_sinaBtn addSubview:sinaLabel];
    }
    return _sinaBtn;
}
#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSInteger tag = textField.tag;
    switch (tag) {
        case 1:{//用户名
            _accuntTextFiled.layer.borderColor = [ConstColor themeColor].CGColor;
            _passTextFiled.layer.borderColor = [ConstColor dividerColor].CGColor;
        }
            break;
        case 2:{//密码
            _passTextFiled.layer.borderColor = [ConstColor themeColor].CGColor;
            _accuntTextFiled.layer.borderColor = [ConstColor dividerColor].CGColor;
        }
            break;
        default:
            break;
    }
}

#pragma mark  个人点击事件
- (void)personButAction {
    
    if (_personBut.isSelected) {
        
         _personBut.selected = !_personBut.selected;
         _teakwonBut.selected = !_teakwonBut.selected;
        
        _personBut.backgroundColor = [UIColor whiteColor];
        _teakwonBut.backgroundColor = [ConstColor dividerColor];
        _lineView.frame = CGRectMake(0, 103, KTA_Screen_Width/2.0, 1.5);
  // 1 代表是个人  2 代表是道馆
        self.loginway = @"1";
        
    }else {
         _personBut.selected = !_personBut.selected;
         _teakwonBut.selected = !_teakwonBut.selected;
         _personBut.backgroundColor = [ConstColor dividerColor];
         _teakwonBut.backgroundColor = [UIColor whiteColor];
        _lineView.frame = CGRectMake(KTA_Screen_Width/2.0, 103, KTA_Screen_Width/2.0, 1.5);
       self.loginway = @"2";

        
    }
}
#pragma mark  道馆点击事件
- (void)terwonButAction {
    
    if (_teakwonBut.isSelected) {
    
        _personBut.selected = !_personBut.selected;
        _teakwonBut.selected = !_teakwonBut.selected;
        _personBut.backgroundColor = [ConstColor dividerColor];
        _teakwonBut.backgroundColor = [UIColor whiteColor];
        _lineView.frame = CGRectMake(KTA_Screen_Width/2.0, 103, KTA_Screen_Width/2.0, 1.5);
        
        self.loginway = @"2";
    }else {
        _personBut.selected = !_personBut.selected;
        _teakwonBut.selected = !_teakwonBut.selected;
        
        _personBut.backgroundColor = [UIColor whiteColor];
        _teakwonBut.backgroundColor = [ConstColor dividerColor];
        _lineView.frame = CGRectMake(0, 103, KTA_Screen_Width/2.0, 1.5);

        self.loginway = @"1";
    }
    
}
#pragma mark  登录按钮
- (void)LoginbutAction {
    
//    if (self.accuntTextFiled.text.length <1 ) {
//        return;
//    }else if(self.passTextFiled.text.length <1) {
//        return;
//    }else {
//        
//        
//        [self loadData];
//    }
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setValue:_accuntTextFiled.text forKey:@"NickName"];
    [params setValue:_passTextFiled.text forKey:@"Pwd"];
    [params setValue:[NSNumber numberWithInteger:1] forKey:@"UserType"];
    [TARequestManager TARequestCompletedWithPath:@"/SignIn/SignIn" Parameters:nil sucee:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //  进入主程序
//    [[UIApplication sharedAppDelegate] goToHome];
    
}
#pragma mark - 游客登录点击事件
- (void)touristLoginBtnClick
{
    
}
#pragma mark - 忘记密码点击事件
- (void)forgotPasswordBtnClick
{
    TARegistViewController *registVC = [[TARegistViewController alloc]init];
    registVC.title = @"忘记密码";
    registVC.isRegister = @"2";
    [self.navigationController pushViewController:registVC animated:YES];
}
#pragma mark - qq登录点击事件
- (void)qqBtnClick
{
    
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             
             [[UIApplication sharedAppDelegate] goToHome];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
    
    
    
}
#pragma mark - 微信登录点击事件
- (void)chatBtnClick
{
    [ ShareSDK getUserInfo : SSDKPlatformTypeWechat
     
            onStateChanged :^( SSDKResponseState state, SSDKUser *user, NSError *error)
     
     {
         
         if (state == SSDKResponseStateSuccess )
             
         {
             
             NSLog ( @"uid=%@" ,user. uid );
             
             NSLog ( @"%@" ,user. credential );
             
             NSLog ( @"token=%@" ,user. credential . token );
             
             NSLog ( @"nickname=%@" ,user. nickname );
             
             [[UIApplication sharedAppDelegate] goToHome];
             
         }
         
         else
             
         {
             
             NSLog ( @"%@" ,error);
             
         }
         
     }];
}
#pragma mark - 新浪登录点击事件
- (void)sinaBtnClick
{
    
    [ ShareSDK getUserInfo : SSDKPlatformTypeSinaWeibo
     
            onStateChanged :^( SSDKResponseState state, SSDKUser *user, NSError *error)
     
     {
         
         if (state == SSDKResponseStateSuccess )
             
         {
             
             NSLog ( @"uid=%@" ,user. uid );
             
             NSLog ( @"%@" ,user. credential );
             
             NSLog ( @"token=%@" ,user. credential . token );
             
             NSLog ( @"nickname=%@" ,user. nickname );
             [[UIApplication sharedAppDelegate] goToHome];
             
         }
         
         else
             
         {
             
             NSLog ( @"%@" ,error);
             
         }
         
     }];
    
    
    
}

// 加载数据
- (void)loadData {
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];

    
}

@end

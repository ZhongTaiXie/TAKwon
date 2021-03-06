//
//  TAEditMemberInfoViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAEditMemberInfoViewController.h"
#import "TACustomTextField.h"

@interface TAEditMemberInfoViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) TACustomTextField *textField;

@end

@implementation TAEditMemberInfoViewController

-(instancetype)initWithNavTitle:(NSString *)navTitle text:(NSString *)text index:(NSInteger)index{
    if (self = [super init]) {
        _navTitle = navTitle;
        _text = text;
        _index = index;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupTextField];
}

-(void)setNav{
    self.view.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //设置导航栏标题及属性
    self.navigationItem.title = self.navTitle;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(ok)];
    self.navigationItem.rightBarButtonItem = okItem;
}
-(void)setupTextField{
    self.textField = [[TACustomTextField alloc] initWithFrame:CGRectMake(0, 10, KTA_Screen_Width, 40)];
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.text = self.text;
    self.textField.backgroundColor = [UIColor whiteColor];
    if (self.index == 2) {  //身份证是1手机号是2
        //设置键盘样式
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    self.textField.delegate = self;
    self.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.navTitle];
    [self.view addSubview:self.textField];
}

-(void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ok{
    if(self.index == 1){  //身份证
        if ([WQTools isValidateIDNumber:self.textField.text]) {
            //是正确的身份证格式
            NSLog(@"是正确的身份证格式");
        }else{
            NSLog(@"bu是正确的身份证格式");
        }
    }else if (self.index == 2){   //手机号
        if ([WQTools isValidateMobile:self.textField.text]) {
            //是正确的手机号格式
            NSLog(@"是正确的手机号格式");
        }else{
            NSLog(@"bu是正确的手机号格式");
        }
    }else if(self.index == 3){  //邮箱
        if ([WQTools isValidateEmail:self.textField.text]) {
            //是正确的邮箱格式
            NSLog(@"是正确的邮箱格式");
        }else{
            NSLog(@"bu是正确的邮箱格式");
        }
    }
}

//如果输入超过规定的字数11，就不再让输入
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.index == 2) {//输入手机号
        if (range.location >= 11){
            return NO;
        }else{
            return YES;
        }
    }else if (self.index == 1){  // 身份证号
        if (range.location >= 19){
            return NO;
        }
        
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890X"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            return NO;
        }else{
            return YES;
        }
    } else{
        return YES;
    }
}
@end

//
//  TAAboutUsViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/4.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAAboutUsViewController.h"

@interface TAAboutUsViewController ()

@end

@implementation TAAboutUsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self loadWebUrl:@"https://www.baidu.com/"];
}

-(void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"关于我们";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

//
//  TABaseViewController.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TABaseViewController.h"
#import "ConstColor.h"

@interface TABaseViewController ()

@end

@implementation TABaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [ConstColor themeColor];
    
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    
    
    // Do any additional setup after loading the view.
}



// 设置返回类型
- (void)backAction {
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// 2级界面隐藏tabbar
- (BOOL)hidesBottomBarWhenPushed {
    
    if (self.navigationController.viewControllers.count>1) {
        return YES;
    }
    return NO;
}


@end

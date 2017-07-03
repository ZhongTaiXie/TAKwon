//
//  CertificationViewController.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "CertificationViewController.h"

@interface CertificationViewController ()

@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"认证查询";
    
    [self loadWebUrl:@"http://p5xxdn.natappfree.cc/h5/attestation/attestation.html"];
    
    // 扫一扫按钮
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"saoyisao_white"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0,40, 40);
//    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [btn addTarget:self action:@selector(saoyisaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)saoyisaoBtnClick:(UIButton*)btn
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

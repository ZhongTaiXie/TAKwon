//
//  PublicNoticeViewController.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "PublicNoticeViewController.h"

@interface PublicNoticeViewController ()

@end

@implementation PublicNoticeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"公告";
    
    [self loadWebUrl:@"http://p5xxdn.natappfree.cc/h5/training/training_list.html"];
    
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

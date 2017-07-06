//
//  PublicWelfareViewController.m
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/6/27.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "PublicWelfareViewController.h"

@interface PublicWelfareViewController ()

@end

@implementation PublicWelfareViewController
#pragma mark - lifeClicle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"公益";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebUrl:@"http://p5xxdn.natappfree.cc/h5/charity/charity_list.html"];
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

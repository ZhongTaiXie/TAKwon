//
//  TAZhiYeRenZhengViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAZhiYeRenZhengViewController.h"

@interface TAZhiYeRenZhengViewController ()

@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation TAZhiYeRenZhengViewController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@[@"教练员",@"初级",@"中级",@"高级"],@[@"培训师",@"助理",@"普通",@"高级"],@[@"裁判员",@"市级",@"省级",@"国家级",@"国际级"],@[@"考试官",@"晋级",@"晋段"]];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"职业认证";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = self.titleArray[section];
    return sectionArray.count - 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *sectionArray = self.titleArray[indexPath.section];
    cell.textLabel.text = sectionArray[indexPath.row + 1];
    cell.textLabel.textColor = [WQTools colorWithHexString:@"666666"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *sectionArray = self.titleArray[section];
    return sectionArray[0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

@end

//
//  TASeetingViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/28.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TASeetingViewController.h"
#import "TAReciveMessageCell.h"
#import "TAFeedbackViewController.h"
#import "TAYinsiShengmingViewController.h"
#import "TAAboutUsViewController.h"

@interface TASeetingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation TASeetingViewController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"",@"修改密码",@"隐私声明",@"意见反馈",@"关于我们",@"版本更新"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupNav];
}

-(void)loadView{
    [super loadView];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"设置";
   
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height + 30)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAReciveMessageCell" bundle:nil] forCellReuseIdentifier:@"reciveMsgCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}


#pragma mark - 与服务器交互
-(void)logOut{
    NSLog(@"退出登录");
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TAReciveMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reciveMsgCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[TAReciveMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reciveMsgCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.textLabel.textColor = [WQTools colorWithHexString:@"333333"];
        cell.textLabel.text = self.titleArray[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 2){
        TAYinsiShengmingViewController *yinsiVC = [TAYinsiShengmingViewController new];
        [self.navigationController pushViewController:yinsiVC animated:YES];
    }else if (indexPath.row == 3) {
        TAFeedbackViewController *feedVC = [TAFeedbackViewController new];
        [self.navigationController pushViewController:feedVC animated:YES];
    }else if (indexPath.row == 4){
        TAAboutUsViewController *usVC = [TAAboutUsViewController new];
        [self.navigationController pushViewController:usVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgview = [WQFactoryUI createViewWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 80) viewBackgroundColor:[WQTools colorWithHexString:@"f1f1f1"]];
    UIButton *logOutBtn = [WQFactoryUI createButtonWithTitleFont:18 buttonBackgroundColor:[UIColor redColor] titleColor:WHITECOLOR buttonFrame:CGRectMake(15, 50, KTA_Screen_Width - 30, 40) text:@"退出登录" cornerRadius:5];
    [logOutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:logOutBtn];
    return bgview;
}

@end

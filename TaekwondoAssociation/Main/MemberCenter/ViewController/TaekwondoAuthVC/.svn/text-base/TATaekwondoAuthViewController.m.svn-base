//
//  TATaekwondoAuthViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/28.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TATaekwondoAuthViewController.h"
#import "TATaekwondoAuthCell.h"
#import "TAuploadPicView.h"

@interface TATaekwondoAuthViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITextField *memberNumTextfield;//会员编号输入框
@property (nonatomic,strong) UITextField *validateCodeTextfield;//验证码输入框
@property (nonatomic,strong) NSArray *IDCardImageArray;
@property (nonatomic,strong) NSArray *zhizhaoImageArray;

@end

@implementation TATaekwondoAuthViewController

-(NSArray *)IDCardImageArray{
    if (!_IDCardImageArray) {
        _IDCardImageArray = [NSArray array];
    }
    return _IDCardImageArray;
}

-(NSArray *)zhizhaoImageArray{
    if (!_zhizhaoImageArray) {
        _zhizhaoImageArray = [NSArray array];
    }
    return _zhizhaoImageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
}
-(void)loadView{
    [super loadView];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)setupNav{
    self.view.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];;
    self.navigationItem.title = @"道馆认证";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, KTA_Screen_Width, KTA_Screen_Height + 30)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[TATaekwondoAuthCell class] forCellReuseIdentifier:@"authCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}

#pragma mark - 与服务器交互
-(void)submitAuth{
    NSLog(@"提交认证");
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        TATaekwondoAuthCell *cell = [[TATaekwondoAuthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"authCell" title:@"团体会员编号" placeholder:@"请输入团体会员编号"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.memberNumTextfield = cell.textField;
        return cell;
    }else if (indexPath.row == 1) {
        TATaekwondoAuthCell *cell = [[TATaekwondoAuthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"authCell" title:@"验证码" placeholder:@"请输入验证码"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.validateCodeTextfield = cell.textField;
        return cell;
    }else if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        TAuploadPicView *uploadView = [[TAuploadPicView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 100) title:@"上传身份证反正面" imageArray:self.IDCardImageArray];
        
        uploadView.addPicBtnClick = ^(NSString *str){
            NSLog(@"add");
        };
        
        [cell.contentView addSubview:uploadView];
        return cell;
    } else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TAuploadPicView *uploadView = [[TAuploadPicView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 100) title:@"上传营业执照" imageArray:self.zhizhaoImageArray];
        [cell.contentView addSubview:uploadView];
        uploadView.addPicBtnClick = ^(NSString *str){
            NSLog(@"addadd");
        };
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 || indexPath.row == 1){
        return 45;
    }
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgview = [WQFactoryUI createViewWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 80) viewBackgroundColor:[WQTools colorWithHexString:@"f1f1f1"]];
    UIButton *submitAuthBtn = [WQFactoryUI createButtonWithTitleFont:18 buttonBackgroundColor:MAINCOLOR titleColor:WHITECOLOR buttonFrame:CGRectMake(15, 50, KTA_Screen_Width - 30, 40) text:@"提交认证" cornerRadius:5];
    [submitAuthBtn addTarget:self action:@selector(submitAuth) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:submitAuthBtn];
    return bgview;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end

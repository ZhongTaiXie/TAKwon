//
//  TAHomePageViewController.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAHomePageViewController.h"
#import "TABaseTableView.h"
#import "TARequestManager.h"
#import "AutoScrollView.h"
#import "TAPersonalHeaderView.h"
#import "HotGalleryTableViewCell.h"
#import "MingRenTangTableViewCell.h"
#import "NewsListViewController.h"

static NSString *identifier = @"CellID";

@interface TAHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArray;//中部功能名称数组
    AutoScrollView *autoScrollView;//顶部轮播图
}
@property (nonatomic ,strong)TABaseTableView *tableView;
//@property (nonatomic ,strong)NSMutableArray *dataSource;

@end

//zhushi
@implementation TAHomePageViewController
#pragma mark - lifeCircle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    titleArray = [NSArray arrayWithObjects:@"认证",@"中国跆协",@"新闻",@"公告",@"赛事",@"培训",@"公益",@"排名",@"名人堂",@"教学",@"国家队",@"跆拳百科", nil];
//    self.dataSource = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated {
    
//    NSDictionary *dic = @{@"token":@"DYSkOX@YN10!"};
    
    [TARequestManager TARequestCompletedWithPath:URL_HOME Parameters:nil sucee:^(NSDictionary *dic) {
        // 解析数据
        NSLog(@"----------%@",dic);
        
    } fail:^(NSError *error) {
        
    }];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (TABaseTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[TABaseTableView alloc]initWithFrame:CGRectMake(0, -20, KTA_Screen_Width, KTA_Screen_Height) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *bigView = [self topView];
        _tableView.tableHeaderView = bigView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        
        TAWeakSelf(weakSelf)
        
        
        [_tableView refreshHeaderRefresh:^{
            [weakSelf loadData];
        } withFooterRefreshingBlock:^{
            [weakSelf loadData];
        }];
        
    }
    
    return _tableView;
    
}
#pragma mark - 顶部轮播和功能按钮
-(UIView *)topView
{
    UIView *bigview = [[UIView alloc]init];
    
//    bigview.backgroundColor = [UIColor yellowColor];
    //顶部轮播图
    [self lunBoScrollView:bigview];
    //中部功能图
    UIScrollView *myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, autoScrollView.frame.size.height, KTA_Screen_Width, (KTA_Screen_Width/4)*2)];
    myScrollView.delegate = self;
    // 设置内容大小
    myScrollView.contentSize = CGSizeMake((KTA_Screen_Width/4)*6, 100);
    //    myScrollView.backgroundColor = [UIColor greenColor];
    [bigview addSubview:myScrollView];
    for (int i=0; i<12; i++) {
        //12个按钮
        UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i<6) {
            upBtn.frame = CGRectMake(i*(KTA_Screen_Width/4), 0, KTA_Screen_Width/4, KTA_Screen_Width/4);
        }
        else
        {
            upBtn.frame = CGRectMake((i-6)*(KTA_Screen_Width/4), KTA_Screen_Width/4, KTA_Screen_Width/4, KTA_Screen_Width/4);
        }
        upBtn.tag = i;
        [upBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //12个图片
        UIImageView *topImageView = [[UIImageView alloc]init];
        topImageView.frame = CGRectMake(((upBtn.frame.size.width)-30)/2, 20, 30, 30);
        topImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"home_more_%d",i]];
        [upBtn addSubview:topImageView];
        
        
        //12个label
        UILabel *textLab = [[UILabel alloc]init];
        textLab.frame = CGRectMake(0, 60, KTA_Screen_Width/4, 20);
        textLab.font = [UIFont systemFontOfSize:12];
        textLab.text = titleArray[i];
        textLab.textAlignment = NSTextAlignmentCenter;
        textLab.textColor = RGB(145, 145, 145);
        [upBtn addSubview:textLab];
        [myScrollView addSubview:upBtn];
        
    }
    bigview.frame = CGRectMake(0, 0, KTA_Screen_Width, autoScrollView.frame.size.height + myScrollView.frame.size.height);
    return bigview;
}
//顶部轮播
- (void)lunBoScrollView:(UIView *)view
{
    NSArray *array = @[[UIImage imageNamed:@"header_bg"],
                       [UIImage imageNamed:@"header_bg"],
                       [UIImage imageNamed:@"header_bg"],
                       [UIImage imageNamed:@"header_bg"],
                       [UIImage imageNamed:@"header_bg"]];
    
    autoScrollView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Width/16 * 9) imageArray:array];
    [view addSubview:autoScrollView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KTA_Screen_Width, 40)];
//    topView.backgroundColor = [UIColor greenColor];
    [autoScrollView addSubview:topView];
    //消息按钮
    UIButton *massageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    massageBtn.frame = CGRectMake(10, 5, 30, 30);
    [massageBtn setImage:[UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
    [massageBtn addTarget:self action:@selector(massageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:massageBtn];
    //搜索框
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(60, 5, KTA_Screen_Width-120, 30);
    [searchBtn setImage:[UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.backgroundColor = [UIColor whiteColor];
    [topView addSubview:searchBtn];
    //扫一扫
    UIButton *scanningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanningBtn.frame = CGRectMake(KTA_Screen_Width-40, 5, 30, 30);
    [scanningBtn setImage:[UIImage imageNamed:@"home_saoYiSao"] forState:UIControlStateNormal];
    [scanningBtn addTarget:self action:@selector(scanningBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:scanningBtn];
}
#pragma mark - UITableViewDelegateDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HotGalleryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifer1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HotGalleryTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        cell.myImageviewOne.backgroundColor = [UIColor greenColor];
        return cell;
    }
    else
    {
        MingRenTangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifer2"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MingRenTangTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        cell.myImageView.backgroundColor = [UIColor redColor];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 104;
    }
    else
    {
        return 123;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
- (void)loadData {
    
//    [self.dataSource removeAllObjects];
    
//    for (int i = 0 ; i <self.tableView.page*5; i ++) {
//        NSString *str  = [NSString stringWithFormat:@"%d",i+1];
//        [self.dataSource addObject:str];
//    }
//    
//    [self.tableView endReload];
    
}
#pragma mark - 消息按钮点击事件
- (void)massageBtnClick
{
    
}
#pragma mark - 搜索点击事件
- (void)searchBtnClick
{
    
}
#pragma mark - 扫一扫按钮点击事件
- (void)scanningBtnBtnClick
{
    
}
- (void)menuBtnClick:(id)sender
{
    NSInteger tag = [sender tag];
    if (tag == 0) {//认证
        
    }
    else if(tag == 1)//中国跆协
    {
        
    }
    else if(tag == 2)//新闻
    {
        NewsListViewController *newListVC = [[NewsListViewController alloc]init];
        [self.navigationController pushViewController:newListVC animated:YES];
    }
    else if(tag == 3)//公告
    {
        
    }
    else if(tag == 4)//赛事
    {
        
    }
    else if(tag == 5)//培训
    {
        
    }
    else if(tag == 6)//公益
    {
        
    }
    else if(tag == 7)//排名
    {
        
    }
    else if(tag == 8)//名人堂
    {
        
    }
    else if(tag == 9)//教学
    {
        
    }
    else if(tag == 10)//国家队
    {
        
    }
    else//跆拳百科
    {
        
    }
}
@end

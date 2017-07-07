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
#import "SDCycleScrollView.h"
#import "TAPersonalHeaderView.h"
#import "HotGalleryTableViewCell.h"
#import "MingRenTangTableViewCell.h"
#import "NewsListViewController.h"
#import "UIImageView+WebCache.h"
#import "CertificationViewController.h"
#import "TANotsViewController.h"
#import "TASearchViewController.h"//搜索页面
#import "PublicNoticeViewController.h"
#import "MatchViewController.h"
#import "HomeLoBoWebViewController.h"//轮播图点击页面
#import "LBXScanViewController.h"//扫一扫
#import "LBXScanNative.h"
#import "MingRenTangWebViewController.h"//名人堂
#import "HotPicturesViewController.h"
#import "PublicWelfareViewController.h"
#import "MingRenTangDetailViewController.h"
#import "LCProgressHUD.h"
#import "TrainningViewController.h"//培训
#import "TLCityPickerController.h"//地区选择
//#import "XRCarouselView.h"

static NSString *identifier = @"CellID";

@interface TAHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,TLCityPickerDelegate>
{
    NSArray *titleArray;//中部功能名称数组
    SDCycleScrollView *autoScrollView;//顶部轮播图
    NSMutableDictionary *dataDic;//数据字典
}
@property (nonatomic ,strong)TABaseTableView *tableView;
//@property (nonatomic,strong)XRCarouselView *autoScrollView;
@end

@implementation TAHomePageViewController
#pragma mark - lifeCircle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    titleArray = [NSArray arrayWithObjects:@"认证",@"中国跆协",@"新闻",@"公告",@"赛事",@"培训",@"公益",@"排名",@"名人堂",@"教学",@"国家队",@"跆拳百科", nil];
    [self.view addSubview:self.tableView];
    
    [self searchView];
    [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    [TARequestManager TARequestCompletedWithPath:URL_HOME Parameters:nil sucee:^(NSDictionary *dic) {
        // 解析数据
//        NSLog(@"----------%@",dic);
        [MBProgressHUD hideHUDForView:_tableView animated:YES];
        dataDic = [dic[@"Data"][@"Data"] mutableCopy];
        UIView *bigView = [self topView];
        _tableView.tableHeaderView = bigView;
        
        [_tableView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:_tableView animated:YES];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    
//    NSDictionary *dic = @{@"token":@"DYSkOX@YN10!"};

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

    
}

- (void)searchView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KTA_Screen_Width, 40)];
    [self.view addSubview:topView];
    //消息按钮
    UIButton *massageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    massageBtn.frame = CGRectMake(10, 5, 35, 30);
    [massageBtn setImage:[UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
    [massageBtn addTarget:self action:@selector(massageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:massageBtn];
    //搜索框
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    searchBtn.backgroundColor = [UIColor redColor];
    searchBtn.frame = CGRectMake(50, 2.5, KTA_Screen_Width-100, 35);
    [searchBtn setImage:[UIImage imageNamed:@"home_bigSearch"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    searchBtn.backgroundColor = [UIColor whiteColor];
    [topView addSubview:searchBtn];
    //扫一扫
    UIButton *scanningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanningBtn.frame = CGRectMake(KTA_Screen_Width-45, 2.5, 35, 35);
    [scanningBtn setImage:[UIImage imageNamed:@"home_saoYiSao"] forState:UIControlStateNormal];
    [scanningBtn addTarget:self action:@selector(scanningBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:scanningBtn];
}
- (TABaseTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[TABaseTableView alloc]initWithFrame:CGRectMake(0, -20, KTA_Screen_Width, KTA_Screen_Height) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
        
        UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 300)];
        _tableView.tableHeaderView = bigView;

        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        
//        TAWeakSelf(weakSelf)
        
        
//        [_tableView refreshHeaderRefresh:^{
//            [weakSelf loadData];
//        } withFooterRefreshingBlock:^{
//            [weakSelf loadData];
//        }];
        
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
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dataDic[@"Banner"]) {
        [imageArr addObject:[NSString stringWithFormat:@"%@%@",URL_BASE,dic[@"imageUrl"]]];
    }
    // 网络加载 --- 创建不带标题的图片轮播器
    autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Width/16 * 9) imageURLStringsGroup:imageArr];
    autoScrollView.delegate = self;
    autoScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    autoScrollView.titlesGroup = self.titleArray;
    autoScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    autoScrollView.dotColor = RGB(71, 117, 196);
    autoScrollView.autoScrollTimeInterval = 6.0;
//    self.tableview.tableHeaderView = cycleScrollView;
    [view addSubview:autoScrollView];
    
    
}
#pragma mark 图片轮播 delegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSArray *picArr = dataDic[@"Banner"];
    
    HomeLoBoWebViewController *loboVC = [[HomeLoBoWebViewController alloc]init];
    loboVC.urlStr = picArr[index][@"toUrl"];
    [self.navigationController pushViewController:loboVC animated:YES];
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
        //热门图库
        NSString *imageOneStr = [NSString stringWithFormat:@"%@%@",URL_BASE,dataDic[@"HotPic"][0][@"pic"]];
        [cell.myImageviewOne  sd_setImageWithURL:[NSURL URLWithString:imageOneStr] placeholderImage:[UIImage imageNamed:@""]];
        NSString *imageTwoStr = [NSString stringWithFormat:@"%@%@",URL_BASE,dataDic[@"HotPic"][1][@"pic"]];
        [cell.myImageviewTwo  sd_setImageWithURL:[NSURL URLWithString:imageTwoStr] placeholderImage:[UIImage imageNamed:@""]];
        NSString *imageThreeStr = [NSString stringWithFormat:@"%@%@",URL_BASE,dataDic[@"HotPic"][2][@"pic"]];
        [cell.myImageviewThree  sd_setImageWithURL:[NSURL URLWithString:imageThreeStr] placeholderImage:[UIImage imageNamed:@""]];
        cell.myImageviewOne.frame = CGRectMake((KTA_Screen_Width-308)/2, 46, 100, 60);
        cell.myImageviewTwo.frame = CGRectMake((KTA_Screen_Width-308)/2+104, 46, 100, 60);
        cell.myImageviewThree.frame = CGRectMake((KTA_Screen_Width-308)/2+208, 46, 100, 60);
        cell.lineLabel.frame = CGRectMake(10, 14, 2, 18);
        cell.lineLabel.backgroundColor = RGB(0, 120, 245);
        cell.titleLabel.frame = CGRectMake(14, 13, 80, 20);
        cell.moreLabel.frame = CGRectMake(KTA_Screen_Width-45, 13, 30, 10);
        cell.moreLabel.textColor = RGB(135, 135, 135);
        cell.moreBtn.frame = CGRectMake(KTA_Screen_Width-50, 13, 50, 20);
        cell.moreImage.frame = CGRectMake(KTA_Screen_Width-17, 13, 7, 10);
        cell.moreImage.image = [UIImage imageNamed:@"home_more"];
        [cell.moreBtn addTarget:self action:@selector(tuKuMoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        MingRenTangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifer2"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MingRenTangTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        //名人堂
//        cell.myImageView.backgroundColor = [UIColor redColor];
        cell.topLineLabel.frame = CGRectMake(10, 14, 2, 18);
        cell.topLineLabel.backgroundColor = RGB(0, 120, 245);
        cell.titleLabel.frame = CGRectMake(14, 13, 80, 20);
        cell.rightLineLabel.frame = CGRectMake(10, 46, 3, 60);
        cell.rightLineLabel.backgroundColor = RGB(0, 120, 245);
        
        cell.myImageView.frame = CGRectMake(35, 53.5, 30, 30);
        cell.biaoqianLabel.frame = CGRectMake(23, 83.5, 54, 15);
        cell.biaoqianLabel.backgroundColor = RGB(228, 85, 74);
        cell.biaoqianLabel.layer.cornerRadius = 2;
        cell.biaoqianLabel.clipsToBounds = YES;
        cell.textLebl.frame = CGRectMake(87, 56, KTA_Screen_Width-160, 20);
        cell.textLebl.numberOfLines = 2;
//        cell.textLebl.backgroundColor = [UIColor redColor];
        
        cell.addressLab.frame = CGRectMake(87, 76, 160, 20);
        cell.addressLab.textColor = RGB(119, 126, 145);
        
        cell.leftLineLabel.frame = CGRectMake(KTA_Screen_Width-80, 51, 1, 50);
        cell.leftLineLabel.backgroundColor = RGB(48, 65, 85);
        cell.rightTextLeble.frame = CGRectMake(cell.leftLineLabel.frame.origin.x + 5, 51, 70, 30);
//        cell.rightTextLeble.backgroundColor = [UIColor redColor];
        cell.rightTextLeble.textColor = RGB(248, 74, 0);
        
        cell.rightTextLeble.textAlignment = NSTextAlignmentCenter;
        cell.rongyuLabel.frame = CGRectMake(cell.leftLineLabel.frame.origin.x + 5, 81, 70, 20);
        cell.rongyuLabel.textColor = RGB(218, 218, 218);
        
        cell.moreLabel.frame = CGRectMake(KTA_Screen_Width-45, 13, 30, 10);
        cell.moreLabel.textColor = RGB(135, 135, 135);
        cell.moreBtn.frame = CGRectMake(KTA_Screen_Width-50, 13, 50, 20);
        cell.moreImage.frame = CGRectMake(KTA_Screen_Width-17, 13, 7, 10);
        cell.moreImage.image = [UIImage imageNamed:@"home_more"];
        [cell.moreBtn addTarget:self action:@selector(mingRenTangMoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        if (dataDic[@"Fame"] != nil && [dataDic[@"Fame"] count] != 0) {
            NSString *imageStr = [NSString stringWithFormat:@"%@%@",URL_BASE,dataDic[@"Fame"][@"FamePic"]];
            [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@""]];
            
            NSDictionary *dic = dataDic[@"Fame"];
            NSMutableAttributedString *textString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ | 性别: %@",dic[@"FameName"],dic[@"FameSex"]]];
            [textString addAttribute:NSForegroundColorAttributeName value:RGB(119, 126, 145) range:NSMakeRange([dic[@"FameName"] length] + 2, [dic[@"FameName"] length]+4)];
            [textString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange([dic[@"FameName"] length] + 2, [dic[@"FameName"] length]+4)];
            cell.textLebl.attributedText = textString;
            cell.addressLab.text = [NSString stringWithFormat:@"地区: %@",dic[@"FameAreas"]];
            cell.rightTextLeble.text = dic[@"FameHonor"][0];
        }
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        MingRenTangDetailViewController *mingRenTangDetailVC = [[MingRenTangDetailViewController alloc]init];
        mingRenTangDetailVC.dataDic = dataDic[@"Fame"];
        [self.navigationController pushViewController:mingRenTangDetailVC animated:YES];
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
    [self.tableView endReload];
    
}
#pragma mark - 消息按钮点击事件
- (void)massageBtnClick
{
    TANotsViewController *notsVC = [[TANotsViewController alloc]init];
    [self.navigationController pushViewController:notsVC animated:YES];
}
#pragma mark - 搜索点击事件
- (void)searchBtnClick
{
    TASearchViewController *searchVC = [[TASearchViewController alloc]init];
    
    [self presentViewController:searchVC animated:YES completion:nil];
}
#pragma mark - 扫一扫按钮点击事件
- (void)scanningBtnBtnClick
{
    LBXScanViewController *vc = [[LBXScanViewController alloc]init];
    vc.successBlock = ^(NSString *result){
//        self.resluu = [[NSString alloc]initWithString:result];
//        
//        [self network];
    };
    //    vc.hidesBottomBarWhenPushed = YES; //有tabbar时添加
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 菜单按钮点击事件
- (void)menuBtnClick:(id)sender
{
    NSInteger tag = [sender tag];
    if (tag == 0) {//认证
        CertificationViewController *certificationVC = [[CertificationViewController alloc]init];
        [self.navigationController pushViewController:certificationVC animated:YES];
    }
    else if(tag == 1)//中国跆协
    {
        [LCProgressHUD showTextOntarget:self.view string:@"功能升级中,敬请期待!"];
    }
    else if(tag == 2)//新闻
    {
        NewsListViewController *newListVC = [[NewsListViewController alloc]init];
        [self.navigationController pushViewController:newListVC animated:YES];
    }
    else if(tag == 3)//公告
    {
        PublicNoticeViewController *pulicVC = [[PublicNoticeViewController alloc]init];
        [self.navigationController pushViewController:pulicVC animated:YES];
    }
    else if(tag == 4)//赛事
    {
        MatchViewController *matchVC = [[MatchViewController alloc]init];
        [self.navigationController pushViewController:matchVC animated:YES];
    }
    else if(tag == 5)//培训
    {
        TrainningViewController *trainVC = [[TrainningViewController alloc]init];
        [self.navigationController pushViewController:trainVC animated:YES];
    }
    else if(tag == 6)//公益
    {
        PublicWelfareViewController *publicWelfareVC = [[PublicWelfareViewController alloc]init];
        [self.navigationController pushViewController:publicWelfareVC animated:YES];
    }
    else if(tag == 7)//排名
    {
//        [LCProgressHUD showTextOntarget:self.view string:@"功能升级中,敬请期待!"];
        
        TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
        [cityPickerVC setDelegate:self];
        
        cityPickerVC.locationCityID = @"1400010000";
        //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
//        cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
//        [self.navigationController pushViewController:cityPickerVC animated:YES];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
//
        }];
    }
    else if(tag == 8)//名人堂
    {
        MingRenTangWebViewController *mingrentangVC = [[MingRenTangWebViewController alloc]init];
        [self.navigationController pushViewController:mingrentangVC animated:YES];
    }
    else if(tag == 9)//教学
    {
        [LCProgressHUD showTextOntarget:self.view string:@"功能升级中,敬请期待!"];
    }
    else if(tag == 10)//国家队
    {
        [LCProgressHUD showTextOntarget:self.view string:@"功能升级中,敬请期待!"];
    }
    else//跆拳百科
    {
        [LCProgressHUD showTextOntarget:self.view string:@"功能升级中,敬请期待!"];
    }
}
#pragma mark - 图库更多点击事件
- (void)tuKuMoreBtnClick
{
    HotPicturesViewController *hotPicturesVC = [[HotPicturesViewController alloc]init];
    [self.navigationController pushViewController:hotPicturesVC animated:YES];
}
#pragma mark - 名人堂更多点击事件
- (void)mingRenTangMoreBtnClick
{
    MingRenTangWebViewController *mingrentangVC = [[MingRenTangWebViewController alloc]init];
    [self.navigationController pushViewController:mingrentangVC animated:YES];
}
#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
//    [self.cityPickerButton setTitle:city.cityName forState:UIControlStateNormal];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
//    [self.navigationController popViewControllerAnimated:YES];
}
@end

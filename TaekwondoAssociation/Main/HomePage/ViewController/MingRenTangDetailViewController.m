//
//  MingRenTangDetailViewController.m
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/7/4.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "MingRenTangDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface MingRenTangDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MingRenTangDetailViewController
#pragma mark - lifeCircle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"名人详情";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self ininWithTableView];
    NSLog(@"--------------%@",_dataDic);
}
- (void)ininWithTableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [_myTableView setTableFooterView:view];
    UIView *bigView = [self headView];
    _myTableView.tableHeaderView = bigView;
}
- (UIView *)headView
{
    UIView *bigView = [[UIView alloc]init];
    bigView.backgroundColor = RGB(234, 235, 237);
    
    bigView.frame = CGRectMake(0, 0, KTA_Screen_Width, 210);
    
    //简介view
    UIView *jieshaoView = [[UIView alloc]init];
    
    jieshaoView.backgroundColor = RGB(250, 252, 253);
    jieshaoView.layer.cornerRadius = 6;
    jieshaoView.clipsToBounds = YES;
    [bigView addSubview:jieshaoView];
    UILabel *jiabinLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, KTA_Screen_Width-40, 30)];
//    jiabinLabel.backgroundColor = [UIColor greenColor];
    jiabinLabel.text = @"嘉宾介绍:";
    jiabinLabel.font = [UIFont systemFontOfSize:16];
    [jieshaoView addSubview:jiabinLabel];
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.frame = CGRectMake(20, 80, KTA_Screen_Width-40, 0);
//    textLabel.backgroundColor = [UIColor yellowColor];
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.textColor = RGB(130, 131, 134);
    
//    textLabel.text = @"    哈哈给我然后该如何该如何广发 我噶然后高我然后嘎哈人跟人hi个然后给一然后给一如果坏发hi啊护肤我日回归欧日UFO啊我IE我五日偶爱福海额护法uehfuwarfhruighjdhkahdfkadjhfksfkhafjhkjdh积分哈空间划分扣积分卡京东方卡积分哈卡积分卡法卡复活卡积分换卡剪短发哈空间话费卡剪短发贺卡剪短发哈空间地方哈空间发挥剪短发哈接电话防静电萨科技倒海翻江安徽省科技的话费卡健身房抠脚大汉交罚款互粉";
    textLabel.text = [NSString stringWithFormat:@"     %@",_dataDic[@"FameContent"]];
    [textLabel sizeToFit ];
    textLabel.frame = CGRectMake(20, 80, KTA_Screen_Width-40, textLabel.frame.size.height);
    jieshaoView.frame = CGRectMake(0, 50, KTA_Screen_Width, 100 + textLabel.frame.size.height);
    [jieshaoView addSubview:textLabel];
    //头部view
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(20, 10, KTA_Screen_Width-40, 80)];
    headView.backgroundColor = RGB(255, 255, 255);
    headView.layer.cornerRadius = 6;
    headView.clipsToBounds = YES;
    [bigView addSubview:headView];
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 22.5, 35, 35)];
    headImage.backgroundColor = [UIColor redColor];
    NSString *imageStr = [NSString stringWithFormat:@"%@%@",URL_BASE,_dataDic[@"FamePic"]];
    [headImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@""]];
    [headView addSubview:headImage];
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(headImage.frame.origin.x + headImage.frame.size.width + 10, 20, headView.frame.size.width-65, 20)];
    nameLab.text = _dataDic[@"FameName"];
//    nameLab.backgroundColor = [UIColor yellowColor];
    [headView addSubview:nameLab];
    UILabel *zhichenLab = [[UILabel alloc]initWithFrame:CGRectMake(headImage.frame.origin.x + headImage.frame.size.width + 10, 40, headView.frame.size.width-65, 20)];
    NSString *dutiesStr = _dataDic[@"FameDuties"];
    if (![dutiesStr isKindOfClass:[NSNull class]] && dutiesStr.length != 0) {
        zhichenLab.text = dutiesStr;
    }
//    zhichenLab.text = @"哈空间发哈交话费卡客服哈空间电话卡交话费会计师";
    zhichenLab.textColor = RGB(130, 131, 134);
    zhichenLab.font = [UIFont systemFontOfSize:13];
//    zhichenLab.backgroundColor = [UIColor greenColor];
    [headView addSubview:zhichenLab];
    bigView.frame = CGRectMake(0, 0, KTA_Screen_Width, jieshaoView.frame.origin.y + jieshaoView.frame.size.height-10);
    return bigView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (![_dataDic[@"FameHonor"] isKindOfClass:[NSNull class]] && [_dataDic[@"FameHonor"] count] != 0) {
        return 1;
    }
    else
    {
        return 0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataDic[@"FameHonor"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifer"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifer"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = _dataDic[@"FameHonor"][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = RGB(113, 113, 113);
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 30)];
    bigView.backgroundColor = RGB(245, 245, 245);
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 5, 20)];
    lineView.backgroundColor = RGB(54, 130, 240);
    [bigView addSubview:lineView];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, 100, 20)];
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.text = @"所获荣誉";
    [bigView addSubview:textLabel];
    return bigView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
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

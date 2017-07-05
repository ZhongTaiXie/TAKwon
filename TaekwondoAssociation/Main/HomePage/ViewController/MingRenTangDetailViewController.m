//
//  MingRenTangDetailViewController.m
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/7/4.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "MingRenTangDetailViewController.h"

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
    jieshaoView.frame = CGRectMake(0, 50, KTA_Screen_Width, 170);
    jieshaoView.backgroundColor = RGB(250, 252, 253);
    jieshaoView.layer.cornerRadius = 6;
    jieshaoView.clipsToBounds = YES;
    [bigView addSubview:jieshaoView];
    UILabel *jiabinLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, KTA_Screen_Width-40, 30)];
//    jiabinLabel.backgroundColor = [UIColor greenColor];
    jiabinLabel.text = @"嘉宾介绍:";
    [jieshaoView addSubview:jiabinLabel];
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.frame = CGRectMake(20, 80, KTA_Screen_Width-40, 0);
    textLabel.backgroundColor = [UIColor yellowColor];
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.textColor = RGB(130, 131, 134);
    
    textLabel.text = @"  哈哈给我然后该如何该如何广发 我噶然后高我然后嘎哈人跟人hi个然后给一然后给一如果坏发hi啊护肤我日回归欧日UFO啊我IE我五日偶爱福海额护arfhruighjdhkahdfkadjhfksfkhafjhkjdh积分哈空间划分扣积分卡京东方卡积分哈卡积分卡法卡复活卡积分换卡剪短发哈空间话费卡剪短发贺卡剪短发哈空间地方哈空间发挥剪短发哈接电话防静电萨科技倒海翻江安徽省科技的话费卡健身房抠脚大汉交罚款互粉就工行卡就福建卡的很费劲啊肯定会发空间发挥卡机的话费卡交话费积分哈空间和罚款接电话发空间发货款的金凤凰打卡机话费卡交话费肯德基";
    [jieshaoView addSubview:textLabel];
    //头部view
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(20, 10, KTA_Screen_Width-40, 80)];
    headView.backgroundColor = RGB(255, 255, 255);
    headView.layer.cornerRadius = 6;
    headView.clipsToBounds = YES;
    [bigView addSubview:headView];
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 22.5, 35, 35)];
    headImage.backgroundColor = [UIColor redColor];
    [headView addSubview:headImage];
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(headImage.frame.origin.x + headImage.frame.size.width + 10, 20, headView.frame.size.width-65, 20)];
    nameLab.backgroundColor = [UIColor yellowColor];
    [headView addSubview:nameLab];
    UILabel *zhichenLab = [[UILabel alloc]initWithFrame:CGRectMake(headImage.frame.origin.x + headImage.frame.size.width + 10, 40, headView.frame.size.width-65, 20)];
    zhichenLab.backgroundColor = [UIColor greenColor];
    [headView addSubview:zhichenLab];
    return bigView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifer"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifer"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = @"凤凰卡号发空间话费卡好地方卡交电话费卡德加恢复健康东方航空";
    return cell;
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

//
//  TAEditTaekAddressTableViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/1.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAEditTaekAddressTableViewController.h"
#import "TAMemberInfoCell.h"
#import "TATaekAddressCell.h"
#import "DQAreasView.h"


@interface TAEditTaekAddressTableViewController ()<DQAreasViewDelegate>

@property (nonatomic,strong) NSString *region;//区域
@property (nonatomic,strong) UITextField *addreddTextfield;//详细地址
@property (nonatomic, strong) DQAreasView *areasView;//省市区选择器
@property (nonatomic,strong) NSString *address;
@end

@implementation TAEditTaekAddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self setupTableView];
    [self setupData];
    [self createPickerView];
}



-(void)setNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"道馆地址";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAddress)];
    self.navigationItem.rightBarButtonItem = okItem;
}

-(void)setupTableView{
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];  //没有数据的话没有，有数据就有cell下面的线
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TATaekAddressCell" bundle:nil] forCellReuseIdentifier:@"addressCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAMemberInfoCell" bundle:nil] forCellReuseIdentifier:@"infoCell"];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

//省市区选择器出现
-(void)showProvinceView{
    [self.areasView startAnimationFunction];
}

//创建省市区和街道的选择器
-(void)createPickerView{
    self.areasView = [DQAreasView new];
    self.areasView.delegate = self;
}

-(void)setupData{
    NSArray *array = [self.model.Address componentsSeparatedByString:@" "];
    
    self.region = array[0];//截取范围类的字符串
    self.address = array[1];
}

#pragma mark - 与服务器交互
//保存地址
-(void)saveAddress{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在保存...";
    NSDictionary *params = @{
                             @"userID":UserID,
                             @"Address":[[self.region stringByAppendingString:@" "] stringByAppendingString:self.addreddTextfield.text]
                             };
    
    NSString *url = [HeadUrl stringByAppendingString:@"Center/SaveDaoGuanInfo"];
    [WQNetWorkManager sendPostRequestWithUrl:url parameters:params success:^(NSDictionary *dic) {
        [hud hideAnimated:YES];
        if (dic[@"Data"][@"Success"]) {
            [MBProgressHUD showSuccess:@"保存成功"];
            [self back];
            
        }else{
            [MBProgressHUD showError:dic[@"Data"][@"Msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TAMemberInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        cell.title = @"所在区域";
        cell.subTitle = self.region;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        TATaekAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.addressTextField.text = @"";
        self.addreddTextfield = cell.addressTextField;
        self.addreddTextfield.text = self.address;
        return cell;

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self showProvinceView];
    }
}


#pragma mrak - 选择省市
-(void)clickAreasViewEnsureBtnActionAreaStr:(NSString *)str cityCode:(NSString *)codeId{
    NSLog(@"%@   %@",str ,codeId);
    self.region = str;
    NSIndexPath *indexRow = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexRow] withRowAnimation:UITableViewRowAnimationNone];
}
@end

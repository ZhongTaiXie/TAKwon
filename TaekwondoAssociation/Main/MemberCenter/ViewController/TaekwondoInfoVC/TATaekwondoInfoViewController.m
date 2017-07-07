//
//  TATaekwondoInfoViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/1.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TATaekwondoInfoViewController.h"
#import "TAMemberIconCell.h"
#import "TAMemberInfoCell.h"
#import "TAEditTaekInfoViewController.h"
#import "TAEditTaekAddressTableViewController.h"
#import "TATaekIntroduceViewController.h"
#import "TATaekInfoModel.h"

@interface TATaekwondoInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,strong) UIImage *mendianImage;//门店的图片，从本地选的
@property (nonatomic,strong) UIImage *touxiangIcon;//头像照片
@property (nonatomic,assign) NSInteger index;//标志点的是选择头像还是门店

@property (nonatomic,strong) TATaekInfoModel *taekInfoModel;//model

@end

@implementation TATaekwondoInfoViewController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@[@"",@"道馆名称",@"手机号码",@"邮箱"],@[@"",@"营业时间",@"道馆电话",@"道馆地址"],@[@"道馆简介"]];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNav];
    [self setupTableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getTeakInfoFromServer];
}

-(void)loadView{
    [super loadView];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height + 20) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAMemberIconCell" bundle:nil] forCellReuseIdentifier:@"iconCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAMemberInfoCell" bundle:nil] forCellReuseIdentifier:@"infoCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}

-(void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"道馆信息";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

//门店的View
-(UIView *)memdianView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, (self.view.bounds.size.width - 40) * 68 / 300 + 60)];
    UILabel *label = [WQFactoryUI createLabelWithtextFont:15 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"666666"] textFrame:CGRectMake(10, 10, 300, 30) text:@"门店照片"];
    [bgView addSubview:label];
    
    UIButton *addPicBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, (self.view.bounds.size.width - 40) / 3, (self.view.bounds.size.width - 40) * 68 / 300)];
    UIImage *image = self.mendianImage ? self.mendianImage : [UIImage imageNamed:@"add-big"];
    [addPicBtn setImage:image forState:UIControlStateNormal];
    [addPicBtn addTarget:self action:@selector(showPickerView) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addPicBtn];
    
    return bgView;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

//弹出选择照片方式
- (void)showPickerView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        [PickerImage.navigationBar setBackgroundColor:[UIColor blackColor]];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 与服务器交互
-(void)getTeakInfoFromServer{
    NSDictionary *params = @{
                             @"userID":UserID
                             };
    
    NSString *url = [HeadUrl stringByAppendingString:@"Center/DaoGuanInfo"];
    [WQNetWorkManager sendPostRequestWithUrl:url parameters:params success:^(NSDictionary *dic) {
        
        if (dic[@"Data"][@"Success"]) {
            self.taekInfoModel = [WQManageData getTaekInfoModel:dic[@"Data"][@"Data"]];
            [self.tableView reloadData];
            
        }else{
            [MBProgressHUD showError:dic[@"Data"][@"Msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
}

//保存图片
-(void)savePicToServer{
    if (self.index == 1) { //保存头像
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"正在保存...";
        NSDictionary *params = @{
                                 @"userID":UserID,
                                 @"Photo":@1
                                 };
        
        NSString *url = [HeadUrl stringByAppendingString:@"Center/SaveDaoGuanInfo"];
        [WQNetWorkManager sendPostRequestWithUrl:url parameters:params success:^(NSDictionary *dic) {
            [hud hideAnimated:YES];
            if (dic[@"Data"][@"Success"]) {
                [MBProgressHUD showSuccess:@"保存成功"];
                
            }else{
                [MBProgressHUD showError:dic[@"Data"][@"Msg"]];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"网络错误"];
        }];
    }else{  //保存店面
        
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 4;
    } else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *sectionArray = self.titleArray[indexPath.section];
    NSString *title = sectionArray[indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0) {
        TAMemberIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iconCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[TAMemberIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iconCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
        if (self.touxiangIcon) {
            cell.iconImage = self.touxiangIcon;
        }
        
        return cell;
    }if (indexPath.section == 1 && indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell.contentView addSubview:[self memdianView]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
        return cell;
        
    }else{
        TAMemberInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[TAMemberInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"infoCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = title;
        
        NSString *subtitle;
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                subtitle = self.taekInfoModel.Name;
            }else if (indexPath.row == 2){
                subtitle = self.taekInfoModel.TelPhone;
            }else{
                subtitle = self.taekInfoModel.Email;
            }
        }else if (indexPath.section == 1){
            if (indexPath.row == 1) {
                subtitle = self.taekInfoModel.BusinessHours;
            }else if (indexPath.row == 2){
                subtitle = self.taekInfoModel.Phone;
            }else{
                subtitle = self.taekInfoModel.Address;
            }
        }else{
            
            subtitle = self.taekInfoModel.content;
            
        }
        cell.subTitle = subtitle;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            //上传头像
            self.index = 1;
            [self showPickerView];
        }else if (indexPath.row == 1){  //修改道馆名称
            
            TAEditTaekInfoViewController *editVC = [[TAEditTaekInfoViewController alloc] initWithNavTitle:@"道馆名称" text:self.taekInfoModel.Name index:1];
            [self.navigationController pushViewController:editVC animated:YES];
        }else if (indexPath.row == 2){  //修改手机号
            TAEditTaekInfoViewController *editVC = [[TAEditTaekInfoViewController alloc] initWithNavTitle:@"手机号" text:self.taekInfoModel.TelPhone index:2];
            [self.navigationController pushViewController:editVC animated:YES];
        }else{  //修改邮箱
            TAEditTaekInfoViewController *editVC = [[TAEditTaekInfoViewController alloc] initWithNavTitle:@"邮箱" text:self.taekInfoModel.Email index:3];
            [self.navigationController pushViewController:editVC animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1){ //修改营业时间
            
            TAEditTaekInfoViewController *editVC = [[TAEditTaekInfoViewController alloc] initWithNavTitle:@"营业时间" text:self.taekInfoModel.BusinessHours index:4];
            [self.navigationController pushViewController:editVC animated:YES];
        }else if (indexPath.row == 2){  //修改道馆电话
            TAEditTaekInfoViewController *editVC = [[TAEditTaekInfoViewController alloc] initWithNavTitle:@"道馆电话" text:self.taekInfoModel.Phone index:5];
            [self.navigationController pushViewController:editVC animated:YES];
        }else{  //道馆地址
            TAEditTaekAddressTableViewController *addressVC = [TAEditTaekAddressTableViewController new];
            addressVC.model = self.taekInfoModel;
            [self.navigationController pushViewController:addressVC animated:YES];
        }
    }else{   //道馆简介
        TATaekIntroduceViewController *introduceVC = [TATaekIntroduceViewController new];
        introduceVC.model = self.taekInfoModel;
        [self.navigationController pushViewController:introduceVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }if (indexPath.section == 1 && indexPath.row == 0) {
        return (self.view.bounds.size.width - 40) * 68 / 300 + 60;
    }
    return 45;
}

#pragma mark - 选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
//    NSString *base64Str = [WQTools imageToBase64:[UIImage imageNamed:@"header_bg"]];
    
    if (self.index == 1) {
        self.touxiangIcon = newPhoto;
    }else{
        self.mendianImage = newPhoto;
    }
    
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self savePicToServer];
}

@end

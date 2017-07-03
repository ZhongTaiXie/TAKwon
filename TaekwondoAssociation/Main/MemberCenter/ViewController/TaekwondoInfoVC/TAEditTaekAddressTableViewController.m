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

@interface TAEditTaekAddressTableViewController ()

@property (nonatomic,strong) NSString *region;//区域
@property (nonatomic,strong) UITextField *addreddTextfield;//详细地址

@end

@implementation TAEditTaekAddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];  //没有数据的话没有，有数据就有cell下面的线
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TATaekAddressCell" bundle:nil] forCellReuseIdentifier:@"addressCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAMemberInfoCell" bundle:nil] forCellReuseIdentifier:@"infoCell"];
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


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveAddress{
    
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
        return cell;

    }
}

@end

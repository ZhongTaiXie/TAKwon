//
//  TrainningApplyViewController.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TrainningApplyViewController.h"
#import "IQKeyboardManager.h"
#import "PhotosTableViewCell.h"
#import "EditImagesFrame.h"
#import "JKImagePickerController.h"
#import "LCProgressHUD.h"
#import "UIActionSheet+Blocks.h"

@interface TrainningApplyViewController ()<UITableViewDelegate,UITableViewDataSource,EditPhotoImagesViewDelegate,JKImagePickerControllerDelegate>

@property (nonatomic, strong) EditImagesFrame* editImagesFrame;
@property (nonatomic, strong) EditImagesFrame* editMediaPackFrame;
@property (nonatomic, strong) PhotosTableViewCell* photosTableViewCell;
@property (nonatomic, strong) PhotosTableViewCell* photosMediaPackCell;
@property (nonatomic, strong) NSMutableArray* imageArray;
@end

@implementation TrainningApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    self.navigationItem.title = @"培训报名";
    // tv初始化
    _tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height - TopNavigationBarHeight) style:UITableViewStyleGrouped];
    _tv.separatorColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    _tv.backgroundColor = [UIColor whiteColor];
    _tv.delegate = self;
    _tv.dataSource = self;
    
    [self.view addSubview:_tv];
    
    // 隐藏多余的分割线
    UIView* footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    self.tv.tableFooterView = footerView;
    
    // 设置头部label
    [self createHeadLabel];
    
    _imageArray = [NSMutableArray array];
    [_imageArray addObject:[UIImage imageNamed:@"upload"]];
    _editImagesFrame = [[EditImagesFrame alloc] initWithPicX:0];
    _editMediaPackFrame = [[EditImagesFrame alloc] initWithPicX:0];
}

- (void)createHeadLabel
{
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 60)];
    
    _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, KTA_Screen_Width - 20, 60)];
    _headLabel.text = @"注意事项:如果个人信息不完整,无法进行报名,请及时联系中国跆拳道网络部会员管理部010-87182943";
    _headLabel.textColor = [UIColor redColor];
    _headLabel.font = [UIFont systemFontOfSize:12];
    _headLabel.numberOfLines = 0;
    
    [headView addSubview:_headLabel];
    _tv.tableHeaderView = headView;
}


#pragma -mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }else{
        return 8;
    }
}


#pragma -mark UITableViewDelegate
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString* strId = @"infoCellId";
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:strId];
            
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strId];
            }
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = @"demo测试1";
            cell.detailTextLabel.text = @"demo测试2";
            
            return cell;
            
        }
            
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 3:
                    _trainingContentCell = [TrainingContentCell cellWithTableview:_tv];
                    return _trainingContentCell;
                    break;
                case 6:
                    _photosTableViewCell = [PhotosTableViewCell cellWithTableView:tableView];
                    if (!_photosTableViewCell.detailView.editPhotoImagesView.delegate) {
                        _photosTableViewCell.detailView.editPhotoImagesView.delegate = self;
                    }
                    [_editImagesFrame setIs_edit:YES];
                    [_editImagesFrame setImagesArray:_imageArray];
                    _photosTableViewCell.editImagesFrame = _editImagesFrame;
                    
                    return _photosTableViewCell;
                    break;
                case 7:
                    _remarkCell = [RemarkCell cellWithTableView:_tv];
                    return _remarkCell;
                    break;
                default:
                {
                    static NSString* strId = @"infoCellId";
                    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:strId];
                    
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strId];
                    }
                    cell.textLabel.textColor = [UIColor darkGrayColor];
                    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                    
                    NSString* ColorStr = @"demo测试3:＊";
                    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:ColorStr];
                    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[ColorStr rangeOfString:@"＊"]];
                    cell.textLabel.attributedText = attStr;
                    cell.detailTextLabel.text = @"demo测试4";
                    
                    return cell;
                }
                    break;
            }
            
            
        }
            
            break;
        default:
            return nil;
            break;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 7) {
        return 225;
    }
    else if (indexPath.section == 1 && indexPath.row == 6){
        return 150;
    }
    else{
        return 44;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    
    UIView* blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 17, 5, 15)];
    blueView.backgroundColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    
    UILabel* groupLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 50)];
    switch (section) {
        case 0:
        {
            NSString* str = @"会员信息 (＊)";
            NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:str];
            
            NSDictionary* colorAS = @{NSForegroundColorAttributeName:[UIColor redColor]};
            [attStr addAttributes:colorAS range:[str rangeOfString:@"＊"]];
            groupLb.attributedText = attStr;
        }
            
            break;
        case 1:
            groupLb.text = @"填写项";
            break;
        default:
            break;
    }
    
    
    
    
    [view addSubview:blueView];
    [view addSubview:groupLb];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 取消cell的选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 分割线顶头
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark- EditPhotoImagesViewDelegate
// 删除图片
- (void)showActionSheetShowWithTag:(NSInteger)index
{
    
    [self.view endEditing:YES];
    [UIActionSheet showInView:self.view withTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"删除"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
        
        
        if (buttonIndex == 0) {
            // 删除image数组中的对应图片
            [_imageArray removeObjectAtIndex:index];
            
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:6 inSection:1];
            
            [self.tv reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//            
//            // 如果被删除的是原有图片,将其mediapack存入数组中
//            
//            if ([[_inquiryInfoModel.mediaPackList objectAtIndex:index] isKindOfClass:[MediaPack class]]) {
//                [_removeArr addObject:[_inquiryInfoModel.mediaPackList objectAtIndex:index]];
//            }
//            
//            // 删除_inquiryInfoModel.mediaPackList中对应的元素
//            [_inquiryInfoModel.mediaPackList removeObjectAtIndex:index];
            
        }
        
    }];
    
}

- (void)addNewPhotosTaped
{
    
    [self.view endEditing:YES];
    
    [self openAlbum];
    
//    NSInteger upLoads = [[NSUserDefaults standardUserDefaults] integerForKey:@"upLoadCTURL"];
//    
//    
//    if (upLoads > 2 || _is_alert) {
//        // 打开相册
//        [self openAlbum];
//    }
//    else{
//        // 弹出上传教程
//        _is_alert = YES;
//        WebViewController* webControler = [[WebViewController alloc] init];
//        webControler.urlStr = kUploadCTURL;
//        webControler.navigationItem.title = @"传片教程";
//        [self.navigationController pushViewController:webControler animated:YES];
//        
//        [[NSUserDefaults standardUserDefaults] setInteger:upLoads + 1 forKey:@"upLoadCTURL"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    if (3- _imageArray.count == 0) {
        [LCProgressHUD showTextOntarget:self.view string:@"最多只能上传2张图片"];
        return;
    }
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 3- _imageArray.count >= 1?1:0;
    imagePickerController.maximumNumberOfSelection = 3- _imageArray.count;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}


#pragma mark - JKImagePickerControllerDelegate

- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source
{
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
        [_imageArray insertObject:asset.photo atIndex:_imageArray.count-1];
        [self.tv reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    }];
}

- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        for(JKAssets *asset in assets)
        {
            // 将新加的图片放在_imageArray中供ui直接显示image
            if (asset.photo) {
                [_imageArray insertObject:asset.photo atIndex:_imageArray.count-1];
                
                // 将新加的图片放在_inquiryInfoModel.mediaPackList中存储
//                [_inquiryInfoModel.mediaPackList addObject:asset.photo];
            }
            
            
        }
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:6 inSection:1];
        
        [self.tv reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}


- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
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

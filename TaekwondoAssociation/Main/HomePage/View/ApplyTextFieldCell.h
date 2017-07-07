//
//  ApplyTextFieldCell.h
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/7.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyTextFieldCell : UITableViewCell

@property (nonatomic, strong) UILabel* leftLb;
@property (nonatomic, strong) UITextField* tfView;
@property (nonatomic, strong) NSString* leftLbText;


+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end

//
//  WeightInfoCell.h
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/5.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeightInfoCell : UITableViewCell

@property (nonatomic, strong) UITextField* tfView;
@property (nonatomic, strong) UILabel* rightLb;
@property (nonatomic, strong) UILabel* leftLb;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

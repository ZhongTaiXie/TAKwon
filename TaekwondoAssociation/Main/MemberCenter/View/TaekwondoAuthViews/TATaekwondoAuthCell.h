//
//  TATaekwondoAuthCell.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/28.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TATaekwondoAuthCell : UITableViewCell

@property (nonatomic,strong) UITextField *textField;

//
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title placeholder:(NSString *)placeholder;

-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

@end

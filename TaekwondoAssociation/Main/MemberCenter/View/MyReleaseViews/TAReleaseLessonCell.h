//
//  TAReleaseLessonCell.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAReleaseLessonCell : UITableViewCell

@property (nonatomic,strong) UITextField *textField;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title placeHolder:(NSString *)placeHolder;


@end

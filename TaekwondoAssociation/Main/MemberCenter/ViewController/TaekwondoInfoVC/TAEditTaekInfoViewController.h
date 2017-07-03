//
//  TAEditTaekInfoViewController.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/1.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAEditTaekInfoViewController : UIViewController

@property (nonatomic, strong) NSString *navTitle;
@property (nonatomic,strong) NSString *text;

@property (nonatomic,assign) NSInteger index;

-(instancetype)initWithNavTitle:(NSString *)navTitle text:(NSString *)text index:(NSInteger)index;

@end

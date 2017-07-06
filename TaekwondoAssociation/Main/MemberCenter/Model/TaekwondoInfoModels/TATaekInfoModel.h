//
//  TATaekInfoModel.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TATaekInfoModel : NSObject

@property (nonatomic,strong) NSString *Photo;  //用户的头像
@property (nonatomic,strong) NSString *Name;  //道馆名称
@property (nonatomic,strong) NSString *TelPhone;  //手机号
@property (nonatomic,strong) NSString *Email;  //邮箱
@property (nonatomic,strong) NSString *pic;  //门店照片(url)
@property (nonatomic,strong) NSString *BusinessHours;  //营业时间
@property (nonatomic,strong) NSString *Phone;  //道馆电话
@property (nonatomic,strong) NSString *Address;   //道馆地址
@property (nonatomic,strong) NSString *content;   //道馆简介
@property (nonatomic,strong) NSString *ProfilePic;  //道馆简介图

+(instancetype)initTATaekInfoModelWithDic:(NSDictionary *)dic;

@end

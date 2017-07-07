//
//  TALocalUser.h
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TALocalUser : NSObject

// 会员编号
@property (nonatomic,copy)NSString *MemberNumber;
// 会员验证码
@property (nonatomic,copy)NSString *VerificationCode;
// 会员姓名
@property (nonatomic,copy)NSString *NickName;
// 道馆负责人
@property (nonatomic,copy)NSString *linkren;
// 性别
@property (nonatomic)NSNumber *sex;// 1.代表男   2.代表女  0.代表未知
// 出生日期
@property (nonatomic,copy)NSString *birthAge;
// 注册日期
//@property (nonatomic,copy)NSString *regTime;
// 开始时间
@property (nonatomic,copy)NSString *StartTime;
// 结束时间
@property (nonatomic,copy)NSString *EndTime;
// 头像
@property (nonatomic,copy)NSString *HeadImg;
// 会员类型 1.个人会员，2.团体会员
@property (nonatomic)NSNumber *UserType;
// 手机号
@property (nonatomic,copy)NSString *Phone;
// 身份证号
@property (nonatomic,copy)NSString *IdCard;
// 地址
//@property (nonatomic,copy)NSString *address;
// 是否认证  
@property (nonatomic)NSNumber *IsCertification;
// 真实姓名
@property (nonatomic,copy)NSString *RealName;
// Email   
@property (nonatomic,copy)NSString *Email;

@end

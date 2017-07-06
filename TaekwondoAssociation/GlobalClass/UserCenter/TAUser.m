//
//  TAUser.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAUser.h"
#import "MJExtension.h"

@implementation TAUser

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"NickName":@"name",
             @"UserType":@"type",
             @"IdCard":@"idcard",
             @"Phone":@"phone",
             @"StartTime":@"beginTime",
             @"EndTime":@"endTime",
             @"BirthAge":@"birthday",
             @"MemberNumber":@"userNo",
             @"VerificationCode":@"usercode",
             @"HeadImg":@"facephoto"
             };
}

@end

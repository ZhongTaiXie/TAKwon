//
//  WQManageData.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAPersonalModel.h"
#import "TATaekInfoModel.h"

@interface WQManageData : NSObject

//解析用户信息
+(TAPersonalModel *)getPersonalModel:(NSDictionary *)dic;

//解析道馆信息
+(TATaekInfoModel *)getTaekInfoModel:(NSDictionary *)dic;

//解析我的发布
+(NSArray *)getMyReleaseData:(NSDictionary *)dic;

@end

//
//  WQManageData.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "WQManageData.h"
#import "TAActivityModel.h"
#import "TALessonModel.h"

@implementation WQManageData

//解析用户信息
+(TAPersonalModel *)getPersonalModel:(NSDictionary *)dic{
    return [TAPersonalModel initTAPersonalModelWithDic:dic];
}


//解析道馆信息
+(TATaekInfoModel *)getTaekInfoModel:(NSDictionary *)dic{
    return [TATaekInfoModel initTATaekInfoModelWithDic:dic];
}

//解析我的发布
+(NSArray *)getMyReleaseData:(NSDictionary *)dic{
    NSArray *activityArray = dic[@"Data"][@"Data"][@"daoguanActivitylist"];
    
    NSMutableArray *actiMutableArray = [NSMutableArray array];
    for (NSDictionary *actiDic in activityArray) {
        TAActivityModel *model = [TAActivityModel initTAActivityModelWithDic:actiDic];
        [actiMutableArray addObject:model];
    }
    
    
    NSArray *lessonArray = dic[@"Data"][@"Data"][@"classSchedulelist"];
    NSMutableArray *lessonMutableArray = [NSMutableArray array];
    for (NSDictionary *actiDic in lessonArray) {
        TALessonModel *model = [TALessonModel initTALessonModelWithDic:actiDic];
        [lessonMutableArray addObject:model];
    }
    
    return @[[lessonMutableArray copy],[actiMutableArray copy]];
}

@end

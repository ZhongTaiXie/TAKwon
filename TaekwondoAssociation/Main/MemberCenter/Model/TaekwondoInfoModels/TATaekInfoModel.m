//
//  TATaekInfoModel.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TATaekInfoModel.h"
#import <MJExtension.h>


@implementation TATaekInfoModel

+(instancetype)initTATaekInfoModelWithDic:(NSDictionary *)dic{
    TATaekInfoModel *model = [TATaekInfoModel new];
    [model mj_setKeyValues:dic];
    
    return model;
    
}



@end

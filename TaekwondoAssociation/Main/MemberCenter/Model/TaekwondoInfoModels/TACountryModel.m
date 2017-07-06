//
//  TACountryModel.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TACountryModel.h"
#import <MJExtension.h>

@implementation TACountryModel

+(instancetype)initAreaModelWithDic:(NSDictionary *)dic{
    TACountryModel *model = [[self alloc] init];
    [model mj_setKeyValues:dic];
    
    return model;
}

@end

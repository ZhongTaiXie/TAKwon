//
//  TACityModel.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TACityModel.h"
#import "TACountryModel.h"
#import <MJExtension.h>


@implementation TACityModel

+(instancetype)initCityModelWithDic:(NSDictionary *)dic{
    TACityModel *model = [[self alloc] init];
    [model mj_setKeyValues:dic];
    
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *dic in model.CountryList) {
        TACountryModel *cityModel = [TACountryModel initAreaModelWithDic:dic];
        [mArray addObject:cityModel];
    }
    model.CountryList = [mArray copy];
    return model;
}


@end

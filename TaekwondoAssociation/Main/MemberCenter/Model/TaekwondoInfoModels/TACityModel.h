//
//  TACityModel.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TACityModel : NSObject

@property (nonatomic,strong) NSString *Name;
@property (nonatomic,strong) NSNumber *Id;
@property (nonatomic,strong) NSArray *CountryList;

+(instancetype)initCityModelWithDic:(NSDictionary *)dic;

@end

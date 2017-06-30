//
//  WQPrefixHeader.pch
//  优款
//
//  Created by gut on 16/12/19.
//  Copyright © 2016年 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^successBlock)(NSDictionary *dic);
typedef void(^failureBlock)(NSError *error);

@interface WQNetWorkManager : NSObject

+ (void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)data success:(successBlock)success failure:(failureBlock)failure;

+ (void)sendPostRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)data success:(successBlock)success failure:(failureBlock)failure;

@end

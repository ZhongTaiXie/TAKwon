//
//  UIImageView+SDWebImage.h
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

typedef void(^DownloadSuccessBlock)(SDImageCacheType cacheType,UIImage *image);
typedef void(^DownloadFailureBlock)(NSError *error);
typedef void(^DownloadProgressBlock)(CGFloat progress);

@interface UIImageView (SDWebImage)

- (void)downloadImage:(NSString *)url placeholder:(UIImage *)placeholder;


- (void)downloadImage:(NSString *)url placeholder:(UIImage *)placeholder success:(DownloadSuccessBlock)success failure:(DownloadFailureBlock)failure progress:(DownloadProgressBlock)progress ;

@end

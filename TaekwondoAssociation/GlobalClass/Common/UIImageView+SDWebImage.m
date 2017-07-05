//
//  UIImageView+SDWebImage.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "UIImageView+SDWebImage.h"

@implementation UIImageView (SDWebImage)

- (void)downloadImage:(NSString *)url placeholder:(UIImage *)placeholder {
    url = [NSString stringWithFormat:@"%@%@",URL_BASE,url];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

- (void)downloadImage:(NSString *)url placeholder:(UIImage *)placeholder success:(DownloadSuccessBlock)success failure:(DownloadFailureBlock)failure progress:(DownloadProgressBlock)progress {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:SDWebImageLowPriority |SDWebImageRetryFailed  progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        progress((CGFloat)receivedSize/expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            failure(error);
        }else {
        self.image = image;
        success(cacheType,image);
    
        }}];
}

@end

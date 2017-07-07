//
//  EditImageView.m
//  lumbarVertebrae
//
//  Created by Ceres on 15/9/15.
//  Copyright (c) 2015年 www.upupapp.com. All rights reserved.
//

#import "EditImageView.h"
#import <UIImageView+WebCache.h>

@interface EditImageView ()

@property (nonatomic , weak) UIImageView *gifView;

@end

@implementation EditImageView

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.opaque = YES;
        //添加一个gif图标
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        
        [self addSubview:gifView];
        self.gifView = gifView;
        
    }
    
    return self;
}



- (void)setPhoto:(NSString *)photo {
    
    _photo = photo;
    // 1.下载图片
    
//    [self sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageWithName:@"dongtaiquan"] completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
//        if (!error) {
//            self.image  =image;
//        }else{
//            NSLog(@"%@",error);
//        }
//    }];
    [self sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageWithName:@"dongtaiquan"] options:SDWebImageRetryFailed|SDWebImageLowPriority];

    // 2.添加gif图标显示
    NSString *extension = photo.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
    

}

- (void)setPhotoImage:(UIImage *)photoImage
{
    _photoImage = photoImage;
    self.image = photoImage;
    
    self.gifView.hidden = YES;
}

-(void)layoutSubviews {
    [super layoutSubviews];

    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

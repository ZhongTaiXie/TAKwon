//
//  EditPhotoImagesView.m
//  lumbarVertebrae
//
//  Created by Ceres on 15/9/15.
//  Copyright (c) 2015年 www.upupapp.com. All rights reserved.
//

#import "EditPhotoImagesView.h"
#import "EditImageView.h"
//#import "MJPhoto.h"
//#import "MJPhotoBrowser.h"
#import "LCImageModel.h"

#define DSStatusPhotosMaxCount 7
#define DSStatusPhotosMaxCols(photosCount) ((photosCount == 4) ? 3 :3)
#define DSStatusPhotosMaxColsFour(photosCount) ((photosCount == 3) ? 2 :2)
#define DSStatusPhotosW (kDeviceWidth-40)/3
#define DSStatusPhotosH DSStatusPhotosW
#define DSStatusPhotosMargin 10

@implementation EditPhotoImagesView

- (instancetype)initWithPicX:(CGFloat)picX
{
    
    self = [super init];
    if (self) {
        _picX = picX;
        _picline = 10;
        self.userInteractionEnabled = YES;
        //预先创建9个图片控件
        for (int i = 0; i < DSStatusPhotosMaxCount; i++){
            EditImageView *photoView = [[EditImageView alloc] init];
            photoView.layer.masksToBounds = YES;
            photoView.layer.cornerRadius = 5;
            photoView.tag = i;
            [self addSubview:photoView];
            
            //添加手势
            UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(statusPhotoOnTap:)];
            [photoView addGestureRecognizer:gestureRecognizer];
            
            UILongPressGestureRecognizer *longPressedGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(statusPhotoOnLongPressed:)];
            [photoView addGestureRecognizer:longPressedGestureRecognizer];
            [gestureRecognizer requireGestureRecognizerToFail:longPressedGestureRecognizer];
        }
        _prescriptionView = [[PrescriptionImageEditView alloc] init];
    }
    return self;
}

- (void)setMediaPacks:(NSArray *)mediaPacks
{
    _mediaPacks = mediaPacks;
    NSMutableArray *thImages = [NSMutableArray array];
    NSMutableArray *images = [NSMutableArray array];
    for (MediaPack *model in mediaPacks) {
        
        [thImages addObject:model.thumbnail];
        [images addObject:model.origin];
    }
    self.image_thumb_urls = thImages;
    self.image_urls = images;
}

- (void)statusPhotoOnLongPressed:(UILongPressGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        if (recognizer.view.tag != self.image_thumb_urls.count-1) {
            if (_delegate && [_delegate respondsToSelector:@selector(showActionSheetShowWithTag:)]) {
                [_delegate showActionSheetShowWithTag:recognizer.view.tag];
            }
        }
    }
    
   

}

- (void)setIs_prescription:(BOOL)is_prescription
{
    _is_prescription = is_prescription;
}

- (void)statusPhotoOnTap:(UITapGestureRecognizer *)recognizer {
    
    // 移除键盘响应者
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideKeyboard" object:nil];
    
    // 诊断编辑图片
    if (_is_prescription) {
//        _prescriptionView = [[PrescriptionImageEditView alloc] initWithImageUrl:self.image_urls[recognizer.view.tag]];
        
        _prescriptionView.index = recognizer.view.tag;
        _prescriptionView.imageUrl = self.image_urls[recognizer.view.tag];
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:_prescriptionView];
    }
    
    else{
        if (recognizer.view.tag == self.image_thumb_urls.count -1)
        {
            //添加新图片
            if (_delegate && [_delegate respondsToSelector:@selector(addNewPhotosTaped)]) {
                [_delegate addNewPhotosTaped];
            }else{
//                // 1.创建图片浏览器
//                MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//                
//                // 2.设置图片浏览器显示的所有图片
//                NSMutableArray *photos = [NSMutableArray array];
//                int count = (int)self.image_thumb_urls.count ;
//                for (int i = 0; i <count; i++){
//                    
//                    LCImageModel *pic = [[LCImageModel alloc] init];
//                    
//                    id image = self.image_thumb_urls[i];
//                    
//                    MJPhoto *photo = [[MJPhoto alloc] init];
//                    
//                    if ([image isKindOfClass:[UIImage class]]) {
//                        pic.image = image;
//                        photo.image = image;
//                    } else {
//                        pic.thumbnail_pic = self.image_thumb_urls[i];
//                        if (self.image_urls.count == 0) {
//                            
//                            pic.original_pic = self.image_thumb_urls[i];
//                            photo.url = [NSURL URLWithString:pic.original_pic];
//                            
//                        } else {
//                            pic.original_pic = self.image_urls[i];
//                            photo.url = [NSURL URLWithString:pic.original_pic];
//                        }
//                    }
//                    
//                    //设置来源于哪一个UIImageView
//                    photo.srcImageView = self.subviews[i];
//                    
//                    [photos addObject:photo];
//                }
//                
//                browser.photos = photos;
//                
//                // 3.设置默认显示的图片索引
//                browser.currentPhotoIndex = recognizer.view.tag;
//                
//                // 4.显示浏览器
//                [browser show];
            }
            
        } else
        {
//            // 1.创建图片浏览器
//            MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//            
//            // 2.设置图片浏览器显示的所有图片
//            NSMutableArray *photos = [NSMutableArray array];
//            
//            int count = (int)self.image_thumb_urls.count -1;
//            // 如果是不带+号的,count+1;
//            if (_mediaPacks) {
//                count++;
//            }
//            for (int i = 0; i <count; i++){
//                
//                LCImageModel *pic = [[LCImageModel alloc] init];
//                
//                id image = self.image_thumb_urls[i];
//                
//                MJPhoto *photo = [[MJPhoto alloc] init];
//                
//                if ([image isKindOfClass:[UIImage class]]) {
//                    pic.image = image;
//                    photo.image = image;
//                } else {
//                    pic.thumbnail_pic = self.image_thumb_urls[i];
//                    if (self.image_urls.count == 0) {
//                        
//                        pic.original_pic = self.image_thumb_urls[i];
//                        photo.url = [NSURL URLWithString:pic.original_pic];
//                        
//                    } else {
//                        pic.original_pic = self.image_urls[i];
//                        photo.url = [NSURL URLWithString:pic.original_pic];
//                    }
//                }
//                
//                //设置来源于哪一个UIImageView
//                photo.srcImageView = self.subviews[i];
//                
//                [photos addObject:photo];
//            }
//            
//            browser.photos = photos;
//            
//            // 3.设置默认显示的图片索引
//            browser.currentPhotoIndex = recognizer.view.tag;
//            
//            // 4.显示浏览器
//            [browser show];
            
        }
    }
    
    
}

- (void)setImage_thumb_urls:(NSArray *)image_thumb_urls
{
    
    _image_thumb_urls = image_thumb_urls;
    
    for (int i = 0; i < DSStatusPhotosMaxCount; i++){
        EditImageView *photoView = self.subviews[i];
        
        if (i < image_thumb_urls.count){
             id image = self.image_thumb_urls[i];
            if ([image isKindOfClass:[UIImage class]]) {
                
                  photoView.photoImage = image;
                
            } else {
                 photoView.photo = image_thumb_urls[i];
            }
            
         
            photoView.hidden = NO;
            
            
        } else {
            photoView.hidden = YES;
        }
    }


}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    int count = (int)self.image_thumb_urls.count;
    int maxCols;
    if (count == 4&&_picX != 0) {
        maxCols = DSStatusPhotosMaxColsFour(count);
    }else{
        maxCols = DSStatusPhotosMaxCols(count);
    }
    CGFloat pic =_picX;
    CGFloat picline =_picline;
    if (pic != 0){
        pic = pic -6;
        picline = 4;
    }
    for (int i = 0; i < count; i++){
        if(count ==1&&pic != 0){
            EditImageView *photoView = self.subviews[0];
            photoView.width = (kDeviceWidth-40)/2;
            photoView.height = (kDeviceWidth-40)/2;
            photoView.x = (i % maxCols) * (photoView.width + picline);
            photoView.y = (i / maxCols) * (photoView.height + picline);
        }else if (count == 4&&pic != 0){
            EditImageView *photoView = self.subviews[i];
            photoView.width = (kDeviceWidth-40)/3;
            photoView.height = (kDeviceWidth-40)/3;
            
            photoView.x = (i % maxCols) * (photoView.width + picline);
            photoView.y = (i / maxCols) * (photoView.height + picline);
        }else{
        
        EditImageView *photoView = self.subviews[i];
        photoView.width = (kDeviceWidth-40-pic)/3;
        photoView.height = (kDeviceWidth-40-pic)/3;
        
        photoView.x = (i % maxCols) * (photoView.width + picline);
        photoView.y = (i / maxCols) * (photoView.height + picline);
        }
        
    }

}


+ (CGSize)sizeWithPhotosCount:(int)photosCount picX:(CGFloat)picX{
    
    int maxCols;
    if (photosCount == 4 &&picX != 0) {
        maxCols = DSStatusPhotosMaxColsFour(photosCount);
    }else{
        maxCols = DSStatusPhotosMaxCols(photosCount);
    }
    
    // 总列数
    int totalCols = photosCount >= maxCols ? maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    CGFloat picline = 10;
    if (picX != 0){
        picX = picX -6;
        picline = 4;
    }
    // 计算尺寸
    CGFloat photosW;
    CGFloat photosH;
    if(photosCount ==1&&picX != 0){
        photosW = totalCols * (kDeviceWidth-40)/2+ (totalCols - 1) * picline;
        photosH = totalRows * (kDeviceWidth-40)/2+ (totalRows - 1) * picline;
    }else if (photosCount == 4&&picX != 0){
        photosW = totalCols * (kDeviceWidth-40)/3+ (totalCols - 1) * picline;
        photosH = totalRows * (kDeviceWidth-40)/3+ (totalRows - 1) * picline;
    }else{
        photosW = totalCols * (kDeviceWidth-40-picX)/3+ (totalCols - 1) * picline;
        photosH = totalRows * (kDeviceWidth-40-picX)/3+ (totalRows - 1) * picline;
    }
    return CGSizeMake(photosW, photosH);
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  EditImagesContentView.m
//  lumbarVertebrae
//
//  Created by Ceres on 15/9/15.
//  Copyright (c) 2015年 www.upupapp.com. All rights reserved.
//

#import "EditImagesContentView.h"

#import "EditImagesFrame.h"
@interface EditImagesContentView ()

@end

@implementation EditImagesContentView


- (instancetype)initWithPicX:(CGFloat)picX {
    
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.opaque = YES;
        
        // 8.配图
        EditPhotoImagesView *editPhotoImagesView = [[EditPhotoImagesView alloc] initWithPicX:picX];
        [self addSubview:editPhotoImagesView];
        self.editPhotoImagesView = editPhotoImagesView;

        // 添加一个label
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 44)];
        label.text = @"上传身份证正反面";
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        
    }
    
    
    return self;
    
}


- (void)setEditImagesFrame:(EditImagesFrame *)editImagesFrame
{
    _editImagesFrame = editImagesFrame;
    self.frame = editImagesFrame.frame;
    //取出数据
    NSArray *imagesArray = editImagesFrame.imagesArray;
    
    //配图
    if (imagesArray.count){
        self.editPhotoImagesView.frame = editImagesFrame.imagesFrame;
        
        // 如果传入值为mediapck的list 则为不带加号的
        if ([[imagesArray lastObject] isKindOfClass:[MediaPack class]]) {
            self.editPhotoImagesView.mediaPacks = imagesArray;
        }else{
            self.editPhotoImagesView.image_thumb_urls = imagesArray;
        }
        self.editPhotoImagesView.hidden = NO;
        
    }else{
        self.editPhotoImagesView.hidden = YES;
    }

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

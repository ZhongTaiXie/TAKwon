//
//  PhotosTableViewCell.h
//  lumbarVertebrae
//
//  Created by Ceres on 15/9/15.
//  Copyright (c) 2015年 www.upupapp.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditImagesContentView.h"
@class EditImagesFrame;

@interface PhotosTableViewCell : UITableViewCell


@property (nonatomic , strong) EditImagesFrame *editImagesFrame;

@property (nonatomic , strong) NSIndexPath *indexpath;

@property (nonatomic , weak) EditImagesContentView *detailView;

+ (instancetype)cellWithTableView:(UITableView *)tablView;

@end

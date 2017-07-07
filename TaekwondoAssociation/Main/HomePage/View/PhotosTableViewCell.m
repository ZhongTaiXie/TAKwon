//
//  PhotosTableViewCell.m
//  lumbarVertebrae
//
//  Created by Ceres on 15/9/15.
//  Copyright (c) 2015年 www.upupapp.com. All rights reserved.
//

#import "PhotosTableViewCell.h"
#import "EditImagesContentView.h"
@implementation PhotosTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tablView {
    
    static NSString *ID = @"PhotosTableViewCellID";
    PhotosTableViewCell *cell = [tablView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[PhotosTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加Feed具体内容
        [self setupDetailView];
        //cell设置
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
        //self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
    
}


- (void)setupDetailView {
    
    EditImagesContentView *detailView = [[EditImagesContentView alloc] initWithPicX:0];
    [self.contentView addSubview:detailView];
    self.detailView = detailView;
}


- (void)setEditImagesFrame:(EditImagesFrame *)editImagesFrame
{
    _editImagesFrame = editImagesFrame;
    
    self.detailView.editImagesFrame = editImagesFrame;
}


@end

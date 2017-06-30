//
//  MingRenTangTableViewCell.h
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/6/30.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MingRenTangTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *leftLineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *biaoqianLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLebl;
@property (weak, nonatomic) IBOutlet UILabel *rightLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTextLeble;

@end

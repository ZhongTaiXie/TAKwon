//
//  HotPicturesViewController.m
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "HotPicturesViewController.h"
#import "TARequestManager.h"

@interface HotPicturesViewController ()

@property(nonatomic,strong)TARequestManager *requestManager;

@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation HotPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.title = @"最新图文";
   
    
}



@end

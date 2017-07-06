//
//  HotPicturesViewController.m
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "HotPicturesViewController.h"
#import "TARequestManager.h"
#import "ConstColor.h"
#import "UIImageView+SDWebImage.h"

static NSString * const reuseIdentifier = @"cellID";

static NSString * const CellIdentifier  = @"fdfdfd";

@interface HotPicturesViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic , strong)UICollectionView *collectionView;

@property (nonatomic , strong)NSMutableArray *dataSource;

@property(nonatomic,strong)TARequestManager *requestManager;

@property (nonatomic,strong)NSMutableDictionary *dicSource;

@property (nonatomic, assign)int  a;

@property (nonatomic, strong)UIView *baseView;



@end

@implementation HotPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.title = @"最新图文";
    self.a = 0;
    self.dicSource = [NSMutableDictionary dictionary];
//    self.dataSource = [NSMutableArray arrayWithObjects:@"2017-2",@"2017-4",@"2017-5", nil];
    [self network];
}

- (void)network {
    
    [TARequestManager TARequestCompletedWithPath:URL_MROEPIC Parameters:nil sucee:^(NSDictionary *dic) {
        NSArray *dict =dic[@"Data"][@"Data"];
        
        self.dataSource = [NSMutableArray arrayWithArray:dict];
        NSLog(@"%@",dict);
        
        // 切换布局
        [self.view addSubview:self.collectionView];

    } fail:^(NSError *error) {
        
    }];
}

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat itemWidth = (self.view.frame.size.width - 5 * 3) / 4;
        
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth+10);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 3;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 3;
        //设置senction的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        //设置UICollectionView的滑动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //sectionHeader的大小,如果是竖向滚动，只需设置Y值。如果是横向，只需设置X值。
        flowLayout.headerReferenceSize = CGSizeMake(100,0);
        //        LinstFlowLayout *itemm = [[LinstFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier];
        // 如果有class来注册这个头部或尾部视图时一定要用代码的方式去设置下这个头部或尾部的尺寸
        // 加载的时候会根据字符串来判断是头还是尾
        flowLayout.headerReferenceSize = CGSizeMake(30, 35);
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        //        itemm.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView.userInteractionEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
}



#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
//    
//    NSMutableArray *countSection = [NSMutableArray array];
//    
//        NSArray * keys = self.dicSource.allKeys;//allKeys属性是只读的，所以只有getter方法
//        
//        //1.for()循环方式
//        for (int i = 0; i < keys.count; i++) {
//            //逐个的获取键
//            NSString * key = [keys objectAtIndex:i];
//            
//            //通过键，找到相对应的值
//            NSArray * value = [self.dicSource valueForKey:key];
//            [countSection addObject:@(value.count)];
//}
//
//   
    for (int i = 0; i <self.dataSource.count; i ++) {
        
        if (section == i) {
            
            NSDictionary *dic = self.dataSource[i];
            NSString *Value = dic.allKeys[0];
            NSArray *arrCount = [dic valueForKey:@"Imgs"];
//            NSLog(@"%@",dic.allKeys);
            return arrCount.count;
//
        }
//
}
//
    return 0;
//
}
    



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return self.dataSource.count;
//    NSMutableArray *countSection = [NSMutableArray array];
//    
//    NSArray * keys = self.dicSource.allKeys;
//    for (int i = 0; i < keys.count; i++) {
//        //逐个的获取键
//        NSString * key = [keys objectAtIndex:i];
//        
//        //通过键，找到相对应的值
//        NSArray * value = [self.dicSource valueForKey:key];
//        [countSection addObject:@(value.count)];
//    }
//    return countSection.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor cyanColor];
    CGFloat itemWidth = (self.view.frame.size.width - 5 * 3) / 4;
    
    UIImageView *imageVieww = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, itemWidth, itemWidth+10)];
    NSDictionary *dic = self.dataSource[indexPath.section];
    NSArray *arrImage =  [dic valueForKey:@"Imgs"];
    imageVieww.userInteractionEnabled = YES;
  
   
    
    imageVieww.backgroundColor = [UIColor redColor];
    if ([arrImage[indexPath.row] isKindOfClass:[NSNull class]]) {
        
    }else {
        
        [imageVieww downloadImage:arrImage[indexPath.row] placeholder:nil];
        [cell.contentView addSubview:imageVieww];
    }
    UIButton *butn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, itemWidth, itemWidth+10)];
    butn.tag = self.a;
    [butn addTarget:self action:@selector(tapButtion:) forControlEvents:(UIControlEventTouchUpInside)];
    self.a ++;
    [cell.contentView addSubview:butn];
    
    return cell;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    // 如果当前想要的是头部视图
    // UICollectionElementKindSectionHeader是一个const修饰的字符串常量,所以可以直接使用==比较
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        headerView.backgroundColor = [ConstColor dividerColor];
        
        for (UIView *view in [headerView subviews]) {
            [view removeFromSuperview];
        }
        
        UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 4, 10)];
        blueView.backgroundColor = [UIColor blueColor];
        [headerView addSubview:blueView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, KTA_Screen_Width-40, 13)];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
       
      
       
        NSDictionary *dic = self.dataSource[indexPath.section];
        titleLabel.text =  [dic valueForKey:@"ImgDate"];

        [headerView addSubview:titleLabel];
        
        
        return headerView;
        
    }else {
        return nil;
    }
}
#pragma mark  图片点击  

- (void)tapButtion:(UIButton *)btn {
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
   
  
    NSMutableArray *imageUrl = [NSMutableArray array];
    for (NSDictionary *dic  in self.dataSource) {
         NSArray *arrImage =  [dic valueForKey:@"Imgs"];
        for (int i = 0; i < arrImage.count; i ++) {
            [imageUrl addObject:arrImage[i]];
        }
    }
    
    
    UIImageView *superImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height)];
    [superImage downloadImage:imageUrl[btn.tag] placeholder:nil];
    self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height)];
    self.baseView.backgroundColor = [UIColor blackColor];
    [self.baseView addSubview:superImage];
    
    [self.view addSubview:self.baseView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(news:)];
    [self.baseView addGestureRecognizer:tap];
    
}

- (void)news:(UITapGestureRecognizer *)gest {
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.baseView removeFromSuperview];
}

@end

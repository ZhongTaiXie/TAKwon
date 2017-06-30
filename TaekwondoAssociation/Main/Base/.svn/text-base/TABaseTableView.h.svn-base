//
//  TABaseTableView.h
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^RefreshComponentHeaderRefreshingBlock)(void);
typedef void(^RefreshComponentFooterRefreshingBlock)(void);

typedef NS_ENUM(NSInteger , SMBaseTableViewRefreshState) {
    /**
     *  下刷
     */
    SMBaseTableViewRefreshStateHeader,
    /**
     *  上刷
     */
    SMBaseTableViewRefreshStateFooter
    
};

@interface TABaseTableView : UITableView

/**
 *  ofSection - 以第几个 section  为目标 page
 */
@property (nonatomic ,assign) NSInteger ofSection;
/**
 *  以分组计算
 */
@property (nonatomic ,assign) BOOL isSection;
/**
 *  分页
 */
@property (nonatomic ,assign) NSInteger page;

/**
 *  刷新模式
 */
@property (nonatomic ,assign) SMBaseTableViewRefreshState refreshState;


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;


/**
 *  设置刷新
 *
 *  @param componentHeaderRefreshingBlock 下刷成功回调
 *  @param componentFooterRefreshingBlock 上刷成功回调
 */
- (void)refreshHeaderRefresh:(RefreshComponentHeaderRefreshingBlock)componentHeaderRefreshingBlock  withFooterRefreshingBlock:(RefreshComponentFooterRefreshingBlock)componentFooterRefreshingBlock;

/**
 *  设置上拉加载更多
 *
 *  @param componentFooterRefreshingBlock 上刷成功回调
 */
- (void)refreshFooterRefresh:(RefreshComponentFooterRefreshingBlock)componentFooterRefreshingBlock;
///下拉
- (void)refreshheaderRefresh:(RefreshComponentFooterRefreshingBlock)componentHeaderRefreshingBlock;

/**
 *  主动刷新
 */
- (void)beginRefreshing;
/**
 *  结束刷新<结束下刷控件>
 */
- (void)endRefreshing;

/**
 *  刷新数据 <需要刷新数据的时候调用>
 */
- (void)endReload;



@end

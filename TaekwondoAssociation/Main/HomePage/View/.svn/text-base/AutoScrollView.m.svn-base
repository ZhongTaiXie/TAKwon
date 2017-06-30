//
//  AutoScrollView.m
//  project
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AutoScrollView.h"




@interface AutoScrollView ()<UIScrollViewDelegate>

{
    UIScrollView *_scrollView;
    NSTimer      *_timer;
    
    UIImageView  *_leftImageView;
    UIImageView  *_centerImageView;
    UIImageView  *_rightImageView;// 应该6张，但3张就可以啦
    
    NSArray      *_imageArray;
    UIPageControl *_pageController;
}
@end

@implementation AutoScrollView

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray*)imageArray
{
    if (self = [super initWithFrame:frame]) {
        
        _imageArray = imageArray;
        
        if (_imageArray.count <= 1) {
            return self;
        }
        
        
        [self createScrollView];
        [self createContentViews];
        [self createPageControl];
        
        [self startTimer];
    }
    
    return self;
}

- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(3*self.frame.size.width, self.frame.size.height);
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    [self addSubview:_scrollView];
}

- (void)createContentViews
{
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //  _leftImageView.backgroundColor = [UIColor redColor];
    _leftImageView.tag = _imageArray.count-1;
    
    _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    // _centerImageView.backgroundColor = [UIColor yellowColor];
//   添加手势
    _centerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    tap.numberOfTapsRequired = 1;
    [_centerImageView addGestureRecognizer:tap];
    _centerImageView.tag = 0;
    
    _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*2, 0, self.frame.size.width, self.frame.size.height)];
    _rightImageView.tag = 1;
    // _rightImageView.backgroundColor = [UIColor orangeColor];
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_centerImageView];
    [_scrollView addSubview:_rightImageView];
    
    _leftImageView.image   = [_imageArray objectAtIndex:_leftImageView.tag];
    _centerImageView.image = [_imageArray objectAtIndex:_centerImageView.tag];
    _rightImageView.image  = [_imageArray objectAtIndex:_rightImageView.tag];
    
}



- (void)createPageControl
{
    _pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    _pageController.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-10);
    _pageController.numberOfPages = _imageArray.count;
    _pageController.pageIndicatorTintColor = [UIColor whiteColor];
    _pageController.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:_pageController];
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    
//  在这里写被点击的事件
    NSLog(@"第%ld张图片被点击了",_pageController.currentPage);
  
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@(_pageController.currentPage),@"textOne", nil];

    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

- (void)updateContent
{
    
    if (_scrollView.contentOffset.x > self.frame.size.width) { //
        //next
        _leftImageView.tag   = _centerImageView.tag;
        _centerImageView.tag = _rightImageView.tag;
        _rightImageView.tag  = (_rightImageView.tag + 1)%_imageArray.count;
    }else if(_scrollView.contentOffset.x < self.frame.size.width)
    {
        //before
        _rightImageView.tag  = _centerImageView.tag;
        _centerImageView.tag = _leftImageView.tag;
        _leftImageView.tag   = (_leftImageView.tag - 1 + _imageArray.count)%_imageArray.count;
    }
    
    _leftImageView.image   = [_imageArray objectAtIndex:_leftImageView.tag];
    _centerImageView.image = [_imageArray objectAtIndex:_centerImageView.tag];
    _rightImageView.image  = [_imageArray objectAtIndex:_rightImageView.tag];
    
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    _pageController.currentPage = _centerImageView.tag;
}

- (void)startTimer
{
    if (_imageArray.count <= 1) return;
    
    [self stopTimer];
    
    //_timer = [[NSTimer alloc]initWithFireDate:nil interval:1 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)nextPage
{
    if (_scrollView.contentOffset.x != 0) {
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:YES];
    }
}

#pragma mark -
#pragma makr UIScollViewDeleage

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
    // NSLog(@"移动量 = %f",scrollView.contentOffset.x);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateContent];
}


@end

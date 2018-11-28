//
//  WYBannerView.m
//  WYBannerView
//
//  Created by wangyang on 2016/11/22.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "WYBannerView.h"
#define TimerInterval  3
#define WIDTH  self.frame.size.width
#define HEIGHT  self.frame.size.height

@interface WYBannerView ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation WYBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleToFill;
        [self layoutView];
    }
    return self;
}

- (void)setContentMode:(UIViewContentMode)contentMode {
    _contentMode = contentMode;
}

#pragma mark --
#pragma mark -- imgArray SET方法 --

#pragma mark -- 设置图片 使用时换成SDWebImage加载 --
- (void)setImgArray:(NSArray<NSString *> *)imgArray {
    _imgArray = imgArray;
    [self invalidateTimer];
    if (imgArray.count == 0) {
        return;
    }
    
    if (imgArray.count == 1) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        imageView.image = [UIImage imageNamed:imgArray[0]];
        imageView.tag = 100;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        imageView.contentMode = self.contentMode;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
        [imageView addGestureRecognizer:tap];
        [self.scrollView setContentSize:CGSizeMake(WIDTH, 0)];
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = imgArray.count;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgArray[0]] placeholderImage:nil completed:nil];
        return;
    }
    
    for (int i = 0; i < imgArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (i + 1), 0, WIDTH, HEIGHT)];
        imageView.tag = 100 + i;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        imageView.contentMode = self.contentMode;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
        [imageView addGestureRecognizer:tap];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgArray[i]] placeholderImage:nil completed:nil];
    }
    
    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.scrollView addSubview:firstImage];
    [self.scrollView setContentOffset:CGPointMake(WIDTH, 0)];
    firstImage.contentMode = self.contentMode;
    [firstImage sd_setImageWithURL:[NSURL URLWithString:[imgArray lastObject]] placeholderImage:nil completed:nil];
    
    UIImageView *lastImage = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (imgArray.count + 1), 0, WIDTH, HEIGHT)];
    [self.scrollView addSubview:lastImage];
    lastImage.contentMode = self.contentMode;
    [lastImage sd_setImageWithURL:[NSURL URLWithString:[imgArray firstObject]] placeholderImage:nil completed:nil];
    
    [self.scrollView setContentSize:CGSizeMake(WIDTH * (imgArray.count + 2), 0)];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = imgArray.count;
    [self initTimer];
}

#pragma mark -- 设置pageControl颜色 --
- (void)setPageColor:(UIColor *)pageColor {
    if (pageColor == nil) {
        pageColor = [UIColor blackColor];
    }
    _pageColor = pageColor;
    self.pageControl.pageIndicatorTintColor = pageColor;
}

#pragma mark -- 设置pageControl当前的颜色 --
- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    if (currentPageColor == nil) {
        currentPageColor = [UIColor whiteColor];
    }
    _currentPageColor = currentPageColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}

#pragma mark --
#pragma mark -- PRIVATE METHODS --
- (void)layoutView {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}
#pragma mark -- 创建定时器 --
- (void)initTimer {
    [self invalidateTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:TimerInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)invalidateTimer {
    [_timer invalidate];
    _timer = nil;
}
#pragma mark --
#pragma mark -- 定时器方法 --
- (void)nextImage {
    NSInteger index = self.pageControl.currentPage;
    if (index == _imgArray.count + 1) {
        index = 0;
    } else {
        index ++ ;
    }
    [self.scrollView setContentOffset:CGPointMake(WIDTH * (index + 1), 0) animated:YES];
}

#pragma mark --
#pragma mark -- WYBannerViewDelegate --

- (void)clickImageView:(UITapGestureRecognizer *)tap {
    NSInteger index = self.pageControl.currentPage;
    if ([_WYDelegate respondsToSelector:@selector(clickBannerViewWithTag:)]) {
        [_WYDelegate clickBannerViewWithTag:index];
    }
}

#pragma mark --
#pragma mark -- UIScrollViewDelegate -- 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = (self.scrollView.contentOffset.x + WIDTH * 0.5)/WIDTH;
    if (index == _imgArray.count + 2) {
        index = 1;
    } else if(index == 0) {
        index = _imgArray.count;
    }
    self.pageControl.currentPage = index-1;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self initTimer];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = (self.scrollView.contentOffset.x + WIDTH * 0.5)/WIDTH;
    
    if (index == _imgArray.count + 1) {
        [self.scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:NO];
    }else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(_imgArray.count * WIDTH, 0) animated:NO];
    }else{
        
    }
}
#pragma mark --
#pragma mark -- 懒加载创建控件 --

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 0, 4)];
        _pageControl.pageIndicatorTintColor = [UIColor blackColor];;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.center = POINT(WIDTH / 2.0, self.frame.origin.y + HEIGHT - 12);
    }
    return _pageControl;
}

@end

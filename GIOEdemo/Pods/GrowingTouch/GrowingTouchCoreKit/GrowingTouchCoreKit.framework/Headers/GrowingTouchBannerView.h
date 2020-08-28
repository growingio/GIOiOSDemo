//
//  GrowingTouchBannerView.h
//  GrowingTouchKit
//
//  Created by GrowingIO on 2019/8/22.
//  Copyright © 2019 com.growingio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, GrowingTouchBannerViewPageControlAlignment){
    
    GrowingTouchBannerViewPageControlAlignmentLeft,
    GrowingTouchBannerViewPageControlAlignmentRight,
    GrowingTouchBannerViewPageControlAlignmentCenter    //    default
    
};

typedef NS_ENUM (NSInteger, GrowingTouchBannerViewPageControlStyle){
    
    GrowingTouchBannerViewPageControlStyleSystem, //    default
    GrowingTouchBannerViewPageControlStyleNone
    
};

@class  GrowingTouchBannerView;
/**
 原生模板代理方法
 */
@protocol GrowingTouchBannerViewDelegate <NSObject>

@optional
/**
 banner 加载成功
 
 @param bannerView 对应的banner视图
 */
- (void)growingTouchBannerLoadSuccess:(GrowingTouchBannerView *) bannerView;

/**
 banner 加载失败
 
 @param bannerView 对应的banner视图
 @param error 失败error
 */
- (void)growingTouchBannerLoadFailed:(GrowingTouchBannerView *) bannerView error:(NSError *)error;

/**
 点击选中某一个banner视图,是否消费此次点击事件
 
 @param bannerView 对应的banner视图
 @param index banner 位置
 @param openUrl 跳转的链接
 @return 是否消费此次点击
 */
- (BOOL)growingTouchBanner:(GrowingTouchBannerView *) bannerView didSelectAtIndex:(NSInteger)index openUrl:(NSString *)openUrl;

/**
 视图展示方法
 
 @param bannerView 对应的banner视图
 @param index banner 位置
 */
- (void)growingTouchBanner:(GrowingTouchBannerView *) bannerView didShowAtIndex:(NSInteger)index;

/**
 banner视图加载失败未展示的默认点击事件

 @param bannerView 对应的banner视图
 */
- (void)growingTouchBannerErrorImageClick:(GrowingTouchBannerView *) bannerView;

@end

#pragma mark - GrowingTouchBannerView

@interface GrowingTouchBannerView : UIView

#pragma mark - properties

/** 轮播图的标识 */
@property (nonatomic, readonly, copy) NSString *bannerKey;
/** 轮播时间间隔 */
@property (nonatomic, assign) CGFloat scrollTimeInterval;
/** 自动轮播，默认YES*/
@property (nonatomic, assign) BOOL autoScroll;

#pragma mark - appearance Setting

/** pageControl 的样式，默认系统样式 */
@property (nonatomic, assign) GrowingTouchBannerViewPageControlStyle pageControlStyle;
/** pageControl 的位置 */
@property (nonatomic, assign) GrowingTouchBannerViewPageControlAlignment pageControlAlignment;
/** pageControl 未选中时的图片 */
@property (nonatomic, strong) UIImage *pageIndicatorImage;
/** pageControl 选中时的图片 */
@property (nonatomic, strong) UIImage *currentPageIndicatorImage;
/** pageControl 未选中的颜色 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
/** pageControl 选中的颜色 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/** pageControl 未选中的尺寸大小 */
@property (nonatomic, assign) CGSize pageIndicatorSize;
/** pageControl 选中的尺寸大小 */
@property (nonatomic, assign) CGSize currentPageIndicatorSize;
/** pageControl 间距大小 */
@property (nonatomic, assign) CGFloat pageIndicatorSpaing;
/** 轮播视图为空的默认错误视图 */
@property (nonatomic, strong) UIImage *bannerViewErrorImage;
/** 图片的填充模式,包括轮播图以及背景图 */
@property (nonatomic, assign) UIViewContentMode imageViewContentMode;

#pragma mark - methods

/**
 初始化方法
 
 @param frame 尺寸位置
 @param placeholderImage 展位图
 @return 返回初始化的实例
 */
+ (GrowingTouchBannerView *)bannerKey:(NSString*) bannerKey bannerFrame:(CGRect)frame placeholderImage:(UIImage *)placeholderImage;

/**
 加载数据

 @param delegate banner数据请求回调代理
 */
- (void)loadBannerWithDelegate:(id <GrowingTouchBannerViewDelegate>)delegate;

@end

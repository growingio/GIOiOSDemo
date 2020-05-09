//
//  GrowingTouchBannerData.h
//  GrowingTouchKit
//
//  Created by GrowingIO on 2019/8/29.
//  Copyright © 2019 com.growingio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GrowingTouchBannerItem : NSObject

/** 当前Item的名称 */
@property (nonatomic, copy) NSString *title;
/** 图片地址 */
@property (nonatomic, copy) NSString *imageUrl;
/** Item的索引，从0开始 */
@property (nonatomic, assign) NSUInteger index;

/**
item 绑定视图
@param itemView item绑定的视图
@param completedBlock 绑定视图点击的回调
*/
- (void)bindItemDataToClickView:(UIView *)itemView selectCompleted:(void(^)(NSString *openUrl, NSError *error)) completedBlock;

@end

@interface GrowingTouchBannerData : NSObject

/** Banner名称 */
@property (nonatomic, copy) NSString *name;
/** Banner 唯一标识*/
@property (nonatomic, copy) NSString *bannerKey;
/** Banner每一个条目数据 */
@property (nonatomic, strong) NSArray <GrowingTouchBannerItem *> *items;

@end


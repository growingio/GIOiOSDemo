//
//  HomeCell.h
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/4.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UIView
@property(nonatomic , strong) UIImageView *imageView ;
@property(nonatomic , strong) UILabel *titleLabel ;
@property(nonatomic , assign) int width ;
@property(nonatomic , assign) int height ;
@property(nonatomic , strong) GoodsModel *goodModel ;
-(void)upDateFrame:(CGRect )frame ;
@end

NS_ASSUME_NONNULL_END

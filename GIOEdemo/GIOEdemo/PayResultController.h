//
//  PayResultController.h
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayResultController : UIViewController
@property(nonatomic , strong) UIImageView *imageView ;
@property(nonatomic , strong) UILabel *numberLabel ;
@property(nonatomic , strong) UILabel *payWayLabel ;
@property(nonatomic , strong) UILabel *priceLabel ;
@property(nonatomic , strong) UILabel *discountLabel ;
@property(nonatomic , strong) UIButton *checkOrderBtn ;
@end

NS_ASSUME_NONNULL_END

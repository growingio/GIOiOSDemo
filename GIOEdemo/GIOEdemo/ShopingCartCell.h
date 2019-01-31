//
//  HomeCell.h
//  poetry
//
//  Created by GrowingIO on 2018/12/25.
//  Copyright © 2018年 min. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopingCartCell : UITableViewCell
//@property (nonatomic , strong) UIImageView *imageView ;
@property (nonatomic , strong) UILabel *titleLabel ;
@property (nonatomic , strong) UILabel *divideLabel ;
@property (nonatomic , strong) UIImageView *imageIcon;
-(void)updataCell:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

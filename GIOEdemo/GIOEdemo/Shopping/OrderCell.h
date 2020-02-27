//
//  OrderCell.h
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderCell : UITableViewCell
@property (nonatomic , strong) UILabel *numberLabel ;
@property (nonatomic , strong) UILabel *titleLabel ;
@property (nonatomic , strong) UILabel *divideLabel ;
@property (nonatomic , strong) UIImageView *imageIcon;
@property (nonatomic , strong) UIButton *stateBtn;
-(void)updateCell:(NSDictionary *)dict ;
@end

NS_ASSUME_NONNULL_END

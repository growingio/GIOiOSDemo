//
//  CashierDeskController.h
//  GIOGrowth
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CashierDeskController : UIViewController
@property(nonatomic ,strong) NSNumber *allPrice ;
@property(nonatomic ,strong) NSString *orderId_var;
@property(nonatomic ,strong) NSMutableArray *cartArray;
@end

NS_ASSUME_NONNULL_END

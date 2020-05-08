//
//  GoodsModel.h
//  GIOEdemo
//
//  Created by GrowingIO on 2019/1/25.
//  Copyright © 2019年 M. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsModel : NSObject
//增长ID
@property (nonatomic,strong)NSString *productId_var ;
//增长名称
@property (nonatomic,strong)NSString *productName_var ;
//流量位
@property (nonatomic,strong)NSString *floor_var ;
//搜索词
@property (nonatomic,strong)NSString *searchWord_var ;
//购买数量
@property (nonatomic,strong)NSNumber *buyQuantity_var ;
//增长id
@property (nonatomic,strong)NSString *orderId_var ;
//增长金额
@property (nonatomic,strong)NSString *orderAmount ;
//支付方式
@property (nonatomic,strong)NSString *paymentMethod_var ;
//实际支付金额
@property (nonatomic,strong)NSNumber *payAmount_var ;
//分享渠道
@property (nonatomic,strong)NSString *sharechannel ;
//价格
@property (nonatomic,strong)NSString *price_var ;

-(NSMutableDictionary *)modelTodic ;
@end

NS_ASSUME_NONNULL_END

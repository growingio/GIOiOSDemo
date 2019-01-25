//
//  GoodsModel.m
//  GIOEdemo
//
//  Created by GrowingIO on 2019/1/25.
//  Copyright © 2019年 M. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel
-(NSMutableDictionary *)modelTodic{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary] ;
    if (self.floor_var) {
        dict[@"floor_var"] = self.floor_var ;
    }
    if (self.productName_var) {
        dict[@"productName_var"] = self.productName_var ;
    }
    if (self.productId_var) {
        dict[@"productId_var"] = self.productId_var ;
    }
    if (self.searchWord_var) {
        dict[@"searchWord_var"] = self.searchWord_var ;
    }
    if (self.buyQuantity_var ) {
        dict[@"buyQuantity_var"] = self.buyQuantity_var ;
    }
    if (self.orderId_var ) {
        dict[@"orderId_var"] = self.orderId_var ;
    }
    if (self.orderAmount ) {
        dict[@"orderAmount"] = self.orderAmount ;
    }
    if (self.paymentMethod_var) {
        dict[@"paymentMethod_var"] = self.paymentMethod_var ;
    }
    if (self.payAmount_var ) {
        dict[@"payAmount_var"] = self.payAmount_var ;
    }
    if (self.sharechannel) {
        dict[@"sharechannel"] = self.sharechannel ;
    }
    if (self.price_var) {
        dict[@"price_var"] = self.price_var ;
    }
    return dict ;
}
@end

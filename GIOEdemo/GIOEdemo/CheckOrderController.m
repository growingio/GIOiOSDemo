//
//  CheckOrderController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "CheckOrderController.h"
#import "CashierDeskController.h"
#import "OrderCell.h"
#import "Growing.h"
#import "GoodsModel.h"
@interface CheckOrderController ()
@property(nonatomic,strong) GoodsModel *model;
@end

@implementation CheckOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"填写订单";
    [self makeImageView];
    [self makeBottomview];
}

-(void)makeImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 84, self.view.bounds.size.width, self.view.bounds.size.height - 84)];
    //    imageView.image = [UIImage imageNamed:@"backOrderDetail"];
    [self .view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    label.text = @"Simmon 186***1234";
    [imageView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(label.frame)+10, 200, 30)];
    label2.text = @"送至北京市朝阳区";
    [imageView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(label2.frame)+ 30, self.view.bounds.size.width , 0.5)];
    label3.backgroundColor = [UIColor lightGrayColor];
    [imageView addSubview:label3];
    
    OrderCell *cell = [[OrderCell alloc] init];
    cell.frame = CGRectMake(0, CGRectGetMaxY(label3.frame) , self.view.bounds.size.width, 120) ;
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone ;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"number"] = self.dataDict[@"number"];
    dict[@"productName_var"] = self.dataDict[@"name"];
    dict[@"price_var"] = self.dataDict[@"allPrice"];
    dict[@"state"] = self.dataDict[@"nil"];
    [cell updateCell:dict];
    cell.imageIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"image"]]] ;
    [imageView addSubview:cell];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(cell.frame)+ 30, self.view.bounds.size.width , 0.5)];
    label4.backgroundColor = [UIColor lightGrayColor];
    [imageView addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(label4.frame)+10, 200, 120)];
    label5.numberOfLines = 0 ;
    label5.text = @"支付配送  \n\n 在线支付\n GIO 快递";
    [imageView addSubview:label5];
    
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(label5.frame)+ 10, self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [imageView addSubview:label6];
    
    
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(label6.frame)+ 10, 300, 30)];
    label7.text = [NSString stringWithFormat:@"商品金额 ：¥%@",self.dataDict[@"allPrice"]];
    [imageView addSubview:label7];
    
    
    UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(label7.frame)+10, 200, 30)];
    label8.text = @"运费 ：¥0.00";
    [imageView addSubview:label8];
    
    
    
}

-(void)makeBottomview{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height  - 60 , self.view.bounds.size.width, 60)];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0,1 , self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:label6];
    
    
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame  =  CGRectMake(10, 0, 160 , 60);
    label.textColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    label.text = [NSString stringWithFormat:@"合计金额 ：¥%@",self.dataDict[@"allPrice"]];
    [view addSubview:label];
    view.layer.cornerRadius = 5 ;
    view.layer.masksToBounds = YES;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame  =  CGRectMake(self.view.bounds.size.width - 110, 10, 100 , 40);
    label2.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    label2.textColor = [UIColor whiteColor];
    label2.text = @"提交订单" ;
    label2.textAlignment = NSTextAlignmentCenter ;
    label2.layer.cornerRadius = 5 ;
    label2.layer.masksToBounds = YES;
    
    [view addSubview:label2];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tapGesturRecognizer];
    [self.view addSubview:view];
    
    
}


-(void)tapAction
{
    CashierDeskController *VC = [[CashierDeskController alloc] init];
    VC.cartArray = self.cartArray ;
    VC.allPice = self.dataDict[@"allPrice"];
    VC.orderId_var = self.dataDict[@"number"];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
    [self payOrder:self.dataDict];
    [self paySPU];
}




//打点开始
-(void)payOrder:(NSDictionary *)dict{
    self.model = [[GoodsModel alloc] init];
    self.model.orderId_var =  [[self.dataDict objectForKey:@"number"] description];
    self.model.productName_var = @"订单商品" ;
    self.model.paymentMethod_var = @"GIO支付" ;
    self.model.buyQuantity_var =  @"1" ;
    self.model.productId_var = self.dataDict[@"image"];
    [Growing track:@"payOrder" withVariable:[self.model modelTodic]];
}


-(void)paySPU{
    for (int i = 0 ; i < self.cartArray.count; i ++) {
        NSDictionary *dict = self.cartArray[i];
        [Growing track:@"paySPU" withVariable:dict];
    }
}

//打点结束

@end

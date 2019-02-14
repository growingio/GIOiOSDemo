//
//  CashierDeskController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "CashierDeskController.h"
#import "PayResultController.h"
#import "GoodsModel.h"
#import "Growing.h"
@interface CashierDeskController ()
@property(nonatomic ,strong) UIView *upView ;
@property(nonatomic ,strong) GoodsModel *model ;
@end

@implementation CashierDeskController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"收银台" ;
    [self makeUpview];
    [self makeMiddleview];
    [self makeBottomview];
}

-(void)makeUpview{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 84 , self.view.bounds.size.width, 60)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame  =  CGRectMake(10, 0, 160 , 60);
    label.textColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    label.text = [NSString stringWithFormat:@"订单金额：%@",self.allPice];
    [view addSubview:label];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(label.frame), self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:label6];
    
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame  =  CGRectMake(self.view.bounds.size.width - 100, 10, 80 , 40);
    //    label2.backgroundColor = [UIColor redColor];
    label2.textColor = [UIColor blackColor];
    label2.text = self.allPice ;
    label2.textAlignment = NSTextAlignmentCenter ;
    //    label2.layer.cornerRadius = 5 ;
    //    label2.layer.masksToBounds = YES;
    
    [view addSubview:label2];
    [self.view addSubview:view];
    self.upView = view;
    //    view.layer.borderColor = [UIColor blackColor].CGColor;
    //    view.layer.borderWidth = 1 ;
}
-(void)makeMiddleview{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.upView.frame), self.view.bounds.size.width  , 60)];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0,1, self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:label6];
    
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame  =  CGRectMake(10, 10, 160 , 30);
    label.textColor = [UIColor blackColor];
    label.text = @"GIO支付" ;
    [view addSubview:label];
    
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame  =  CGRectMake(self.view.bounds.size.width - 30, 10, 30 , 30);
    label2.textColor = [UIColor blackColor];
    label2.text = @">" ;
    [view addSubview:label2];
    [self.view addSubview:view];
}


-(void)makeBottomview{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - 60 , self.view.bounds.size.width, 60)];
    view.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    label.frame  = view.bounds;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter ;
    label.text = @"确认支付" ;
    [view addSubview:label];
    
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tapGesturRecognizer];
    [self.view addSubview:view];
    
    
    //    view.layer.borderColor = [UIColor blackColor].CGColor;
    //    view.layer.borderWidth = 1 ;
}


-(void)tapAction
{
    PayResultController *VC = [[PayResultController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
    [self payOrderSuccess];
    [self evar];
}

//打点开始
-(void)payOrderSuccess{
    self.model = [[GoodsModel alloc] init];
    self.model.paymentMethod_var = @"GIO支付" ;
    self.model.buyQuantity_var =  @"1" ;
    self.model.payAmount_var = self.allPice ;
    self.model.orderId_var = self.orderId_var ;
    [Growing track:@"payOrderSuccess" withVariable:[self.model modelTodic]];
    [self paySPUSucess];
}

-(void)paySPUSucess{
    for (int i = 0 ; i < self.cartArray.count; i ++) {
        NSDictionary *dict = self.cartArray[i];
        [Growing track:@"paySPUSucess" withVariable:dict];
    }
}


-(void)evar{
    for (int i = 0; i < self.cartArray.count ; i ++) {
        NSMutableDictionary *evars= [NSMutableDictionary dictionary];
        NSDictionary *dict = self.cartArray[i];
        if ([dict objectForKey:@"floor_evar"]) {
            evars[@"floor_evar"] = [dict objectForKey:@"floor_evar"];
        }else{
            evars[@"searchWord_evar"] = [dict objectForKey:@"productName_var"];
        }
        [Growing setEvar:evars];
    }
}

//打点结束

@end

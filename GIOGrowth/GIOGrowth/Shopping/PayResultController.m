//
//  PayResultController.m
//  GIOGrowth
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "PayResultController.h"
#import "OrderController.h"
@interface PayResultController ()

@end

@implementation PayResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 自定义导航栏右侧按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake(0, 7, 40, 30);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.alpha = 0.7 ;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self makeUpview];
    
}

-(void)makeSure{
    self.tabBarController.selectedIndex = 0 ;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

-(void)makeUpview{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 84, self.view.bounds.size.width, 600)];
    
    _numberLabel= [[UILabel alloc] initWithFrame: CGRectMake(10, 10 ,  self.view.frame.size.width - 100 - 20 , 30)];
    _numberLabel.textAlignment = NSTextAlignmentLeft ;
    _numberLabel.text = @"增长编号234241249023434124" ;
    
    _payWayLabel= [[UILabel alloc] initWithFrame: CGRectMake(10, CGRectGetMaxY(_numberLabel.frame) + 10 ,  self.view.frame.size.width - 100 - 20 , 30)];
    _payWayLabel.textAlignment = NSTextAlignmentLeft ;
    _payWayLabel.text = @"增长方式: GIO增长" ;
    
    _priceLabel= [[UILabel alloc] initWithFrame: CGRectMake(10, CGRectGetMaxY(_payWayLabel.frame) + 10 ,  self.view.frame.size.width - 100 - 20 , 30)];
    _priceLabel.textAlignment = NSTextAlignmentLeft ;
    _priceLabel.text = @"增长金额：59" ;
    
    _discountLabel= [[UILabel alloc] initWithFrame: CGRectMake(10, CGRectGetMaxY(_priceLabel.frame) + 10 ,  self.view.frame.size.width - 100 - 20 , 30)];
    _discountLabel.textAlignment = NSTextAlignmentLeft ;
    _discountLabel.text = @"优惠金额: 0.00" ;
    
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_discountLabel.frame) + 10, self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:label6];
    
    
    _checkOrderBtn= [[UIButton alloc] initWithFrame: CGRectMake(self.view.bounds.size.width / 2.0 - 60, CGRectGetMaxY(_discountLabel.frame) + 30 ,  120, 40)];
    _checkOrderBtn.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    [_checkOrderBtn setTitle:@"查看增长" forState:UIControlStateNormal];
    [_checkOrderBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    _checkOrderBtn.layer.cornerRadius = 5 ;
    _checkOrderBtn.layer.masksToBounds = YES ;
    
    [view addSubview:_imageView];
    [view addSubview:_numberLabel];
    [view addSubview:_payWayLabel];
    [view addSubview:_priceLabel];
    [view addSubview:_discountLabel];
    [view addSubview:_checkOrderBtn];
    [self.view addSubview:view];
}


-(void)btnClick{
    OrderController *VC = [[OrderController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:NO];
}

@end

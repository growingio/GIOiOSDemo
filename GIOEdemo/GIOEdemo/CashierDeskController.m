//
//  CashierDeskController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "CashierDeskController.h"
#import "PayResultController.h"
@interface CashierDeskController ()
@property(nonatomic ,strong) UIView *upView ;
@end

@implementation CashierDeskController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    label.text = @"订单金额：59.00 " ;
    [view addSubview:label];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(label.frame), self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:label6];
    
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame  =  CGRectMake(self.view.bounds.size.width - 100, 10, 80 , 40);
//    label2.backgroundColor = [UIColor redColor];
    label2.textColor = [UIColor blackColor];
    label2.text = @"59.00" ;
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
    label2.frame  =  CGRectMake(self.view.bounds.size.width - 60, 10, 30 , 30);
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
}

@end

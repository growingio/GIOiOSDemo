//
//  ShoppingCartController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//
#define RGBCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]
#define RGBCOLORVA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#import "ShoppingCartController.h"
#import "ShopingCartCell.h"
#import "CheckOrderController.h"
#import "Growing.h"
@interface ShoppingCartController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView ;
@property (nonatomic , strong) NSMutableArray *cartArray ;
@property (nonatomic , assign) int allPrice ;
@property (nonatomic , strong) UILabel *allPriceLabel ;
@end

@implementation ShoppingCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
    self.tableView.delegate = self ;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
//    self.title = @"购物车" ;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"购物车" ;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    [self getCartData];
    [self makeGoPay];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    int price = 0 ;
    for (int i = 0 ; i < self.cartArray.count; i ++) {
        NSDictionary *dict = self.cartArray[i] ;
        price += [dict[@"price_var"] intValue];
    }
    self.allPrice = price ;
    self.allPriceLabel.text = [NSString stringWithFormat:@"合计：%d",self.allPrice];
    [self getCartData];
    [self.tableView reloadData];
}

-(void)makeGoPay{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - 49 - CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width, 60)];
    //    view.backgroundColor = [UIColor blackColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame  =  CGRectMake(10, 0, 160 , 60);
    label.textColor = [UIColor blackColor];
    self.allPriceLabel = label ;
    int price = 0 ;
    for (int i = 0 ; i < self.cartArray.count; i ++) {
        NSDictionary *dict = self.cartArray[i] ;
        price += [dict[@"price_var"] intValue];
    }
    self.allPrice = price ;
    label.text = [NSString stringWithFormat:@"合计：%d",price];
    [view addSubview:label];
    view.layer.cornerRadius = 5 ;
    view.layer.masksToBounds = YES;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame  =  CGRectMake(self.view.bounds.size.width - 110, 10, 100 , 40);
    label2.textColor = [UIColor whiteColor];
    label2.text = @"去结算" ;
    label2.textAlignment = NSTextAlignmentCenter ;
    label2.layer.cornerRadius = 5 ;
    label2.layer.masksToBounds = YES ;
    label2.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    [view addSubview:label2];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tapGesturRecognizer];
    
    UIView *divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.5)];
    divideView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:divideView];
    [self.view addSubview:view];
}


-(void)tapAction
{
    if (!self.cartArray.count) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先添加商品" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alert show];
        return ;
    }
    CheckOrderController *VC = [[CheckOrderController alloc] init];
    VC.cartArray = self.cartArray ;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"image"] = @"chore1" ;
    dict[@"number"] = [NSString stringWithFormat:@"%u",arc4random()%1000000000];
    dict[@"allPrice"] = [NSString stringWithFormat:@"%d",self.allPrice];
    dict[@"name"] = @"优惠商品";
    VC.dataDict = dict ;
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
    [self checkOut];
}
//打点开始
-(void)checkOut{
    for (int i = 0 ; i < self.cartArray.count; i ++) {
        NSDictionary *dict = self.cartArray[i];
        NSMutableDictionary *mutDict = dict.mutableCopy;
        mutDict[@"buyQuantity_var"] = @1;
        mutDict[@"payAmount_var"] = [NSNumber numberWithFloat:[dict[@"price_var"] floatValue]];
        [mutDict removeObjectForKey:@"floor_var"];
        [mutDict removeObjectForKey:@"price_var"];
        [Growing track:@"checkOut" withVariable:mutDict];
    }
}
//打点结束

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.cartArray[indexPath.row];
    ShopingCartCell *cell = [[ShopingCartCell alloc] init];
    cell.backgroundColor = [UIColor whiteColor];
    cell.divideLabel.textAlignment = NSTextAlignmentLeft ;
    [cell updataCell:dict];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone ;
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0,120, self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:label6];
    return cell ;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cartArray.count ;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120 ;
}


-(void)getCartData{
    //读取数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *cartArray ;
    if ([defaults objectForKey:@"cartArray"]) {
        cartArray = [defaults objectForKey:@"cartArray"];
    }else{
        cartArray = [NSMutableArray array];
    }
    self.cartArray = cartArray ;
}
@end

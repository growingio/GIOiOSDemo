//
//  ShoppingCartController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

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
    self.navigationItem.title = @"购物车" ;
    
    [self.view addSubview:self.tableView];
    
    [self addNotification];
    
    [self makeGoPay];
    
    [self updateShoppingCart];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateShoppingCart)
                                                 name:@"kShoppingCartDidUpdatedNotification"
                                               object:nil];
}

- (void)updateShoppingCart {
    [self getCartData];
    
    int price = 0 ;
    for (int i = 0 ; i < self.cartArray.count; i ++) {
        NSDictionary *dict = self.cartArray[i] ;
        price += [dict[@"price_var"] intValue];
    }
    self.allPrice = price ;
    self.allPriceLabel.text = [NSString stringWithFormat:@"合计：%d",self.allPrice];
    [self.tableView reloadData];
}

-(void)makeGoPay{
    CGFloat checkViewH = 60;
    CGFloat checkViewY = self.view.frame.size.height - checkViewH - CGRectGetMaxY(self.navigationController.navigationBar.frame);
    if ([self iPhoneXSerial]) {
        checkViewY -= 40;
    }
    UIView *checkView = [[UIView alloc] initWithFrame:CGRectMake(0,  checkViewY, self.view.bounds.size.width, checkViewH)];
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
    [checkView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame  =  CGRectMake(self.view.bounds.size.width - 110, 10, 100 , 40);
    label2.textColor = [UIColor whiteColor];
    label2.text = @"去结算" ;
    label2.textAlignment = NSTextAlignmentCenter ;
    label2.layer.cornerRadius = 5 ;
    label2.layer.masksToBounds = YES ;
    label2.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    [checkView addSubview:label2];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [checkView addGestureRecognizer:tapGesturRecognizer];
    
    UIView *divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.5)];
    divideView.backgroundColor = [UIColor lightGrayColor];
    [checkView addSubview:divideView];
    [self.view addSubview:checkView];
}

- (BOOL)iPhoneXSerial {
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
           case 2436:
                return YES;
            case 2688:
                return YES;
            default:
               return NO;
        }
    }
    return NO;
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

-(void)getCartData{
    //读取数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *cartArray ;
    if ([defaults objectForKey:@"cartArray"]) {
        NSArray *tempArray = [defaults objectForKey:@"cartArray"];
        cartArray = [NSMutableArray arrayWithArray:tempArray];
    }else{
        cartArray = [NSMutableArray array];
    }
    self.cartArray = cartArray ;
}

#pragma mark UITableViewDelegate, UITableViewDataSource

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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.cartArray removeObjectAtIndex:indexPath.row];
        NSIndexSet *sections = [[NSIndexSet alloc] initWithIndex:0];
        [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.cartArray forKey:@"cartArray"];
        [defaults synchronize];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
        _tableView.delegate = self ;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = 120;
    }
    return _tableView;
}

@end

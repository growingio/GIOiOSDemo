//
//  ClassifyController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "ClassifyController.h"
#import "HomeCell.h"
#import "SearchViewController.h"
#import "GoodsDetailController.h"
#import "Growing.h"
@interface ClassifyController ()
@property (nonatomic ,strong) UIView *rightView ;
@property (nonatomic ,strong) UIButton *chooseBtn ;
@property (nonatomic ,strong) NSMutableArray *allDataArray;
@property (nonatomic ,strong) NSMutableArray *dataArray1;
@property (nonatomic ,strong) NSMutableArray *dataArray2;
@property (nonatomic ,strong) NSMutableArray *dataArray3;
@end

@implementation ClassifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 0,220, 20)];
    [btn setTitle:@"GIO 马克杯" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,120)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self makeData];
    UIImageView *imaview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imaview.image = [UIImage imageNamed:@"搜索"];
    [view addSubview:imaview];
    [view addSubview:btn];
    self.navigationItem.titleView = view ;
    [self  makeLeftView];
    [self makeRightView];
}

-(void)makeLeftView{
    UIView *leftView  = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame) + 150 , 100, self.view.bounds.size.height )];
    leftView.backgroundColor = [UIColor whiteColor];
    UIView *divideView = [[UIView alloc] initWithFrame:CGRectMake(99, 0, 0.5, CGRectGetHeight(leftView.frame))];
    divideView.backgroundColor = [UIColor blackColor];
    [leftView addSubview:divideView];
    [self.view addSubview:leftView];
    NSArray *array = [NSArray arrayWithObjects:@"为您推荐",@"电子产品", @"生活用品",@"服装",nil];
    
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0 , i * 60 , 100 , 60)];
        btn.tag = i ;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i ==  0) {
            self.chooseBtn = btn ;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 3, 40)];
            label.tag = 6666 ;
            label.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
            [self.chooseBtn addSubview:label];
        }
        [leftView addSubview:btn];
        [btn addTarget:self action:@selector(btnCLick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)makeRightView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width , 150)];
    imageView.image = [UIImage imageNamed:@"11"];
    [self.view addSubview:imageView];
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(imageView.frame), self.view.bounds.size.width - 100, self.view.bounds.size.height - 180)];
    UIView *cellView =  [self makeCellArray:self.allDataArray];
    cellView.frame = CGRectMake(0, 15,  self.view.bounds.size.width - 100, 420);
    [self.rightView addSubview:cellView];
    [self.view addSubview:self.rightView];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionHead)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapGesturRecognizer];
    
}

-(void)tapActionHead
{
    GoodsDetailController *VC = [[GoodsDetailController alloc] init];
    VC.goodModel = [self.allDataArray lastObject];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
    [self listingPageGoodsClick:[VC.goodModel modelTodic]];
}


-(UIView *)makeCellArray:(NSArray *)array{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < array.count; i ++) {
        HomeCell *cell = [[HomeCell alloc] initWithFrame:CGRectMake(10 +(self.view.bounds.size.width - 140)/3.0  *  (i % 3) + (i % 3) * 10 ,i / 3 * (120 + 10), (self.view.bounds.size.width - 140)/3.0 , 120)];
        GoodsModel *model = array[i] ;
        cell.height = 90  ;
        cell.width  = (self.view.bounds.size.width - 140)/3.0  ;
        cell.imageView.image = [UIImage imageNamed:model.productId_var] ;
        cell.titleLabel.textAlignment = NSTextAlignmentCenter ;
        cell.titleLabel.text = model.productName_var;
        cell.goodModel = model ;
        [view addSubview:cell];
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [cell addGestureRecognizer:tapGesturRecognizer];
    }
    return view ;
}



-(void)btnCLick:(UIButton *)btn{
    for (UIView *label in self.chooseBtn.subviews) {
        if ([label isKindOfClass:[UILabel class]] && (label.tag == 6666)) {
            [label removeFromSuperview];
        }
    }
    self.chooseBtn = btn ;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 3, 40)];
    label.tag = 6666 ;
    label.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    [self.chooseBtn addSubview:label];
    
    [self.rightView removeFromSuperview];
    self.rightView = nil ;
    self.rightView =  [[UIView alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 150, self.view.bounds.size.width - 100, self.view.bounds.size.height - 180)];
    [self.view addSubview:self.rightView];
    switch (btn.tag) {
        case 0:
        {
            UIView *cellView =  [self makeCellArray:self.allDataArray];
            cellView.frame = CGRectMake(0 ,  10,  self.view.bounds.size.width - 100, 420);
            [self.rightView addSubview:cellView];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"为您推荐",@"productListType_pvar", nil];
            [self productListType_pvar:dict];
        }
            break;
        case 1:
        {
            UIView *cellView =  [self makeCellArray:self.dataArray1];
            cellView.frame = CGRectMake(0 , 10 ,  self.view.bounds.size.width - 100, 120);
            [self.rightView addSubview:cellView];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"电子产品",@"productListType_pvar", nil];
            [self productListType_pvar:dict];
        }
            break;
        case 2:
        {
            UIView *cellView =  [self makeCellArray:self.dataArray2];
            cellView.frame = CGRectMake(0,10 ,  self.view.bounds.size.width - 100, 120);
            [self.rightView addSubview:cellView];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"生活用品",@"productListType_pvar", nil];
            [self productListType_pvar:dict];
        }
            break;
        case 3:
        {
            UIView *cellView =  [self makeCellArray:self.dataArray3];
            cellView.frame = CGRectMake(0 ,10,  self.view.bounds.size.width - 100, 120);
            [self.rightView addSubview:cellView];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"服装",@"productListType_pvar", nil];
            [self productListType_pvar:dict];
        }
            break;
        default:
            break;
    }
}


-(void)tapAction:(id)sender
{
    GoodsDetailController *VC = [[GoodsDetailController alloc] init];
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    HomeCell *cell = (HomeCell *)tap.view;
    VC.goodModel =  cell.goodModel ;
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
    [self listingPageGoodsClick:[cell.goodModel modelTodic]];
}


//打点开始
-(void)listingPageGoodsClick:(NSDictionary *)dict{
    [Growing track:@"listingPageGoodsClick" withVariable:dict];
}

-(void)productListType_pvar:(NSDictionary *)dict{
  [Growing setPageVariable:dict toViewController:self];
}

//打点结束
-(void)btnClick{
    SearchViewController *VC = [[SearchViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC  animated:NO];
}


-(void)makeData{
    NSMutableArray *allNameArray = [NSMutableArray arrayWithObjects:@"渠道流量分析",@"产品经理数据分析",@"增长黑客手册",@"GIO马克杯",@"GIO文化衫", nil];
    NSMutableArray *priceArray = [NSMutableArray arrayWithObjects:@"59",@"39",@"36",@"59",@"89", nil];
    self.allDataArray = [[NSMutableArray alloc] init];
    self.dataArray1 = [[NSMutableArray alloc] init];
    self.dataArray2 = [[NSMutableArray alloc] init];
    self.dataArray3 = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 5 ; i ++ ) {
        GoodsModel *model = [[GoodsModel alloc] init];
        model.productId_var = [NSString stringWithFormat:@"00%d",i+1];
        model.productName_var = allNameArray[i];
        model.price_var = priceArray[i];
        model.floor_var = @"首页" ;
        [self.allDataArray addObject:model];
        if (i < 2) {
            [self.dataArray1 addObject:model];
        }else if(i >= 2 && i< 4){
            [self.dataArray2 addObject:model];
        }else if(i == 4){
            [self.dataArray3 addObject:model];
        }
    }
}

@end

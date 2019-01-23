//
//  GoodsDetailController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "GoodsDetailController.h"
#import "OrderCell.h"
#import "HomeCell.h"
#import "JudgeController.h"
@interface GoodsDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView ;
@property (nonatomic , strong) NSMutableArray *dataArray ;
@property (nonatomic , strong) NSMutableArray *titleArray;

@end

@implementation GoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.tableView.delegate = self ;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self setData];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 500)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 400)];
    imageView.image = [UIImage imageNamed:@"product_detail"];
    [headerView addSubview:imageView];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame) + 10, 150 , 30)];
    titleLabel.text = @"GIO LOGO 马克杯" ;
    [headerView addSubview:titleLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame) , 150 , 30)];
    priceLabel.text = @"99.99" ;
    priceLabel.textColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    [headerView addSubview:priceLabel];
    
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(priceLabel.frame) , 150 , 30)];
    addressLabel.text = @"送至北京市 朝阳区" ;
    [headerView addSubview:addressLabel];
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView =  [self makeFooterView];
    
    [self makeBottomview];
}



-(void)makeBottomview{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - 80, self.view.bounds.size.width , 80)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *btnLeft = [[UIButton alloc] init];
    btnLeft.backgroundColor = [UIColor whiteColor];
    btnLeft.frame  = CGRectMake(0, 0, self.view.bounds.size.width /2.0 - 10, 60);
    btnLeft.titleLabel.textAlignment = NSTextAlignmentCenter ;
    btnLeft.layer.masksToBounds = YES ;
    btnLeft.layer.cornerRadius = 5 ;
    btnLeft.layer.borderColor = [UIColor blackColor].CGColor;
    btnLeft.layer.borderWidth = 1 ;
    [btnLeft setTitle:@"加入购物车" forState:UIControlStateNormal];
    [btnLeft setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(btnLeftCLick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnLeft];

    UIButton *btnRight = [[UIButton alloc] init];
    btnRight.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    btnRight.frame  = CGRectMake(self.view.bounds.size.width /2.0 + 10 , 0, self.view.bounds.size.width /2.0  - 10, 60);
    btnRight.titleLabel.textColor = [UIColor whiteColor];
    btnRight.titleLabel.textAlignment = NSTextAlignmentCenter ;
    [btnRight setTitle:@"立即购买" forState:UIControlStateNormal];
    btnRight.layer.masksToBounds = YES ;
    btnRight.layer.cornerRadius = 5 ;
    [btnRight addTarget:self action:@selector(btnRightCLick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnRight];
    [self.view addSubview:view];
}

-(void)btnLeftCLick{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加购物车成功" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)btnRightCLick{
    self.tabBarController.selectedIndex = 2 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 20 , 160)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:label6];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame  =  CGRectMake(10, 10, 160 , 60);
    label.textColor = [UIColor blackColor];
    label.text = @"宝贝评价(299)" ;
    [view addSubview:label];
    view.layer.cornerRadius = 5 ;
    view.layer.masksToBounds = YES;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame  =  CGRectMake(self.view.bounds.size.width - 120, 10, 120 , 60);
    label2.textColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    label2.text = @"查看全部 >" ;
    [view addSubview:label2];

    UILabel *label3 = [[UILabel alloc] init];
    label3.frame  =  CGRectMake(10,  60 , 160 , 20);
    label3.textColor = [UIColor blackColor];
    label3.text = @"GIO" ;
    [view addSubview:label3];

    UILabel *label4 = [[UILabel alloc] init];
    label4.frame  =  CGRectMake(10,  80, self.view.bounds.size.width - 40 , 60);
    label4.textColor = [UIColor blackColor];
    label4.numberOfLines = 0 ;
    label4.text = @"外观非常漂亮，使用起来也很流畅，大品牌非常好用，送货也很及时，包装很好" ;
    [view addSubview:label4];
    
    
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2)];
    [view addGestureRecognizer:tapGesturRecognizer];
    
    
    cell.selectionStyle =  UITableViewCellSelectionStyleNone ;
    [cell addSubview:view];
    return cell  ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

-(void)setData{
    self.dataArray =[NSMutableArray arrayWithObjects:@"GIO 商品",@"GIO 商品",@"GIO 商品",@"GIO 商品",nil];
    self.titleArray = [NSMutableArray arrayWithObjects:@"¥599.00", @"¥5,799.00", @"¥59.00",@"¥599.00",@"¥59.00",nil] ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180 ;
}



-(UIView *)makeFooterView{
        UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 100 , self.view.bounds.size.width , 260)];
    
        UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, self.view.bounds.size.width - 20 , 0.5)];
        label6.backgroundColor = [UIColor lightGrayColor];
        [footerView addSubview:label6];
    
        UILabel *upLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0 , self.view.bounds.size.width - 40, 30)];
        upLabel.textAlignment = NSTextAlignmentLeft ;
        upLabel.text = @"推荐" ;
        [footerView addSubview:upLabel];
        
        footerView.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < 2; i ++) {
            
            HomeCell *cell = [[HomeCell alloc] initWithFrame:CGRectMake(i *  (self.view.bounds.size.width - 40 - 40)/2.0 + 20 + i* 10 ,40, (self.view.bounds.size.width - 40 - 40)/2.0 , 200 - 40 - 20 )];
            cell.height = 130 ;
            cell.width  = 150 ;
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"suggest%d",i+1]];
            UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
            [cell addGestureRecognizer:tapGesturRecognizer];
            
            cell.titleLabel.textAlignment = NSTextAlignmentCenter ;
//            switch (i) {
//                case 0:
//                {
//                    cell.titleLabel.text  = @"红色特别版gpphone" ;
//                }
//                    break;
//                case 1:
//                {
//                    cell.titleLabel.text  = @"128g gophone" ;
//                }
//                    break;
//                default:
//                    break;
//            }
            [footerView addSubview:cell];
        }
    return footerView ;
}


-(void)tapAction
{
    GoodsDetailController *VC = [[GoodsDetailController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)tapAction2
{
    JudgeController *VC = [[JudgeController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:NO];
}

@end

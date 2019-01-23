//
//  MineController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "MineController.h"
#import "OrderController.h"
@interface MineController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UIView *view1;
@property (nonatomic ,strong) UIView *view2;
@property (nonatomic ,strong) UIView *view3;
@property (nonatomic ,strong) UIView *view4;
@property (nonatomic ,strong) NSArray *dataArray ;
@property(nonatomic ,strong) UITableView *tableView;
@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self  makeTitleView];
    self.dataArray = [NSArray arrayWithObjects:@"积分",@"会员等级",@"我的订单",@"红包",@"地址",nil];
//    [self makeUpview];
//    [self makeMiddleView];
//    [self makeBottomView];
}

-(void)makeTitleView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width, 80)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.frame  =  CGRectMake(15, 10, 200,60);
    leftLabel.backgroundColor =[UIColor whiteColor];
    leftLabel.text = @"GIO 小颖";
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.textAlignment = NSTextAlignmentLeft ;
    leftLabel.layer.cornerRadius = 5 ;
    leftLabel.layer.masksToBounds = YES;
    [view addSubview:leftLabel];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame  =  CGRectMake(self.view.bounds.size.width - 80, 10, 60 , 60);
    imageView.layer.masksToBounds = YES ;
    imageView.layer.cornerRadius = 30 ;
    imageView.image = [UIImage imageNamed:@"mine_icon"];
    [view addSubview:imageView];
    
//
//    UILabel *rightLabel = [[UILabel alloc] init];
//    rightLabel.frame  =  CGRectMake(self.view.bounds.size.width / 2.0 + 20, 0, (self.view.bounds.size.width - 60) / 2.0  , 70);
//    rightLabel.backgroundColor =[UIColor whiteColor];
//    rightLabel.text = @"会员等级 \n 金牌";
//    rightLabel.textAlignment = NSTextAlignmentCenter ;
//    rightLabel.textColor = [UIColor blackColor];
//    rightLabel.layer.cornerRadius = 5 ;
//    rightLabel.layer.masksToBounds = YES;
//    [view addSubview:rightLabel];
    self.view1 = view ;
    [self.view addSubview:view];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        [self tapAction];
    }
}


-(void)makeUpview{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.view1.frame) + 50, self.view.bounds.size.width - 20 , 80)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame  =  CGRectMake(10, 10, 160 , 60);
    label.textColor = [UIColor blackColor];
    label.text = @"我的订单" ;
    [view addSubview:label];
    view.layer.cornerRadius = 5 ;
    view.layer.masksToBounds = YES;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame  =  CGRectMake(self.view.bounds.size.width - 60, 10, 60 , 60);
    label2.textColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    label2.text = @">" ;
    [view addSubview:label2];
    self.view2 = view ;
    [self.view addSubview:view];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tapGesturRecognizer];
}
    
    
-(void)tapAction
{
    OrderController *VC = [[OrderController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
}
    
    
    

-(void)makeMiddleView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(self.view2.frame) + 10, self.view.bounds.size.width - 20 , 180)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame  =  CGRectMake(10, 10, 160 , 60);
    label.textColor = [UIColor blackColor];
    label.text = @"我的红包" ;
    [view addSubview:label];

    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame  =  CGRectMake(self.view.bounds.size.width / 2.0 - 30, 60, 60 , 60);
    imageView.image = [UIImage  imageNamed:@"palceImage"];
    [view addSubview:imageView];
    
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame  =  CGRectMake(10, 120, self.view.bounds.size.width - 20 , 60);
    label2.textColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    label2.text = @"¥ 20" ;
    label2.textAlignment = NSTextAlignmentCenter ;
    [view addSubview:label2];
    
    view.layer.cornerRadius = 5 ;
    view.layer.masksToBounds = YES;
    self.view3 = view ;
    [self.view addSubview:view];
    
}

-(void)makeBottomView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(self.view3.frame) + 10, self.view.bounds.size.width - 20 , 80)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame  =  CGRectMake(10, 10, 160 , 30);
    label.textColor = [UIColor blackColor];
    label.text = @"我的地址" ;
    [view addSubview:label];

    UILabel *label2 = [[UILabel alloc] init];
    label2.frame  =  CGRectMake(10, 30, 360 , 60);
    label2.textColor = [UIColor blackColor];
    label2.text = @"北京市 朝阳区 宝能中心" ;
    [view addSubview:label2];
    
    view.layer.cornerRadius = 5 ;
    view.layer.masksToBounds = YES;
    self.view4 = view ;
    [self.view addSubview:view];
}



@end

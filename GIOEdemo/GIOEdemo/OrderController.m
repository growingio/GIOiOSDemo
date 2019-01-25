//
//  OrderController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "OrderController.h"
#import "OrderCell.h"
@interface OrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView ;
@property (nonatomic , strong) NSMutableArray *dataArray ;
@property (nonatomic , strong) NSMutableArray *dataAllArrays ;
@property (nonatomic , strong) NSMutableArray *dataPrePayArrays ;
@property (nonatomic , strong) NSMutableArray *dataSendArrays ;
@property (nonatomic , strong) NSMutableArray *dataRecieveArrays ;
@property (nonatomic , strong) NSMutableArray *titleArray;
@property (nonatomic ,strong) UIButton *chooseBtn ;
@end

@implementation OrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    self.dataAllArrays  = [NSMutableArray array];
    self.dataSendArrays  = [NSMutableArray array];
    self.dataPrePayArrays  = [NSMutableArray array];
    self.dataRecieveArrays  = [NSMutableArray array];
    NSDictionary *dict = @{@"number":@"订单编号：6234542819",@"title":@"GIO 商品",@"monney":@"¥99.00",@"state":@"待付款",};
    [self.dataAllArrays addObject:dict];
    [self.dataPrePayArrays addObject:dict];
    NSDictionary *dict2 = @{@"number":@"订单编号：6234542234",@"title":@"GIO 商品",@"monney":@"¥59.00",@"state":@"配送中",};
    [self.dataAllArrays addObject:dict2];
    [self.dataSendArrays addObject:dict2];
    NSDictionary *dict3 = @{@"number":@"订单编号：62345421232",@"title":@"GIO 商品",@"monney":@"¥799.00",@"state":@"已收货",};
    [self.dataRecieveArrays addObject:dict3];
    [self.dataAllArrays addObject:dict3];
    self.dataArray = [self.dataAllArrays mutableCopy];
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i *  self.view.bounds.size.width /4.0 ,CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width /4.0 , 40)];
        [self.view addSubview:btn];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i ;
        if (i ==  0) {
            self.chooseBtn = btn ;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 37,self.view.bounds.size.width /4.0 ,3)];
            label.tag = 6666 ;
            label.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
            [self.chooseBtn addSubview:label];
        }
        switch (i) {
            case 0:
            {
                [btn setTitle:@"全部"  forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                [btn setTitle:@"代付款" forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                [btn setTitle:@"配送中" forState:UIControlStateNormal];
            }
                break;
            case 3:
            {
                [btn setTitle:@"已收货" forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 40, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
    self.tableView.delegate = self ;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [[OrderCell alloc] init];
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0,1, self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:label6];
    cell.imageIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"order%d",indexPath.row + 1]] ;
    cell.selectionStyle =  UITableViewCellSelectionStyleNone ;
    NSDictionary *dict = self.dataArray[indexPath.row];
    [cell updateCell:dict];
    return cell ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count ;
}


//-(void)setData{
//    self.dataArray =[NSMutableArray arrayWithObjects:@"gphone 128G 红色特别版 4G手机",@"gphone 128G 红色特别版 4G手机",@"gphone 128G 红色特别版 4G手机",@"haha",@"haha",nil];
//    self.titleArray = [NSMutableArray arrayWithObjects:@"¥5,799.00", @"¥5,799.00", @"¥5,799.00",@"¥5,799.00",@"¥5,799.00",nil] ;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160 ;
}

-(void)btnClick:(UIButton *)btn{
    for (UIView *label in self.chooseBtn.subviews) {
        if ([label isKindOfClass:[UILabel class]] && (label.tag == 6666)) {
            [label removeFromSuperview];
        }
    }
    self.chooseBtn = btn ;
    UILabel *label =  [[UILabel alloc] initWithFrame:CGRectMake(0, 37,self.view.bounds.size.width /4.0 ,3)];
    label.tag = 6666 ;
    label.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    [self.chooseBtn addSubview:label];
    
    [self.dataArray removeAllObjects];
    switch (btn.tag) {
        case 0:
        {
            self.dataArray = [self.dataAllArrays mutableCopy];
        }
            break;
        case 1:
        {
            self.dataArray = [self.dataPrePayArrays mutableCopy] ;
        }
            break;
        case 2:
        {
            self.dataArray = [self.dataSendArrays mutableCopy];
        }
            break;
        case 3:
        {
            self.dataArray = [self.dataRecieveArrays mutableCopy];
        }
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}
@end

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
    self.title = @"我的增长" ;
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    self.dataAllArrays  = [NSMutableArray array];
    self.dataSendArrays  = [NSMutableArray array];
    self.dataPrePayArrays  = [NSMutableArray array];
    self.dataRecieveArrays  = [NSMutableArray array];
    
    
    NSDictionary *dict = @{@"productId_var":@"增长编号：6234542819",@"productName_var":@"GIO 物品",@"price_var":@"¥99.00",@"state":@"待增长",};
    [self.dataAllArrays addObject:dict];
    [self.dataPrePayArrays addObject:dict];
    NSDictionary *dict2 = @{@"productId_var":@"增长编号：6234542234",@"productName_var":@"GIO 物品",@"price_var":@"¥59.00",@"state":@"增长中",};
    [self.dataAllArrays addObject:dict2];
    [self.dataSendArrays addObject:dict2];
    NSDictionary *dict3 = @{@"productId_var":@"增长编号：62345421232",@"productName_var":@"GIO 物品",@"price_var":@"¥799.00",@"state":@"已增长",};
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
                [btn setTitle:@"待增长" forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                [btn setTitle:@"增长中" forState:UIControlStateNormal];
            }
                break;
            case 3:
            {
                [btn setTitle:@"已增长" forState:UIControlStateNormal];
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
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0,10, self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [footerView addSubview:label6];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label6.frame) + 20 , self.view.bounds.size.width, 20)];
    titleLabel.text = @"增长信息" ;
    [footerView addSubview:titleLabel];
    self.tableView.tableFooterView = footerView ;
    self.tableView.tableFooterView.hidden = YES ;
    
    UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 20 , self.view.bounds.size.width, 20)];
    Label2.text = @"已经到达中转中心，预计明天开始增长" ;
    [footerView addSubview:Label2];

    UILabel *Label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(Label2.frame) + 5, self.view.bounds.size.width, 20)];
    Label3.text = @"2019.1.2" ;
    Label3.textColor = [UIColor lightGrayColor];
    Label3.font =[UIFont fontWithName:@"PingFang SC" size:12];
    [footerView addSubview:Label3];
    
    UILabel *Label4 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(Label3.frame) + 20 , self.view.bounds.size.width, 20)];
    Label4.text = @"快递已经揽收" ;
    [footerView addSubview:Label4];
    
    UILabel *Label5 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(Label4.frame) + 5, self.view.bounds.size.width, 20)];
    Label5.text = @"2019.1.1" ;
    Label5.textColor = [UIColor lightGrayColor];
    Label5.font =[UIFont fontWithName:@"PingFang SC" size:12];
    [footerView addSubview:Label5];
    
    UILabel *Label6 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(Label5.frame) + 20 , self.view.bounds.size.width, 20)];
    Label6.text = @"已发货" ;
    [footerView addSubview:Label6];
    
    UILabel *Label7 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(Label6.frame) + 5, self.view.bounds.size.width, 20)];
    Label7.text = @"2019.1.1" ;
    Label7.textColor = [UIColor lightGrayColor];
    Label7.font =[UIFont fontWithName:@"PingFang SC" size:12];
    [footerView addSubview:Label7];
    
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
            self.tableView.tableFooterView.hidden = YES ;
        }
            break;
        case 1:
        {
            self.dataArray = [self.dataPrePayArrays mutableCopy] ;
            self.tableView.tableFooterView.hidden = YES ;
        }
            break;
        case 2:
        {
            self.dataArray = [self.dataSendArrays mutableCopy];
            self.tableView.tableFooterView.hidden = NO ;
        }
            break;
        case 3:
        {
            self.dataArray = [self.dataRecieveArrays mutableCopy];
            self.tableView.tableFooterView.hidden = NO ;
        }
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}
@end

//
//  MineController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "MineController.h"
#import "OrderController.h"
#import "PlaceholderViewController.h"
#import "ConfigurationViewController.h"

@interface MineController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSArray *dataArray ;
@property(nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeaderView;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeSubViews];
}

-(void)makeSubViews {
    self.navigationItem.title = @"我的";
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count ;
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
        OrderController *VC = [[OrderController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        PlaceholderViewController *placeholderVC = [[PlaceholderViewController alloc] init];
        placeholderVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:placeholderVC animated:YES];
    }
}

#pragma mark Lazy Load

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"增长积分", @"增长等级", @"我的增长", @"增长任务",nil];
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = 60;
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    return _tableView;
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.frame  =  CGRectMake(15, 20, 200,60);
        leftLabel.text = @"GrowingIO";
        leftLabel.textColor = [UIColor darkTextColor];
        leftLabel.textAlignment = NSTextAlignmentLeft ;
        leftLabel.layer.cornerRadius = 5 ;
        leftLabel.layer.masksToBounds = YES;
        [_tableHeaderView addSubview:leftLabel];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame  =  CGRectMake(self.view.bounds.size.width - 80, 20, 60 , 60);
        imageView.layer.masksToBounds = YES ;
        imageView.layer.cornerRadius = 30 ;
        imageView.image = [UIImage imageNamed:@"mine_icon_gio"];
        [_tableHeaderView addSubview:imageView];
        
        UITapGestureRecognizer *tapHeaderGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapHandle:)];
        [_tableHeaderView addGestureRecognizer:tapHeaderGesture];
    }
    return _tableHeaderView;
}

- (void)headerTapHandle:(UITapGestureRecognizer *)tap {
    ConfigurationViewController *configVC = [[ConfigurationViewController alloc] init];
    [self.navigationController pushViewController:configVC animated:YES];
}

@end

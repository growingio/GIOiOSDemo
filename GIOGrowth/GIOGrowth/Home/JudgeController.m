//
//  JudgeController.m
//  GIOGrowth
//
//  Created by GrowingIO on 2019/1/14.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "JudgeController.h"

@interface JudgeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSArray *dataArray ;
@property(nonatomic ,strong) UITableView *tableView;

@end

@implementation JudgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.dataArray = [NSArray arrayWithObjects:@"很喜欢，还会再来", @"还会再来很满意", @"好评模板，使用这个模板表示我欢， 懒得重复打字了， 所以凑字数...", @"好评模板，使用这个模板表示我欢， 懒得重复打字了， 所以凑字数...",@"好评模板，使用这个模板表示我欢， 懒得重复打字了， 所以凑字数...",nil];
    [self.view addSubview:self.tableView];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.textLabel.numberOfLines = 0 ;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end

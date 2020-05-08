//
//  SearchViewController.m
//  Created by caiq on 16/5/17.
//  All rights reserved.

#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height

#import "SearchViewController.h"
#import "OrderCell.h"
#import "GoodsDetailController.h"
#import "Growing.h"
#import "GoodsModel.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate>

@property (nonatomic ,strong)  UIView *upView ;
@property (nonatomic ,strong)  UISearchBar *searchBar ;
@property (nonatomic , strong) NSMutableArray *titleTipArray ;
@property (nonatomic , strong) NSMutableArray *allNameArray ;
@property (nonatomic , strong) UITableView *searchTable;
@property (nonatomic , strong) UIView * backSearchView;
@property (nonatomic , strong) UIImageView * imageviewBack;
//存放所有数据数组
@property (nonatomic , strong)NSMutableArray *allDataArray;
//存放搜索结果数组
@property (nonatomic , strong)NSMutableArray *searchArray ;

@end
//
@implementation SearchViewController
//
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleTipArray = [NSMutableArray arrayWithObjects:@"GIO马克杯",@"增长黑客手册",@"GIO文化衫", nil];
    //  导航栏的添加搜索框
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchBar= [[UISearchBar alloc] init];
    self.navigationItem.titleView = self.searchBar ;
    self.searchBar.frame = CGRectMake(0, 6 , self.view.bounds.size.width - 80 , 30);
    self.searchBar.delegate = self ;
    self.searchBar.layer.masksToBounds = YES ;
    self.searchBar.layer.cornerRadius = 15 ;
    self.searchBar.keyboardType =  UIKeyboardTypeWebSearch;
    [self.searchBar becomeFirstResponder];
    [self makeHomeData];
    [self makeUPView];
}

-(void)makeUPView{
    self.upView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width , self.view.bounds.size.height)];
    self.upView.backgroundColor = [UIColor whiteColor];
    //热门搜索标签
    UILabel *hotTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 64, 22)];
    hotTitleLabel.text = @"热门搜索";
    hotTitleLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    [self.upView addSubview:hotTitleLabel];
    //热门搜索btn
    float btnW = (self.view.bounds.size.width - 2 * 15 - 3 * 15 ) / 3.0;
    float btnH = 28 ;
    float padding = CGRectGetMaxY(hotTitleLabel.frame) + 15 ;
    for (int i = 0  ; i < self.titleTipArray.count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.layer.masksToBounds = YES ;
        btn.layer.cornerRadius = 4 ;
        btn.layer.borderWidth = 1 ;
        btn.frame = CGRectMake(15 + i%3 * (btnW + 15), padding + i/3 *(btnH + 15), btnW, btnH);
        [self.upView addSubview:btn];
        [btn setTitle:self.titleTipArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
        btn.tag = i ;
        [btn addTarget:self action:@selector(bntClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.view addSubview:self.upView];
}

#pragma textField代理方法

//
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    self.searchArray = [NSMutableArray array];
    for (int i = 0 ; i < self.allDataArray.count ; i ++ ) {
        GoodsModel *model = self.allDataArray[i];
        NSString *str = model.productName_var ;
        if ([str containsString:searchBar.text]) {
            [self.searchArray addObject:model];
        }
    }
    [self.searchTable reloadData];
    self.upView.hidden = YES;
    self.backSearchView.hidden = NO;
    [self.searchBar resignFirstResponder];
    if (self.searchArray.count) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"searchWord_var"] = searchBar.text;
        [self searchResultView:dict];
        [self searchGoods:dict];
    }else{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"searchWord_var"] = searchBar.text;
        [self searchNoResultView:dict];
        [self searchGoods:dict];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未搜索到商品" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

#pragma tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.searchArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsModel *model = self.searchArray[indexPath.row] ;
    OrderCell *cell= [[OrderCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    cell.imageIcon.image = [UIImage imageNamed:model.productId_var] ;
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0,1, self.view.bounds.size.width , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:label6];
    NSDictionary *dict = [model modelTodic]  ;
    [cell updateCell:dict];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160 ;
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailController *VC = [[GoodsDetailController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    VC.goodModel = self.searchArray[indexPath.row] ;
    [self.navigationController pushViewController:VC animated:YES];
    NSMutableDictionary *dict = [[VC.goodModel modelTodic] mutableCopy];
    dict[@"searchWord_var"] = VC.goodModel.productName_var ;
    [self searchResultClick:dict];
}

//大家搜索的按钮点击
-(void)bntClick:(UIButton *)btn
{
    self.searchArray = [NSMutableArray array];
    for (int i = 0 ; i < self.allDataArray.count ; i ++ ) {
        GoodsModel *model = self.allDataArray[i];
        NSString *str = model.productName_var ;
        if ([str containsString:btn.titleLabel.text]) {
            [self.searchArray addObject:model];
        }
    }
    [self.searchTable reloadData];
    self.upView.hidden = YES;
    self.backSearchView.hidden = NO;
    [self.searchBar resignFirstResponder];
    if (self.searchArray.count) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"searchWord_var"] = btn.titleLabel.text;
        [self searchResultView:dict];
        [self searchGoods:dict];
    }else{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"searchWord_var"] = btn.titleLabel.text;
        [self searchNoResultView:dict];
        [self searchGoods:dict];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未搜索到商品" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];  
    }
}

//打点开始
-(void)searchGoods:(NSDictionary *)dict{
    [Growing track:@"searchGoods" withVariable:dict];
}

-(void)searchResultView:(NSDictionary *)dict{
    [Growing track:@"searchResultView" withVariable:dict];
}

-(void)searchNoResultView:(NSDictionary *)dict{
    [Growing track:@"searchNoResultView" withVariable:dict];
}

-(void)searchResultClick:(NSDictionary *)dict{
    NSMutableDictionary *mutDict = dict.mutableCopy;
    [mutDict removeObjectForKey:@"price_var"];
    [Growing track:@"searchResultClick" withVariable:mutDict];
}

//打点结束
-(void)makeHomeData{
    NSMutableArray *allNameArray = [NSMutableArray arrayWithObjects:@"渠道流量分析",@"产品经理数据分析",@"增长黑客手册",@"GIO马克杯",@"GIO文化衫", nil];
    NSMutableArray *priceArray = [NSMutableArray arrayWithObjects:@"59",@"39",@"36",@"59",@"89", nil];
    self.allDataArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 5 ; i ++ ) {
        GoodsModel *model = [[GoodsModel alloc] init];
        model.productId_var = [NSString stringWithFormat:@"00%d",i+1];
        model.productName_var = allNameArray[i];
        model.price_var = priceArray[i];
//        model.floor_var = @"首页" ;
        [self.allDataArray addObject:model];
    }
    self.searchArray = self.allDataArray ;
    
    UIView *backSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 30 , SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImageView *imageviewBack = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 50, 100 , 100, 100)];
    imageviewBack.image = [UIImage imageNamed:@"empty.png"];
    imageviewBack.hidden = YES ;
    self.imageviewBack = imageviewBack;
    [self.view addSubview:imageviewBack];
    [self.view addSubview:backSearchView];
    self.backSearchView = backSearchView ;
    self.backSearchView.backgroundColor = [UIColor whiteColor];
    backSearchView.hidden = YES ;
    //创建tableView
    self.searchTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT - 44 ) style:UITableViewStyleGrouped];
    [backSearchView addSubview:self.searchTable];
    self.searchTable.tag = 100 ;
    self.searchTable.separatorStyle = NO;
    self.searchTable.delegate = self ;
    self.searchTable.dataSource = self ;
    self.searchTable.backgroundColor = [UIColor lightTextColor];
    UIImageView *imageViewTip = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 50, 100, 100, 100)];
    imageViewTip.image = [UIImage imageNamed:@"empty"];
    imageViewTip.hidden = YES ;
    [backSearchView addSubview:imageViewTip];
}

@end

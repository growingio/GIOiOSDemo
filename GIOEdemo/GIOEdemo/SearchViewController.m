//
//  SearchViewController.m
//  Created by caiq on 16/5/17.
//  All rights reserved.
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
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height
#import "SearchViewController.h"
#import "OrderCell.h"
#import "GoodsDetailController.h"
@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate>
@property (nonatomic ,strong) UIView *upView ;
@property (nonatomic ,strong) UISearchBar *searchBar ;
@property (nonatomic , strong)NSMutableArray *titleTipArray ;
//@property (nonatomic , strong)NSArray *historyArray ;
//@property (nonatomic , strong)UITableView *historytableView;
@property (nonatomic , strong)UITableView *searchTable;
//@property (nonatomic , strong)UIView *sepretView;
@property (nonatomic , strong)UIView * backSearchView;
//@property (nonatomic , strong)UIImageView * imageviewBack;
////存放搜索结果数组
@property (nonatomic , strong)NSMutableArray *dataArray;
///** 页次*/
//@property (nonatomic, assign) NSInteger pageIndex;
//@property (nonatomic , strong)UIImageView * imageViewTip;
@end
//
@implementation SearchViewController
//
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    /** 页次*/
//    self.pageIndex = 1;
//    // Do any additional setup after loading the view.
     self.titleTipArray = [NSMutableArray arrayWithObjects:@"GIO 马克杯",@"增长黑客手册",@"GIO 帽衫", nil];
//    self.historyArray = [[NSMutableArray alloc] init];
//    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    //取出UIButton左侧返回键
//    UIButton *btnLeft = [[UIButton alloc] init];
//    btnLeft.frame = CGRectMake(0, 0, 0, 0);
//    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
//      self.navigationItem.leftBarButtonItem = leftItem;
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
 
//    //添加导航栏下方的线
//    UIView *sepretView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.frame), SCREEN_WIDTH, 0.5)];
//    sepretView.backgroundColor = RGBCOLORV(0xdcdddd);
//    [self.navigationController.navigationBar addSubview:sepretView];
//    self.sepretView = sepretView ;
//
//    //导航栏右侧添加取消按钮
//    UIButton *btnRight = [[UIButton alloc] init];
//    btnRight.frame = CGRectMake(0, 0, 32, 22);
//    [btnRight addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
//    [btnRight setTitle:@"取消" forState:UIControlStateNormal];
//    [btnRight setTitleColor:RGBCOLORV(0xf26449) forState:UIControlStateNormal];
//     btnRight.font = [UIFont fontWithName:AppFONT size:16];
//    self.navigationItem.rightBarButtonItem = rightItem;
    [self makeUPView];
    [self makeSearchTable];
//    [self readNSUserDefaults];
// 
}
////导航栏右侧取消按钮点击
//-(void)btnRightClick{
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(void)makeUPView{
    self.upView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width , self.view.bounds.size.height)];
    self.upView.backgroundColor = [UIColor whiteColor];
    //热门搜索标签
    UILabel *hotTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 64, 22)];
    hotTitleLabel.text = @"热门搜索";
    hotTitleLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
//    hotTitleLabel.textColor = RGBCOLORV(0x333333);
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
//        btn.layer.borderColor =RGBCOLORV(0xdcdddd).CGColor;
        btn.frame = CGRectMake(15 + i%3 * (btnW + 15), padding + i/3 *(btnH + 15), btnW, btnH);
        [self.upView addSubview:btn];
        [btn setTitle:self.titleTipArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
        btn.tag = i ;
        [btn addTarget:self action:@selector(bntClick:) forControlEvents:UIControlEventTouchUpInside];
    }
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(hotTitleLabel.frame) + 145 , self.view.bounds.size.width , 5)];
//    view.backgroundColor = [UIColor lightGrayColor];
//    [self.upView addSubview:view];
//    //历史搜索标签
//    UILabel *historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(hotTitleLabel.frame) + 162 , 64, 22)];
//    historyLabel.text = @"历史搜索";
//    historyLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
//    historyLabel.textColor = RGBCOLORV(0x333333);
//    [self.upView addSubview:historyLabel];
//    //清空历史
//    UIButton *historyBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 96 - 18 , CGRectGetMaxY(hotTitleLabel.frame) + 162 , 96, 22)];
//    [historyBtn setTitle:@"清空搜索历史" forState:UIControlStateNormal];
//    [historyBtn setTitleColor:RGBCOLORV(0xb5b5b6) forState:UIControlStateNormal];
//    historyBtn.titleLabel.font = [UIFont fontWithName:AppFONT size:16];
//    [historyBtn addTarget:self action:@selector(historyBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.upView addSubview:historyBtn];
    
//    //历史搜索的tableview
//    self.historytableView = [[UITableView alloc] init];
//    self.historytableView.frame = CGRectMake(0, CGRectGetMaxY(historyBtn.frame) + 16  , SCREEN_WIDTH, SCREEN_HEIGHT - 200);
//    self.historytableView.delegate = self ;
//    self.historytableView.dataSource = self ;
//    self.historytableView.tableFooterView=[[UIView alloc]init];
//    [self.upView addSubview:self.historytableView];
//    UIView *sepretView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 0.5)];
//    sepretView.backgroundColor = RGBCOLORV(0xdcdddd);
//    [self.historytableView addSubview:sepretView];
    [self.view addSubview:self.upView];
}
//
//-(void)historyBtnClick{
//    NSLog(@"清空搜索历史点击");
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清空历史搜索" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    alert.tag = 300 ;
//    [alert show];
//
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0 && alertView.tag == 300 ) {
//        self.historyArray  = nil ;
//        [self.historytableView reloadData];
//        [[NSUserDefaults standardUserDefaults] setObject:[NSArray array] forKey:@"historyArray"];
//    }
//}
//
//
#pragma textField代理方法

//
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    self.upView.hidden = YES;
    self.backSearchView.hidden = NO;
    [self.searchBar resignFirstResponder];
}



//
//
#pragma tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.dataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        OrderCell *cell= [[OrderCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        cell.imageIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"order%d",indexPath.row + 1]] ;
        UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0,1, self.view.bounds.size.width , 0.5)];
        label6.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:label6];
        NSDictionary *dict = self.dataArray[indexPath.row] ;
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
    [self.navigationController pushViewController:VC animated:YES];
    
}
//大家搜索的按钮点击
-(void)bntClick:(UIButton *)btn
{
    NSLog(@"热门搜索安妮点击");
    [self startSearch:btn.titleLabel.text];
    self.upView.hidden = YES;
    self.backSearchView.hidden = NO;
    [self.searchBar resignFirstResponder];
    
}
//
//开始搜索按钮点击
-(void)startSearch:(NSString *)keyWords{
    NSInteger interger = 1 ;
      __weak __typeof(self)weakSelf = self;

            
//            if ([json isEqualToString:@"数据为空"]) {
//                [weakSelf.dataArray removeAllObjects];
//                weakSelf.dataArray = nil ;
//                [self.searchTable reloadData];
//                self.imageViewTip.hidden = NO ;
//            }
//
//            self.imageViewTip.hidden = YES;
//            NSMutableArray *mArray = [[NSMutableArray alloc] init];
//            for (NSDictionary * dc in json) {
//                NewMainModel* invest = [NewMainModel initializeWithDic:dc];
//                [mArray addObject:invest];
//                NSLog(@"mArray.count %lu",(unsigned long)mArray.count);
//            }
//            NSLog(@"mArray.count %@",mArray);
//            if (weakSelf.pageIndex == 1) {
//                weakSelf.dataArray = mArray;
//            }else
//            {
//                [weakSelf.dataArray addObjectsFromArray:mArray];
//            }
//
//            [self.searchTable reloadData];
//
//            NSLog(@"%@",json);
//
//        }
//
//        [self.searchBar resignFirstResponder];
}

//
////点击空白键盘下落
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.searchBar resignFirstResponder];
//}
//
//
-(void)makeSearchTable{
    UIView *backSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 30 , SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImageView *imageviewBack = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 50, 100 , 100, 100)];
    imageviewBack.image = [UIImage imageNamed:@"empty.png"];
    imageviewBack.hidden = YES ;
    
    self.dataArray = [NSMutableArray array];
    NSDictionary *dict = @{@"number":@"GIO 商品",@"title":@"商品型号",@"monney":@"¥59.00",@"state":@"",};
    NSDictionary *dict2 = @{@"number":@"GIO 商品",@"title":@"商品型号",@"monney":@"¥59.00",@"state":@"",};
    NSDictionary *dict3 = @{@"number":@"GIO 商品",@"title":@"商品型号",@"monney":@"¥79.00",@"state":@"",};
    [self.dataArray addObject:dict];
    [self.dataArray addObject:dict2];
    [self.dataArray addObject:dict3];
    
    
   
//    self.imageviewBack = imageviewBack;
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
    self.searchTable.backgroundColor = RGBCOLORV(0xffffff);
    UIImageView *imageViewTip = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 50, 100, 100, 100)];
    imageViewTip.image = [UIImage imageNamed:@"empty"];
    imageViewTip.hidden = YES ;
//    self.imageViewTip = imageViewTip ;
    [backSearchView addSubview:imageViewTip];
}
//
//-(void)readNSUserDefaults
//{
//    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    if ([userDefaultes arrayForKey:@"historyArray"]) {
//        //读取数组NSArray类型的数据
//        self.historyArray = [userDefaultes arrayForKey:@"historyArray"];
//        NSLog(@"self.historyArray %@",self.historyArray);
//        [self.historytableView reloadData];
//    }
//  
//}
@end

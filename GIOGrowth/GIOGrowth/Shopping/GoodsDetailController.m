//
//  GoodsDetailController.m
//  GIOGrowth
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "GoodsDetailController.h"
#import "OrderCell.h"
#import "HomeCell.h"
#import "JudgeController.h"
#import "Growing.h"

static NSInteger const kBottomViewHeight = 60;

@interface GoodsDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView ;
@property (nonatomic , strong) NSMutableArray *suggestArray ;
@property (nonatomic , strong) NSMutableArray *titleArray;
@property (nonatomic , strong) UIView *shareView ;

@property (nonatomic, copy) NSString *key;

//  商品参数
@property (nonatomic, copy) NSString *productId_var;
@property (nonatomic, copy) NSString *productName_var;
@property (nonatomic, copy) NSString *price_var;

@end

@implementation GoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"增长详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.goodModel) {
        self.productId_var = self.goodModel.productId_var;
        self.productName_var = self.goodModel.productName_var;
        self.price_var = self.goodModel.price_var;
    } else {
        self.goodModel = [[GoodsModel alloc] init];
        self.goodModel.productId_var = self.productId_var;
        self.goodModel.productName_var = self.productName_var;
        self.goodModel.price_var = self.price_var;
    }
    
    [self.view addSubview:self.tableView];
    [self makeBottomview];
   
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithTitle:@"分享"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(showShareViewAction:)];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    [self goodsDetailPageView:[self.goodModel modelTodic]];
    
    [self.view addSubview:self.shareView];
}

-(void)closeShareViewAction:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.shareView.alpha = .0f;
    }];
}

-(void)showShareViewAction:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.shareView.alpha = 1.0f;
    }];
}

-(void)shareClick:(UIButton *)btn{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
    switch (btn.tag) {
        case 0:
            {
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"朋友圈",@"sharechannel", nil];
                [self shareActivity:dict] ;
            }
            break;
        case 1:
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"微信",@"sharechannel", nil];
            [self shareActivity:dict] ;
        }
            break;
        case 2:
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"微博",@"sharechannel", nil];
            [self shareActivity:dict] ;
        }
            break;
        case 3:
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"qq",@"sharechannel", nil];
            [self shareActivity:dict] ;
        }
            break;
        default:
            break;
    }
}


//打点开始
-(void)goodsDetailPageView:(NSDictionary *)dict{
    NSMutableDictionary *mutDict = dict.mutableCopy;
    [mutDict removeObjectForKey:@"floor_var"];
    [mutDict removeObjectForKey:@"price_var"];
    [Growing track:@"goodsDetailPageView" withVariable:mutDict];
}

-(void)addToCart:(NSDictionary *)dict{
    NSMutableDictionary *mutDict = dict.mutableCopy;
    [mutDict removeObjectForKey:@"floor_var"];
    [mutDict removeObjectForKey:@"price_var"];
    [mutDict removeObjectForKey:@"payAmount_var"];
    mutDict[@"buyQuantity_var"] = @1;
    [Growing track:@"addToCart" withVariable:mutDict];
}

-(void)checkOut:(NSDictionary *)dict{
    
    NSMutableDictionary *mutDict = dict.mutableCopy;
    mutDict[@"buyQuantity_var"] = @1;
    mutDict[@"payAmount_var"] = [NSNumber numberWithFloat:[dict[@"price_var"] floatValue]];
    [mutDict removeObjectForKey:@"floor_var"];
    [mutDict removeObjectForKey:@"price_var"];
    [Growing track:@"checkOut" withVariable:mutDict];
}

-(void)shareActivity:(NSDictionary *)dict{
    [Growing track:@"shareActivity" withVariable:dict];
}
//打点结束


-(void)makeBottomview{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - kBottomViewHeight, self.view.bounds.size.width , kBottomViewHeight)];
    
    UIButton *btnLeft = [[UIButton alloc] init];
    btnLeft.backgroundColor = [UIColor whiteColor];
    btnLeft.frame = CGRectMake(40, 0, self.view.bounds.size.width /2.0 - 50, 40);
    btnLeft.titleLabel.textAlignment = NSTextAlignmentCenter ;
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:15];
    btnLeft.layer.masksToBounds = YES ;
    btnLeft.layer.cornerRadius = 5 ;
    btnLeft.layer.borderColor = [UIColor blackColor].CGColor;
    btnLeft.layer.borderWidth = 1 ;
    [btnLeft setTitle:@"加入增长平台" forState:UIControlStateNormal];
    [btnLeft setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(addShoppingCartAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnLeft];
    
    UIButton *btnRight = [[UIButton alloc] init];
    btnRight.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    btnRight.frame  = CGRectMake(self.view.bounds.size.width /2.0 + 10 , 0, self.view.bounds.size.width /2.0  - 50, 40);
    btnRight.titleLabel.textColor = [UIColor whiteColor];
    btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
    btnRight.titleLabel.textAlignment = NSTextAlignmentCenter ;
    [btnRight setTitle:@"立即增长" forState:UIControlStateNormal];
    btnRight.layer.masksToBounds = YES ;
    btnRight.layer.cornerRadius = 5 ;
    [btnRight addTarget:self action:@selector(purchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnRight];
    [self.view addSubview:view];
}

-(void)addShoppingCartAction:(UIButton *)sender {
    
    [Growing track:@"addToBag"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加增长平台成功" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    //存储数据Z
    [self persistCartData];
    [self addToCart:[self.goodModel modelTodic]];
}

-(void)purchaseAction:(UIButton *)sender {
    //存储数据
    [self persistCartData];
    [self addToCart:[self.goodModel modelTodic]];
    
    self.tabBarController.selectedIndex = 2 ;
    self.goodModel.payAmount_var = [NSNumber numberWithFloat:[self.price_var floatValue]];
    [self checkOut:[self.goodModel modelTodic]];
}

- (void)persistCartData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *cartArray = [[defaults objectForKey:@"cartArray"] mutableCopy] ?: [NSMutableArray array];
    
    if (cartArray &&![cartArray containsObject:[self.goodModel modelTodic]]) {
        [cartArray addObject:[self.goodModel modelTodic]];
        [defaults setObject:cartArray forKey:@"cartArray"];
        [defaults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kShoppingCartDidUpdatedNotification" object:nil];
    }
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
    
    cell.selectionStyle =  UITableViewCellSelectionStyleNone ;
    [cell addSubview:view];
    return cell  ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JudgeController *VC = [[JudgeController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(UIView *)makeTableFooterView{
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 100 , self.view.bounds.size.width , 260)];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, self.view.bounds.size.width - 20 , 0.5)];
    label6.backgroundColor = [UIColor lightGrayColor];
    [footerView addSubview:label6];
    
    UILabel *upLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0 , self.view.bounds.size.width - 40, 30)];
    upLabel.textAlignment = NSTextAlignmentLeft ;
    upLabel.text = @"推荐" ;
    [footerView addSubview:upLabel];
    
    footerView.backgroundColor = [UIColor whiteColor];
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"增长黑客 \n ¥59",@"gio帽衫 \n ¥99", nil] ;
    for (int i = 0; i < 2; i ++) {
        HomeCell *cell = [[HomeCell alloc] initWithFrame:CGRectMake(20 + (self.view.frame.size.width - 60) * i /2  + 20 * i , 40 , (self.view.frame.size.width - 60)/2 , 100 )];
        cell.layer.borderColor = [UIColor blueColor].CGColor;
        cell.layer.borderWidth = 1 ;
        cell.width  = CGRectGetWidth(cell.frame) ;
        cell.height = CGRectGetHeight(cell.frame)  ;
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"suggest%d",i+1]];
        if (i == 0) {
            UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionLeft)];
            [cell addGestureRecognizer:tapGesturRecognizer];
        }else{
            UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionRight)];
            [cell addGestureRecognizer:tapGesturRecognizer];
        }

        cell.titleLabel.textAlignment = NSTextAlignmentCenter ;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 , cell.frame.size.height , cell.frame.size.width , 60)];
        titleLabel.text =  titleArray[i];
        titleLabel.numberOfLines = 0 ;
        titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
        titleLabel.textAlignment = NSTextAlignmentCenter ;
        [cell addSubview:titleLabel];
        [footerView addSubview:cell];
    }
    return footerView ;
}

-(void)tapActionLeft
{
    GoodsDetailController *VC = [[GoodsDetailController alloc] init];
    VC.goodModel = [self.suggestArray firstObject];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)tapActionRight
{
    GoodsDetailController *VC = [[GoodsDetailController alloc] init];
    VC.goodModel = [self.suggestArray lastObject];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
}

- (UIView *)makeTableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 500)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 400)];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@big",self.productId_var]];
    [headerView addSubview:imageView];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame) + 10, 150 , 30)];
    titleLabel.text = self.productName_var ;
    [headerView addSubview:titleLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame) , 150 , 30)];
    priceLabel.text = self.price_var ;
    priceLabel.textColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    [headerView addSubview:priceLabel];
    
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(priceLabel.frame) , 150 , 30)];
    addressLabel.text = @"送至北京市 朝阳区" ;
    [headerView addSubview:addressLabel];
    return headerView;
}

#pragma mark Lazy Load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height - kBottomViewHeight)];
        _tableView.delegate = self ;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = 180;
        _tableView.tableHeaderView = [self makeTableHeaderView];
        _tableView.tableFooterView = [self makeTableFooterView];
    }
    return _tableView;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"¥599.00", @"¥5,799.00", @"¥59.00",@"¥599.00",@"¥59.00",nil];
    }
    return _titleArray;
}

- (NSMutableArray *)suggestArray {
    if (!_suggestArray) {
        NSMutableArray *allNameArray = [NSMutableArray arrayWithObjects:@"增长黑客手册",@"GIO文化衫", nil];
        NSMutableArray *priceArray = [NSMutableArray arrayWithObjects:@"59",@"99", nil];
        _suggestArray = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < 2 ; i ++ ) {
            GoodsModel *model = [[GoodsModel alloc] init];
            if (i == 0) {
                model.productId_var = @"003";
            }else{
                model.productId_var = @"005";
            }
            model.productName_var = allNameArray[i];
            model.price_var = priceArray[i];
            model.floor_var = @"推荐" ;
            [_suggestArray addObject:model];
        }
    }
    return _suggestArray;
}

- (UIView *)shareView {
    if (!_shareView) {
        
        CGFloat shareViewW = self.view.bounds.size.width - 40;
        CGFloat shareViewH = 150;
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, shareViewW, shareViewH)];
        _shareView.backgroundColor = [UIColor clearColor];
        _shareView.alpha = 0.0f;
        
        UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(shareViewW - 60 , 20 , 40, 40)];
        [btnClose setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [btnClose addTarget:self action:@selector(closeShareViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:btnClose];
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 40)];
        shareLabel.text = @"分享物品" ;
        [_shareView addSubview:shareLabel];
        
        _shareView.layer.masksToBounds = YES ;
        _shareView.layer.cornerRadius = 10 ;
                
        for (int i = 0; i < 4; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((shareViewW / 4.0) * i + 5 * i ,80, (shareViewW - 50)/ 4.0 , 60)];
            btn.tag = i ;
            NSString *name = [NSString stringWithFormat:@"share%d",(int)btn.tag+1] ;
            [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
            [_shareView addSubview:btn];
        }
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        blurView.frame = CGRectMake(0, 0, shareViewW, shareViewH);
        [_shareView insertSubview:blurView atIndex:0];

    }
    return _shareView;
}

@end

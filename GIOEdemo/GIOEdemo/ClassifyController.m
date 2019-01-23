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
@interface ClassifyController ()
@property (nonatomic ,strong) UIView *rightView ;
@property (nonatomic ,strong) UIButton *chooseBtn ;
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
        
    UIImageView *imaview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imaview.image = [UIImage imageNamed:@"搜索"];
    [view addSubview:imaview];
    [view addSubview:btn];
    self.navigationItem.titleView = view ;
    [self  makeLeftView];
    [self makeRightView];
}

-(void)makeLeftView{
    UIView *leftView  = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame) + 120 , 100, self.view.bounds.size.height )];
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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width , 120)];
    imageView.image = [UIImage imageNamed:@"suggest"];
    [self.view addSubview:imageView];
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(imageView.frame), self.view.bounds.size.width - 100, self.view.bounds.size.height - 180)];
    for (int i = 0; i < 2; i ++) {
            NSMutableArray *array = [NSMutableArray arrayWithObjects:@"手机",@"文化衫",@"马克杯", nil];
            UIView *cellView =  [self makeCellArray:array];
            cellView.frame = CGRectMake(0,i * 120 + 10,  self.view.bounds.size.width - 100, 120);
            [self.rightView addSubview:cellView];
    }
    
    [self.view addSubview:self.rightView];
    
}

-(UIView *)makeCellArray:(NSArray *)array{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(110, 200, self.view.bounds.size.width - 120, 120)];
    view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < array.count; i ++) {
            HomeCell *cell = [[HomeCell alloc] initWithFrame:CGRectMake(i *  (self.view.bounds.size.width - 40 - 100)/array.count + 10 * i ,0, 100, 120)];
            cell.height = (self.view.bounds.size.width - 40 - 100)/array.count  ;
            cell.width  = (self.view.bounds.size.width - 40 - 100)/array.count  ;
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hot%d",i+1]] ;
            cell.titleLabel.textAlignment = NSTextAlignmentCenter ;
            cell.titleLabel.text = array[i];
            [view addSubview:cell];
        
            UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
            [cell addGestureRecognizer:tapGesturRecognizer];
        if (array.count == 1) {
            cell.center  = CGPointMake((self.view.bounds.size.width - 120)/2.0, 60) ;
        }
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
    self.rightView =  [[UIView alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 120, self.view.bounds.size.width - 100, self.view.bounds.size.height - 180)];
    [self.view addSubview:self.rightView];
    switch (btn.tag) {
        case 0:
            {
                for (int i = 0; i < 2; i ++) {
                    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"手机",@"文化衫",@"马克杯", nil];
                    UIView *cellView =  [self makeCellArray:array];
                    cellView.frame = CGRectMake(0 , i * 120 + 10,  self.view.bounds.size.width - 120, 120);
                    [self.rightView addSubview:cellView];
                }
            }
            break;
        case 1:
        {
            NSMutableArray *array = [NSMutableArray arrayWithObjects:@"红色特别版",@"大容量深空灰", nil];
            UIView *cellView =  [self makeCellArray:array];
            cellView.frame = CGRectMake(25, 15 ,  self.view.bounds.size.width - 120, 120);
            [self.rightView addSubview:cellView];
        }
            break;
        case 2:
        {
                NSMutableArray *array = [NSMutableArray arrayWithObjects:@"宇航员马克杯", nil];
                UIView *cellView =  [self makeCellArray:array];
                cellView.frame = CGRectMake(15,15 ,  self.view.bounds.size.width - 120, 120);
                [self.rightView addSubview:cellView];
        }
            break;
        case 3:
        {
                NSMutableArray *array = [NSMutableArray arrayWithObjects:@"simon同款帽衫", nil];
                UIView *cellView =  [self makeCellArray:array];
                cellView.frame = CGRectMake(15,15,  self.view.bounds.size.width - 120, 120);
                [self.rightView addSubview:cellView];
        }
            break;
        default:
            break;
    }
}


-(void)tapAction
{
    GoodsDetailController *VC = [[GoodsDetailController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
}


-(void)btnClick{
    SearchViewController *VC = [[SearchViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC  animated:NO];
}

@end

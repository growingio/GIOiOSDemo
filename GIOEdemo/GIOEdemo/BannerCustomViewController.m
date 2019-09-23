//
//  BannerCustomViewController.m
//  GIOEdemo
//
//  Created by GrowingIO on 2019/9/5.
//  Copyright © 2019 M. All rights reserved.
//

#import "BannerCustomViewController.h"
#import "SDCycleScrollView.h"
#import "CustomCollectionViewCell.h"
#import <YYWebImage/UIImageView+YYWebImage.h>
#import <GrowingTouchKit/GrowingTouchBannerData.h>
#import <GrowingTouchKit/GrowingTouchKit.h>

@interface BannerCustomViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *customCellScrollView;

@property (weak, nonatomic) IBOutlet UITextField *bannerKeyField;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BannerCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.title = @"自渲染";

    self.customCellScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 200) delegate:self placeholderImage:[UIImage imageNamed:@"default_b.jpg"]];
    self.customCellScrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.customCellScrollView];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view
{
    if (view != self.customCellScrollView) {
        return nil;
    }
    return [CustomCollectionViewCell class];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view
{
    CustomCollectionViewCell *myCell = (CustomCollectionViewCell *)cell;
    GrowingTouchBannerItem *item = self.dataArray[index];

    //  绑定数据
    [GrowingTouch growingTouchBannerDataTaskBannerKey:self.bannerKeyField.text bannerView:myCell bannerItem:item selectCompleted:^(NSString *openUrl, NSError *error) {

        if (error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"点击第%zd轮播", item.index]  message:[NSString stringWithFormat:@"获取对应的跳转参数失败，失败原因是%@" , error] preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"点击第%zd轮播", item.index] message:[NSString stringWithFormat:@"对应的跳转参数%@", openUrl] preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];

        }

    }];


    [myCell.imageView yy_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholder:[UIImage imageNamed:@""]];
}


- (IBAction)loadData:(id)sender {
    
    [GrowingTouch growingTouchBannerDataTaskBannerKey:self.bannerKeyField.text success:^(GrowingTouchBannerData *bannerData) {
        
        self.dataArray = bannerData.items;
        
        self.customCellScrollView.imageURLStringsGroup = [self.dataArray valueForKeyPath:@"imageUrl"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Banner数据请求成功,对应的bannerKey是%@", self.bannerKeyField.text] message:[NSString stringWithFormat:@"请求到的数据是%@", bannerData] preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        });

        
    } failure:^(NSError *error) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Banner数据请求失败" message:[NSString stringWithFormat:@"对应的bannerKey是%@，错误信息是%@", self.bannerKeyField.text, error] preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }];
}

@end

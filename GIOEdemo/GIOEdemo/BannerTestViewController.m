//
//  BannerTestViewController.m
//  GIOEdemo
//
//  Created by GrowingIO on 2019/9/5.
//  Copyright © 2019 M. All rights reserved.
//

#import "BannerTestViewController.h"
#import <GrowingTouchKit/GrowingTouchBannerView.h>
#import "BannerCustomViewController.h"

@interface BannerTestViewController ()<GrowingTouchBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bannerField;

@property (weak, nonatomic) IBOutlet GrowingTouchBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITextField *handleClickField;

@end

@implementation BannerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"原生模板";
    
    
    
}

- (IBAction)customRender:(id)sender {
    
    [self.navigationController pushViewController:[BannerCustomViewController new] animated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)loadBannerData:(id)sender {
    
    self.bannerView = [GrowingTouchBannerView bannerKey:self.bannerField.text bannerFrame:CGRectMake(0, 40, self.view.frame.size.width, 200) placeholderImage:nil];
    self.bannerView.bannerViewErrorImage = [UIImage imageNamed:@"default_b.jpg"];
    [self.view addSubview:self.bannerView];


    [self.bannerView loadBannerWithDelegate:self];
}



- (void)growingTouchBannerLoadSuccess:(GrowingTouchBannerView*) bannerView {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Banner数据请求成功" message:[NSString stringWithFormat:@"对应的bannerKey是%@", bannerView.bannerKey] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)growingTouchBannerLoadFailed:(GrowingTouchBannerView*) bannerView error:(NSError *)error {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Banner数据请求失败" message:[NSString stringWithFormat:@"对应的bannerKey是%@，错误信息是%@", bannerView.bannerKey, error] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}


- (BOOL)growingTouchBanner:(GrowingTouchBannerView*) bannerView didSelectAtIndex:(NSInteger)index openUrl:(NSString *)openUrl {
    

    NSLog(@"是否消费此次事件%ld", (long)self.handleClickField.text.integerValue);
    
    if (self.handleClickField.text.integerValue) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"自行消费点击轮播图" message:[NSString stringWithFormat:@"点击了第%ld个，跳转参数是%@", (long)index, openUrl] preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
    }
    
    return self.handleClickField.text.integerValue;
    
}

- (void)growingTouchBanner:(GrowingTouchBannerView*) bannerView didShowAtIndex:(NSInteger)index {
    
    
}

- (void)growingTouchBannerNotloadClick:(GrowingTouchBannerView*) bannerView {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Banner失败背景图点击" message:[NSString stringWithFormat:@"对应的bannerKey是%@", bannerView.bannerKey] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}


@end

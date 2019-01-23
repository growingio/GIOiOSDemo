//
//  NewTabController.m
//  FaCaiApp
//
//  Created by caiq on 16/7/11.
//  Copyright © 2016年 Adwalker_Liu. All rights reserved.
//

#import "NewTabController.h"
@interface NewTabController ()<UITabBarControllerDelegate>
@property (nonatomic ,assign) int index ;
@end

@implementation NewTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.delegate = self ;
   
}


- (void)awakeFromNib{
    [super awakeFromNib];
    self.delegate = self ;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self makeUI];
}

-(void)makeUI{
    UIImage *musicImage = [UIImage imageNamed:@"home.png"];
    UIImage *musicImageSel = [UIImage imageNamed:@"home_selected.png"];
    
    UIImage *musicImage2 = [UIImage imageNamed:@"category.png"];
    UIImage *musicImageSel2 = [UIImage imageNamed:@"category_selected.png"];
    
    UIImage *musicImage3 = [UIImage imageNamed:@"cart.png"];
    UIImage *musicImageSel3 = [UIImage imageNamed:@"cart_selected.png"];
    
    UIImage *musicImage4 = [UIImage imageNamed:@"profile.png"];
    UIImage *musicImageSel4 = [UIImage imageNamed:@"profile_checked.png"];
    
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    musicImage2 = [musicImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel2 = [musicImageSel2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    musicImage3 = [musicImage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel3 = [musicImageSel3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    musicImage4 = [musicImage4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel4 = [musicImageSel4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UITabBarItem* item = [self.tabBar.items objectAtIndex:0];
    item = [item initWithTitle:nil image:musicImage selectedImage:musicImageSel];
    
    UITabBarItem* item2 = [self.tabBar.items objectAtIndex:1];
    item2 = [item2 initWithTitle:nil image:musicImage2 selectedImage:musicImageSel2];
    
    UITabBarItem* item3 = [self.tabBar.items objectAtIndex:2];
    item3 = [item3 initWithTitle:nil image:musicImage3 selectedImage:musicImageSel3];

    UITabBarItem* item4 = [self.tabBar.items objectAtIndex:3];
    item4 = [item4 initWithTitle:nil image:musicImage4 selectedImage:musicImageSel4];

    
    item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
}
@end

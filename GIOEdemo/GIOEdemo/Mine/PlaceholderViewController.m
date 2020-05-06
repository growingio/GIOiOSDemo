//
//  PlaceholderViewController.m
//  GIOEdemo
//
//  Created by BeyondChao on 2020/5/6.
//  Copyright © 2020 M. All rights reserved.
//

#import "PlaceholderViewController.h"

@interface PlaceholderViewController ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation PlaceholderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubviews];
}

- (void)setupSubviews {
    [self.view addSubview:self.contentLabel];
    self.navigationItem.title = @"稍候";
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        CGFloat w = 230;
        CGFloat h = 80;
        CGFloat x = (self.view.frame.size.width - w) * 0.5;
        CGFloat y = (self.view.frame.size.height - h) * 0.35;
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _contentLabel.tintColor = [UIColor lightGrayColor];
        _contentLabel.text = @"功能暂未开通，攻城狮正快\"码\"加\"编\"!";
        _contentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentLabel;
}

@end

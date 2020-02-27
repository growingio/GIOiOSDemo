//
// Created by xiangyang on 2019/1/23.
// Copyright (c) 2019 com.growingio. All rights reserved.
//

#import "TestPageViewController.h"
#import "Growing.h"

@interface TestPageViewController ()


@end

@implementation TestPageViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.cyanColor;
    [Growing track:@"TestPageOpen"];
    self.title = @"自渲染模式";
    
        
}


@end

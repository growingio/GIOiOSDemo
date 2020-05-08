//
//  CustomCollectionViewCell.m
//  GIOEdemo
//
//  Created by GrowingIO on 2019/9/5.
//  Copyright © 2019 M. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _imageView = [UIImageView new];
    [self.contentView addSubview:_imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
}

@end

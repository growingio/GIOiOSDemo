//
//  HomeCell.m
//  GIOGrowth
//
//  Created by GrowingIO on 2019/1/4.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _imageView = [[UIImageView alloc] init];
        _titleLabel= [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _imageView.image = [UIImage imageNamed:@"palceImage"];
        _titleLabel.textColor = [UIColor darkTextColor];
        [self addSubview:_imageView];
        [self addSubview:_titleLabel];
    }
    return self ;
}


-(void)layoutSubviews{
    _imageView.frame  = CGRectMake(self.bounds.size.width/2.0 - _width/2.0, 0, _width, _height) ;
    _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame) ,  self.frame.size.width, self.frame.size.height - self.frame.size.width) ;
}

-(void)upDateFrame:(CGRect )frame{
    self.titleLabel.frame = frame ;
}

@end

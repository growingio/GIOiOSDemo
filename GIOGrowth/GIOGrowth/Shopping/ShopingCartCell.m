//
//  HomeCell.m
//  poetry
//
//  Created by GrowingIO on 2018/12/25.
//  Copyright © 2018年 min. All rights reserved.
//

#import "ShopingCartCell.h"

@implementation ShopingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        _imageIcon = [[UIImageView alloc] init];
        _imageIcon.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _imageIcon.layer.borderWidth = 0.5 ;
        [self.contentView addSubview:_imageIcon];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.numberOfLines = 0 ;
        [self.contentView addSubview:_titleLabel];
        
        
        _divideLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_divideLabel];
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.frame = CGRectMake(0,0, self.contentView.bounds.size.width , 120);
        
    }
    return self ;
}

-(void)layoutSubviews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.imageIcon.frame  =  CGRectMake(30, 10, 95 , 95);
    self.titleLabel.frame  =  CGRectMake(CGRectGetMaxX(self.imageIcon.frame) + 10 , 30, self.contentView.bounds.size.width - 60 -  CGRectGetMaxX(self.imageIcon.frame)  , 30);
    self.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    self.titleLabel.textAlignment = NSTextAlignmentLeft ;
    self.divideLabel.textColor =[UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    self.divideLabel.frame  =  CGRectMake(CGRectGetMaxX(self.imageIcon.frame) + 10 , CGRectGetMaxY(self.titleLabel.frame) + 10 , self.contentView.bounds.size.width - 150, 20);
}

-(void)updataCell:(NSDictionary *)dict{
    self.titleLabel.text = [dict objectForKey:@"productName_var"] ;
    self.divideLabel.text = [dict objectForKey:@"price_var"] ;
    self.imageIcon.image = [UIImage imageNamed:[dict objectForKey:@"productId_var"]] ;
}


@end

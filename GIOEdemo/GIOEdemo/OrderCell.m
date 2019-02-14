//
//  OrderCell.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/7.
//  Copyright © 2019年 GIO. All rights reserved.
//
#define RGBCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]
#define RGBCOLORVA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        _imageIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageIcon];
        

        _numberLabel = [[UILabel alloc] init];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.numberOfLines = 0 ;
        [self.contentView addSubview:_numberLabel];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 0 ;
        [self.contentView addSubview:_titleLabel];
        
        
        
        _divideLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_divideLabel];
        
        _stateBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_stateBtn];
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.frame = CGRectMake(0,0, self.contentView.bounds.size.width , 120);
        
    }
    return self ;
}

-(void)layoutSubviews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.imageIcon.frame  =  CGRectMake(30, 30, 95 , 95);
    self.numberLabel.frame  =  CGRectMake(CGRectGetMaxX(self.imageIcon.frame) + 10 , 30, 200  , 20);
    self.numberLabel.textAlignment = NSTextAlignmentLeft ;
    self.titleLabel.frame  =  CGRectMake(CGRectGetMaxX(self.imageIcon.frame) + 10 , 60, self.contentView.bounds.size.width - 60 -  CGRectGetMaxX(self.imageIcon.frame)  , 30);
    self.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    self.titleLabel.textAlignment = NSTextAlignmentLeft ;
    self.divideLabel.textColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    self.divideLabel.frame  =  CGRectMake(CGRectGetMaxX(self.imageIcon.frame) + 10 , CGRectGetMaxY(self.titleLabel.frame) + 10 , self.contentView.bounds.size.width - 150, 20);
    self.divideLabel.textAlignment = NSTextAlignmentLeft ;
    self.stateBtn.frame = CGRectMake(self.contentView.bounds.size.width - 90 , CGRectGetMaxY(self.divideLabel.frame)  , 80, 30);
    self.stateBtn.layer.cornerRadius  = 5 ;
    self.stateBtn.layer.masksToBounds = YES ;
    
}

-(void)updateCell:(NSDictionary *)dict{
    self.numberLabel.text = [[dict objectForKey:@"productId_var"] description];
    if (!self.numberLabel.text.length) {
        self.numberLabel.text = [[dict objectForKey:@"订单编号：number"] description];
    }
    self.titleLabel.text =  [[dict objectForKey:@"productName_var"] description] ;
    self.divideLabel.text = [[dict objectForKey:@"price_var"] description];
    [self.stateBtn setTitle:[[dict objectForKey:@"state"] description] forState:UIControlStateNormal];
    [self.stateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.stateBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    if ([self.stateBtn.titleLabel.text isEqualToString:@"待付款"]) {
        self.stateBtn.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.22 alpha:1];
    }else if([self.stateBtn.titleLabel.text isEqualToString:@"配送中"]){
        self.stateBtn.backgroundColor = [UIColor colorWithRed:1 green:0.8 blue:0.22 alpha:1];
    }else if([self.stateBtn.titleLabel.text isEqualToString:@"已收货"]){
        self.stateBtn.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    }
}

@end

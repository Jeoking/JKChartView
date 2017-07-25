//
//  JKColorInfoView.m
//  SaleActivity
//
//  Created by JayKing on 17/7/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import "JKColorInfoView.h"

@implementation JKColorInfoView

/**
 初始化

 @param frame frame
 @param title 标题
 @param color 色值
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        if (!title || !color) {
            return self;
        }
        [self addCakeInfoWithTitle:title color:color];
    }
    return (self);
}

- (void)addCakeInfoWithTitle:(NSString *)title color:(UIColor *)color {
    if (!title) {
        return;
    }
    //添加色块
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
    colorView.backgroundColor = color;
    [self addSubview:colorView];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.height + 8, 0, self.bounds.size.width - self.bounds.size.height - 8, self.bounds.size.height)];
    titleLabel.text = title;
    titleLabel.textColor = color;
    titleLabel.font = [UIFont systemFontOfSize:self.bounds.size.height];
    [self addSubview:titleLabel];
}

@end

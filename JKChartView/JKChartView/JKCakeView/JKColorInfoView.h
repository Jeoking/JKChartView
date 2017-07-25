//
//  JKColorInfoView.h
//  SaleActivity
//
//  Created by JayKing on 17/7/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKColorInfoView : UIView

/**
 初始化
 
 @param frame frame
 @param title 标题
 @param color 色值
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color;

@end

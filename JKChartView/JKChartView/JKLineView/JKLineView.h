//
//  JKLineView.h
//  SaleActivity
//
//  Created by JayKing on 17/7/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKLineView : UIView

/**
 设置折线图表
 
 @param frame frame
 @param pointDatas 点数值数组
 @param maxValue 最大数值
 @param pointColor 点颜色
 @param lineColor 线颜色
 @param lineWidth 线宽
 @param valueTextColor 数值文本颜色
 @param isShow 是否显示数值
 @param edgeInset 内边距
 @return self
 */
- (instancetype)initLineViewWithFrame:(CGRect)frame pointDatas:(NSArray <NSNumber *>*)pointDatas maxValue:(double)maxValue pointColor:(UIColor *)pointColor lineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth valueTextColor:(UIColor *)valueTextColor showValueText:(BOOL)isShow edgeInset:(UIEdgeInsets)edgeInset;

@end

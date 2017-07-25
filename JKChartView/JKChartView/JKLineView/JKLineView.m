//
//  JKLineView.m
//  SaleActivity
//
//  Created by JayKing on 17/7/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import "JKLineView.h"

//数据显示字体大小
static const CGFloat ValueLabelSize = 8;

@interface JKLineView()

@end

@implementation JKLineView

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
- (instancetype)initLineViewWithFrame:(CGRect)frame pointDatas:(NSArray <NSNumber *>*)pointDatas maxValue:(double)maxValue pointColor:(UIColor *)pointColor lineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth valueTextColor:(UIColor *)valueTextColor showValueText:(BOOL)isShow edgeInset:(UIEdgeInsets)edgeInset {
    self = [super initWithFrame:frame];
    if(self) {
        CGFloat divideWidth = (self.bounds.size.width - edgeInset.left - edgeInset.right)/pointDatas.count;
        
        //添加折线图层
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.frame         = self.bounds;                    // 与showView的frame一致
        lineLayer.strokeColor   = lineColor.CGColor;              // 边缘线的颜色
        lineLayer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
        lineLayer.lineCap       = kCALineCapRound;               // 边缘线的类型
        lineLayer.lineWidth     = lineWidth;                      // 线条宽度
        
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        NSMutableArray *points = [NSMutableArray array];
        for (int i = 0; i < pointDatas.count; i++) {
            NSNumber *yValue = pointDatas[i];
            CGPoint point = CGPointMake(divideWidth * i + edgeInset.left + divideWidth/2, (self.bounds.size.height - edgeInset.bottom)*(1 - [yValue doubleValue]/maxValue));
            [points addObject:[NSValue valueWithCGPoint:point]];
            if (i == 0) {
                [linePath moveToPoint:point];
            } else {
                [linePath addLineToPoint:point];
            }
        }
        lineLayer.path = linePath.CGPath;
        [self.layer addSublayer:lineLayer];
        
        //添加折线图层动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 1.5;
        animation.fromValue = @(0.0);
        animation.toValue = @(1.0);
        [lineLayer addAnimation:animation forKey:@"strokeEnd"];
        
        //添加点图层
        [points enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CAShapeLayer *pointLayer = [CAShapeLayer layer];
            pointLayer.frame         = self.bounds;                    // 与showView的frame一致
            pointLayer.strokeColor   = pointColor.CGColor;             // 边缘线的颜色
            pointLayer.fillColor     = pointColor.CGColor;             // 闭环填充的颜色
            pointLayer.lineCap       = kCALineCapSquare;               // 边缘线的类型
            pointLayer.lineWidth     = 0;                      // 线条宽度
            
            UIBezierPath *pointPath = [UIBezierPath bezierPathWithArcCenter:[obj CGPointValue] radius:lineWidth * 3 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
            pointLayer.path = pointPath.CGPath;
            [self.layer addSublayer:pointLayer];
            
            //添加数值文本
            UILabel *valueLabel = [[UILabel alloc] init];
            [self addSubview:valueLabel];
            valueLabel.hidden = !isShow;
            valueLabel.text = [NSString stringWithFormat:@"%.1f", [pointDatas[idx] doubleValue]];
            valueLabel.textColor = valueTextColor;
            valueLabel.font = [UIFont systemFontOfSize:ValueLabelSize];
            valueLabel.textAlignment = NSTextAlignmentCenter;
            CGSize textSize = [valueLabel.text sizeWithAttributes:@{NSFontAttributeName:valueLabel.font}];
            valueLabel.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
            valueLabel.center = CGPointMake([points[idx] CGPointValue].x, [points[idx] CGPointValue].y - 12);
        }];
    }
    return (self);
}

@end

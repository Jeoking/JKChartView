//
//  JKCakeView.m
//  SaleActivity
//
//  Created by JayKing on 17/7/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import "JKCakeView.h"

//数据显示字体大小
static const CGFloat ValueLabelSize = 15;

@interface JKCakeView()

@end

@implementation JKCakeView {
    CGFloat _cakeEndAngle;   //饼状图每块结束角度
}

/**
 饼状图

 @param frame frame
 @param cakeDatas 百分比数据 0 < x < 1
 @param colors  色值 可传空
 @return self
 */
- (instancetype)initCakeViewWithFrame:(CGRect)frame datas:(NSArray <NSNumber *>*)cakeDatas colors:(NSArray <UIColor *>*)colors {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        [self addCakeDatas:cakeDatas colors:colors];
    }
    return (self);
}

/**
 添加饼状图
 
 @param cakeDatas 数据数组
 @param colors 颜色数组
 */
- (void)addCakeDatas:(NSArray <NSNumber *>*)cakeDatas colors:(NSArray <UIColor *>*)colors {
    if (cakeDatas.count == 0) {
        return;
    }
    [cakeDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *cakeLayer = [CAShapeLayer layer];
        cakeLayer.frame         = self.bounds;                         // 与showView的frame一致
        
        cakeLayer.strokeColor   = [[UIColor whiteColor] CGColor];    // 边缘线的颜色
        cakeLayer.fillColor     = ((UIColor *)colors[idx]).CGColor;    // 闭环填充的颜色
        cakeLayer.lineCap       = kCALineCapSquare;                    // 边缘线的类型
        cakeLayer.lineWidth     = 1;                                   // 线条宽度
        //添加扇形图层
        CGFloat percentValue = [obj floatValue];
        _cakeEndAngle += M_PI * 2 * percentValue;
        CGFloat cakeStartAngle = _cakeEndAngle - M_PI * 2 * percentValue;
        CGPoint centerPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        UIBezierPath *cakePath = [UIBezierPath bezierPath];
        [cakePath moveToPoint:centerPoint];
        [cakePath addArcWithCenter:centerPoint radius:self.bounds.size.width/2 startAngle:cakeStartAngle endAngle:_cakeEndAngle clockwise:YES];
        [cakePath closePath];
        cakeLayer.path = cakePath.CGPath;
        [self.layer addSublayer:cakeLayer];
        
        //添加文本图层
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.frame = CGRectMake(centerPoint.x + cosf((cakeStartAngle + _cakeEndAngle) / 2) * self.bounds.size.width/3.5 - 15, centerPoint.y + sinf((cakeStartAngle + _cakeEndAngle) / 2) * self.bounds.size.width/3.5 - 10, 60, 20);
        textLayer.string = [NSString stringWithFormat:@"%.1f%%", percentValue * 100];
        textLayer.fontSize = ValueLabelSize;
        textLayer.contentsScale = 2;
        [cakeLayer addSublayer:textLayer];
    }];
}

@end

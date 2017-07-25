//
//  JKProgressView.m
//  SaleActivity
//
//  Created by JayKing on 17/7/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import "JKProgressView.h"

//数据显示字体大小
static const CGFloat ValueLabelSize = 8;

@interface JKProgressView()

@end

@implementation JKProgressView {
    UILabel *_progressLabel;
    CAShapeLayer *_trackLayer;
    NSString *_progressText;
}

/**
 初始化竖向进度条

 @param frame frame
 @param bgColor 进度条背景色
 @param progressColor 进度条颜色
 @param progressText 进度值文本
 @return self
 */
- (instancetype)initVerticalProgressWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor progressColor:(UIColor *)progressColor progressText:(NSString *)progressText {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = bgColor;
        
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.frame = self.bounds;
        //设置路径颜色
        [self.layer addSublayer:_trackLayer];
        _trackLayer.strokeColor = [progressColor CGColor];
        
        //指定线的边缘是圆的
        _trackLayer.lineCap = kCALineCapButt;
        //线的宽度
        _trackLayer.lineWidth = self.bounds.size.width;
        //设置进度条路径
        _progressText = progressText;
    }
    return (self);
}

/**
 初始化横向进度条
 
 @param frame frame
 @param bgColor 进度条背景色
 @param progressColor 进度条颜色
 @param progressText 进度值文本
 @param lineCapType 进度条类型
 @return self
 */
- (instancetype)initLandscapeProgressWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor progressColor:(UIColor *)progressColor progressText:(NSString *)progressText progressLineCapType:(JKProgressLineCapType)lineCapType {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        //背景
        CAShapeLayer *bgLayer = [CAShapeLayer layer];
        bgLayer.frame = self.bounds;
        //设置背景路径颜色
        [self.layer addSublayer:bgLayer];
        bgLayer.strokeColor = [bgColor CGColor];
        //进度条
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.frame = self.bounds;
        //设置进度条路径颜色
        [self.layer addSublayer:_trackLayer];
        _trackLayer.strokeColor = [progressColor CGColor];
        
        //指定线的边缘是圆的
        if (lineCapType == JKProgressRoundType) {
            _trackLayer.lineCap = kCALineCapRound;
            bgLayer.lineCap = kCALineCapRound;
        } else {
            _trackLayer.lineCap = kCALineCapButt;
            bgLayer.lineCap = kCALineCapButt;
        }
        //线的宽度
        bgLayer.lineWidth = self.bounds.size.height;
        _trackLayer.lineWidth = self.bounds.size.height;
        //设置进度条路径
        UIBezierPath *bgPath = [UIBezierPath bezierPath];
        [bgPath moveToPoint:CGPointMake(0, self.bounds.size.height/2)];
        [bgPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height/2)];
        bgLayer.path =[bgPath CGPath];
        
        _progressText = progressText;
    }
    return (self);
}

- (void)setVerticalProgress:(CGFloat)verticalProgress {
    _verticalProgress = verticalProgress;
    if (_verticalProgress > 0 && _verticalProgress <= 1) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(_trackLayer.bounds.size.width/2, _trackLayer.bounds.size.height)];
        [path addLineToPoint:CGPointMake(_trackLayer.bounds.size.width/2, _trackLayer.bounds.size.height * (1-_verticalProgress))];
        _trackLayer.path =[path CGPath];
        //添加动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 0.5;
        animation.fromValue = @(0.0);
        animation.toValue = @(1.0);
        [_trackLayer addAnimation:animation forKey:@"strokeEnd"];
    }
    //添加进度文字标题
    _progressLabel = [[UILabel alloc] init];
    [self addSubview:_progressLabel];
    _showProgressText = YES;
    _verticalProgress = isnan(_verticalProgress) ? 0 : _verticalProgress;
    if (_progressText.length > 0 && _verticalProgress < 1) {
        _progressLabel.hidden = NO;
        _progressLabel.text = _progressText;
        _progressLabel.textColor = [UIColor whiteColor];
        _progressLabel.font = [UIFont systemFontOfSize:ValueLabelSize];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        CGSize textSize = [_progressLabel.text sizeWithAttributes:@{NSFontAttributeName:_progressLabel.font}];
        _progressLabel.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
        _progressLabel.center = CGPointMake(_trackLayer.bounds.size.width/2, _trackLayer.bounds.size.height);
        [UIView animateWithDuration:0.5 animations:^{
            _progressLabel.center = CGPointMake(_trackLayer.bounds.size.width/2, _trackLayer.bounds.size.height * (1-_verticalProgress) - 10);
        }];
    } else {
        _progressLabel.hidden = YES;
    }
}

- (void)setLandscapeProgress:(CGFloat)landscapeProgress {
    _landscapeProgress = landscapeProgress;
    if (_landscapeProgress > 0 && _landscapeProgress <= 1) {
        //设置进度条路径
        UIBezierPath *progressPath = [UIBezierPath bezierPath];
        [progressPath moveToPoint:CGPointMake(0, _trackLayer.bounds.size.height/2)];
        [progressPath addLineToPoint:CGPointMake(_trackLayer.bounds.size.width * _landscapeProgress, _trackLayer.bounds.size.height/2)];
        _trackLayer.path =[progressPath CGPath];
        //添加动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 0.5;
        animation.fromValue = @(0.0);
        animation.toValue = @(1.0);
        [_trackLayer addAnimation:animation forKey:@"strokeEnd"];
    }
    //添加进度文字标题
    _progressLabel = [[UILabel alloc] init];
    [self addSubview:_progressLabel];
    _showProgressText = YES;
    _landscapeProgress = isnan(_landscapeProgress) ? 0 : _landscapeProgress;
    if (_progressText.length > 0 && _landscapeProgress < 1) {
        _progressLabel.hidden = NO;
        _progressLabel.text = _progressText;
        _progressLabel.textColor = [UIColor whiteColor];
        _progressLabel.font = [UIFont systemFontOfSize:ValueLabelSize];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        CGSize textSize = [_progressLabel.text sizeWithAttributes:@{NSFontAttributeName:_progressLabel.font}];
        _progressLabel.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
        _progressLabel.center = CGPointMake(textSize.width/2 + 4, _trackLayer.bounds.size.height/2);
        if (_landscapeProgress > 0) {
            [UIView animateWithDuration:0.5 animations:^{
                _progressLabel.center = CGPointMake(_trackLayer.bounds.size.width * _landscapeProgress + textSize.width/2 + 12, _trackLayer.bounds.size.height/2);
            }];
        }
    } else {
        _progressLabel.hidden = YES;
    }
}

/**
 设置进度标题字体颜色

 @param progressTextColor 字体颜色
 */
- (void)setProgressTextColor:(UIColor *)progressTextColor {
    _progressTextColor = progressTextColor;
    _progressLabel.textColor = progressTextColor;
}

/**
 设置进度条颜色
 
 @param progressColor 进度条颜色
 */
- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    _trackLayer.strokeColor = [progressColor CGColor];
}


/**
 设置是否显示进度标题

 @param showProgressText 是否显示
 */
- (void)setShowProgressText:(BOOL)showProgressText {
    _showProgressText = showProgressText;
    //当文本内容为空
    if (_progressLabel.text.length == 0) {
        _showProgressText = NO;
        _progressLabel.hidden = YES;
        return;
    }
    _progressLabel.hidden = !_showProgressText;
}

@end

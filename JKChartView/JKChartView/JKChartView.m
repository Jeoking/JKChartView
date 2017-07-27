//
//  JKChartView.m
//  SaleActivity
//
//  Created by JayKing on 17/7/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import "JKChartView.h"
#import "JKCakeView.h"
#import "JKColorInfoView.h"
#import "JKLineView.h"

//图表左边间距
static const CGFloat LeftSpace = 40;
//图表右边间距
static const CGFloat RightSpace = 8;
//图表底部间距
static const CGFloat BottomSpace = 30;
//X轴标题字体大小
static const CGFloat XTitleLabelSize = 10;
//Y轴标题字体大小
static const CGFloat YTitleLabelSize = 10;
//饼状图颜色描述信息view高度
static const CGFloat CakeColorInfoViewHeight = 16.0;
//条状表颜色描述信息view宽度
static const CGFloat ProgressColorInfoViewWidth = 110.0;

@interface JKChartView()

@property (strong, nonatomic) NSMutableArray *progressViews; //进度条视图容器

@property (strong, nonatomic) NSMutableArray *yLabelViews; //Y轴文本视图容器

@property (strong, nonatomic) NSMutableArray *xLabelViews; //X轴文本视图容器

@property (strong, nonatomic) NSMutableArray *divideLineViews; //Y等分线

@end

@implementation JKChartView {
    UIView *_xLine;   //X轴线
    UIView *_yLine;   //Y轴线
}

/**
 初始化方法

 @param frame frame
 @param xTitles X轴标题数组
 @param yTitles Y轴标题数组
 @param xTitleColor X轴标题文字颜色
 @param yTitleColor Y轴标题文字颜色
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame xTitles:(NSArray <NSString *>*)xTitles yTitles:(NSArray <NSString *>*)yTitles xTitleColor:(UIColor *)xTitleColor yTitleColor:(UIColor *)yTitleColor {
    self = [super initWithFrame:frame];
    if(self) {
        [self addXTitles:xTitles xTitleColor:xTitleColor];
        [self addYTitles:yTitles yTitleColor:yTitleColor];
        [self addXYLine];
        [self addYDivideLines:yTitles.count];
    }
    return (self);
}

/**
 初始化方法

 @param frame frame
 @param xMaxValue X轴最大数值
 @param xDivideCount X轴等分数
 @param yMaxValue Y轴最大数值
 @param yDivideCount Y轴等分数
 @param xTitleColor X轴标题文字颜色
 @param yTitleColor Y轴标题文字颜色
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame xMaxValue:(NSInteger)xMaxValue xDivideCount:(NSInteger)xDivideCount yMaxValue:(NSInteger)yMaxValue yDivideCount:(NSInteger)yDivideCount xTitleColor:(UIColor *)xTitleColor yTitleColor:(UIColor *)yTitleColor {
    self = [super initWithFrame:frame];
    if(self) {
        //设置X轴标题
        NSInteger xDivideValue = xMaxValue/xDivideCount;
        NSMutableArray *xTitles = [NSMutableArray array];
        for (int i = 0; i < xDivideCount; i++) {
            [xTitles addObject:[NSString stringWithFormat:@"%ld", xDivideValue*(i+1)]];
        }
        //设置Y轴标题
        NSInteger yDivideValue = yMaxValue/yDivideCount;
        NSMutableArray *yTitles = [NSMutableArray array];
        for (int i = 1; i < yDivideCount; i++) {
            [yTitles addObject:[NSString stringWithFormat:@"%ld", yDivideValue*i]];
        }
        
        [self addXTitles:xTitles xTitleColor:xTitleColor];
        [self addYTitles:yTitles yTitleColor:yTitleColor];
        [self addXYLine];
        [self addYDivideLines:yDivideCount - 1];
        
    }
    return (self);
}

/**
 饼状图初始化

 @param frame frame
 @param cakeDatas 百分比数据 0<x<1
 @param cakeColors 颜色值数组 若传空，则使用随机色值
 @param cakeInfos 颜色代表的数据数组
 @return self
 */
- (instancetype)initCakeViewWithFrame:(CGRect)frame cakeDatas:(NSArray <NSNumber *>*)cakeDatas cakeColors:(NSArray <UIColor *>*)cakeColors cakeInfos:(NSArray <NSString *>*)cakeInfos {
    self = [super initWithFrame:frame];
    if(self) {
        if (!cakeDatas || cakeDatas.count == 0) {
            return self;
        }
        NSMutableArray *randomColors;
        if (cakeColors.count == 0) {
            //随机填充颜色
            randomColors = [NSMutableArray array];
            for (int i = 0; i < cakeDatas.count; i++) {
                //添加随机色
                [randomColors addObject:[UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.0]];
            }
        }
        [self addCakeView:[[JKCakeView alloc] initCakeViewWithFrame:CGRectMake(0, 0, frame.size.height , frame.size.height) datas:cakeDatas colors:cakeColors.count == 0 ? randomColors : cakeColors] cakeInfos:cakeInfos cakeColors:cakeColors.count == 0 ? randomColors : cakeColors];
    }
    return self;
}

#pragma mark - private method

/**
 添加饼状图

 @param cakeView 饼状视图
 @param cakeInfos 描述文本
 @param cakeColors 色块颜色值
 */
- (void)addCakeView:(JKCakeView *)cakeView cakeInfos:(NSArray *)cakeInfos cakeColors:(NSArray *)cakeColors {
    //添加饼状图
    [self addSubview:cakeView];
    //添加描述信息文本
    CGFloat tagInfoViewHeight = CakeColorInfoViewHeight;
    CGFloat tagInfoViewWidth = self.bounds.size.width - cakeView.bounds.size.width - 12;
    for (int i = 0; i < cakeInfos.count; i++) {
        JKColorInfoView *colorInfoView = [[JKColorInfoView alloc] initWithFrame:CGRectMake(self.bounds.size.width - tagInfoViewWidth, (tagInfoViewHeight + 8) * i + 16, tagInfoViewWidth , tagInfoViewHeight) title:cakeInfos[i] color:cakeColors[i]];
        [self addSubview:colorInfoView];
    }
}

//添加Y轴等分线
- (void)addYDivideLines:(NSInteger)lineCount {
    [self.divideLineViews removeAllObjects];
    CGFloat lineCenterY = (self.bounds.size.height - BottomSpace)/(lineCount+1);
    for (int i = 0; i < lineCount; i++) {
        UIView *divideLine = [[UIView alloc] init];
        divideLine.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.1];
        divideLine.frame = CGRectMake(LeftSpace, 0, self.bounds.size.width - LeftSpace, 0.5);
        divideLine.center = CGPointMake((self.bounds.size.width + LeftSpace)/2, lineCenterY*(i+1));
        [self addSubview:divideLine];
        [self.divideLineViews addObject:divideLine];
    }
}

//添加XY轴边界线
- (void)addXYLine {
    _xLine = [[UIView alloc] init];
    _xLine.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.1];
    _xLine.frame = CGRectMake(LeftSpace, self.bounds.size.height - BottomSpace, self.bounds.size.width - LeftSpace, 0.5);
    [self addSubview:_xLine];
    
    _yLine = [[UIView alloc] init];
    _yLine.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.1];
    _yLine.frame = CGRectMake(LeftSpace, 0, 0.5, self.bounds.size.height - BottomSpace);
    [self addSubview:_yLine];
}

/**
 添加X轴标题文本

 @param xTitles X轴标题数组  数值有小到大添加
 @param xTitleColor X轴标题颜色
 */
- (void)addXTitles:(NSArray *)xTitles xTitleColor:(UIColor *)xTitleColor {
    if (!xTitles || xTitles.count == 0) {
        return;
    }
    UIColor *titleColor = [UIColor whiteColor];
    if (xTitleColor) {
        titleColor = xTitleColor;
    }
    [self.xLabelViews removeAllObjects];
    CGFloat chartWidth = self.bounds.size.width - LeftSpace - RightSpace;
    CGFloat titleWidth = chartWidth/xTitles.count;
    for (int i = 0; i < xTitles.count; i++) {
        UILabel *xTitleLabel = [[UILabel alloc] init];
        [self addSubview:xTitleLabel];
        xTitleLabel.text = xTitles[i];
        xTitleLabel.textColor = titleColor;
        xTitleLabel.font = [UIFont systemFontOfSize:XTitleLabelSize];
        xTitleLabel.textAlignment = NSTextAlignmentCenter;
        xTitleLabel.frame = CGRectMake(LeftSpace + titleWidth * i, self.bounds.size.height - BottomSpace + 8, titleWidth, 12);
        [self.xLabelViews addObject:xTitleLabel];
    }
}

/**
 添加Y轴标题文本

 @param yTitles Y轴标题数组  数值有小到大添加
 @param yTitleColor Y轴标题颜色
 */
- (void)addYTitles:(NSArray *)yTitles yTitleColor:(UIColor *)yTitleColor {
    if (!yTitles || yTitles.count == 0) {
        return;
    }
    UIColor *titleColor = [UIColor whiteColor];
    if (yTitleColor) {
        titleColor = yTitleColor;
    }
    [self.yLabelViews removeAllObjects];
    yTitles = [[yTitles reverseObjectEnumerator] allObjects];
    CGFloat chartHeigh = self.bounds.size.height - BottomSpace;
    CGFloat titleCenterY = chartHeigh/(yTitles.count+1);
    for (int i = 0; i < yTitles.count; i++) {
        UILabel *yTitleLabel = [[UILabel alloc] init];
        [self addSubview:yTitleLabel];
        yTitleLabel.text = yTitles[i];
        yTitleLabel.textColor = titleColor;
        yTitleLabel.font = [UIFont systemFontOfSize:YTitleLabelSize];
        yTitleLabel.textAlignment = NSTextAlignmentRight;
        yTitleLabel.frame = CGRectMake(0, 0, LeftSpace - 8, 10);
        yTitleLabel.center = CGPointMake(LeftSpace/2, titleCenterY*(i+1));
        [self.yLabelViews addObject:yTitleLabel];
    }
}

/**
 获取整数位数
 
 @param num 整数
 @return 位数
 */
- (NSInteger)getInterLength:(NSInteger)num {
    NSInteger sum = 0;
    while( num >= 1 ) {
        num=num/10;
        sum++;
    }
    return sum;
}

/**
 计算Y轴整形最大值

 @param yMaxValue
 @return Y轴最大值
 */
- (NSInteger)getAxisMaxValue:(double)yMaxValue {
    NSInteger maxLen = [self getInterLength:(NSInteger)yMaxValue];
    NSInteger firstNum = (NSInteger)yMaxValue/pow(10, maxLen - 1);
    NSInteger maxValue = (firstNum + 1) * pow(10, maxLen - 1);
    if (maxValue > 10000 && maxValue <100000) {
        maxValue = self.yLabelViews.count + 1;
    } else if (maxValue > 100000) {
        maxValue = maxValue / 10000;
    }
    return maxValue;
}

#pragma mark - public method

/**
 设置Y轴数值

 @param maxValue Y轴最大值
 */
- (void)setYMaxValue:(double)maxValue {
    _yMaxValue = maxValue;
    NSInteger yDivideValue = maxValue/(self.yLabelViews.count + 1);
    for (int i = 0; i < self.yLabelViews.count; i++) {
        UILabel *yLabel = self.yLabelViews[self.yLabelViews.count - 1 - i];
        yLabel.text = [NSString stringWithFormat:@"%ld", yDivideValue*(i+1)];
    }
}

/**
 添加一组进度条  与Y轴平行
 
 @param yDatas 传入数值 NSNumber类型数组
 @param progressColor 进度条颜色
 @param progressInfo 进度条含义
 @param progressTextColor 进度文本字体颜色
 @param isShow 是否显示进度文本
 */
- (void)addYDatas:(NSArray <NSNumber *>*)yDatas progressColor:(UIColor *)progressColor progressInfo:(NSString *)progressInfo progressTextColor:(UIColor *)progressTextColor showProgressText:(BOOL)isShow {
    if (!yDatas || yDatas.count == 0) {
        return;
    }
    //清除进度条view
    [self removeProgressViews];
    //获取最大值以便计算Y轴最大值
    double yMaxValue = [[yDatas valueForKeyPath:@"@max.doubleValue"] doubleValue];
    //获取Y轴最大值
    NSInteger yAxisMaxValue = [self getAxisMaxValue:yMaxValue];
    //重新计算Y轴数据
    [self setYMaxValue:yAxisMaxValue > 10000 ? yAxisMaxValue/10000 : yAxisMaxValue];
    //计算进度条宽度
    CGFloat progressViewWidth = (self.bounds.size.width - LeftSpace - RightSpace)*2/(yDatas.count*5);
    //计算X轴每等分宽度
    CGFloat divideWidth = (self.bounds.size.width - LeftSpace - RightSpace)/yDatas.count;
    //获取进度条色值数组
    const CGFloat *colorComponents = CGColorGetComponents(progressColor.CGColor);
    for (int i = 0; i < yDatas.count; i++) {
        NSNumber *yValue = yDatas[i];
        JKProgressView *progressView = [[JKProgressView alloc] initVerticalProgressWithFrame:CGRectMake(divideWidth * i + LeftSpace, 0, progressViewWidth, self.bounds.size.height - BottomSpace) bgColor:[UIColor colorWithRed:colorComponents[0] green:colorComponents[1] blue:colorComponents[2] alpha:0.1] progressColor:progressColor progressText:[NSString stringWithFormat:@"%.1f", [yValue doubleValue]]];
        progressView.verticalProgress = [yValue doubleValue]/yAxisMaxValue;
        progressView.progressTextColor = progressTextColor ? : [UIColor whiteColor];
        progressView.showProgressText = isShow;
        [self addSubview:progressView];
        [self.progressViews addObject:progressView];
    }
    //添加色块信息
    if (progressInfo) {
        JKColorInfoView *firstColorInfoView = [[JKColorInfoView alloc] initWithFrame:CGRectMake(self.bounds.size.width - ProgressColorInfoViewWidth - 8, 6, ProgressColorInfoViewWidth, 12) title:progressInfo color:progressColor];
        [self addSubview:firstColorInfoView];
        [self.progressViews addObject:firstColorInfoView];
    }
    for (UILabel *xTitleLabel in self.xLabelViews) {
        xTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
}

/**
 添加两组进度条  与Y轴平行
 
 @param firstYDatas  第一组数据 传入数值 NSNumber类型数组
 @param secondYDatas 第二组数据 传入数值 NSNumber类型数组
 @param firstProgressColor 第一组进度条颜色
 @param secondProgressColor 第二组进度文本字体颜色
 @param firstProgressInfo 第一组进度条含义
 @param secondProgressInfo 第二组进度条含义
 @param progressTextColor 进度条数值文本颜色
 @param isShow 是否显示进度文本
 */
- (void)addTwoGroupYDatas:(NSArray <NSNumber *>*)firstYDatas secondYDatas:(NSArray <NSNumber *>*)secondYDatas firstProgressColor:(UIColor *)firstProgressColor secondProgressColor:(UIColor *)secondProgressColor firstProgressInfo:(NSString *)firstProgressInfo secondProgressInfo:(NSString *)secondProgressInfo progressTextColor:(UIColor *)progressTextColor showProgressText:(BOOL)isShow {
    //清除进度条view
    [self removeProgressViews];
    JKColorInfoView *firstColorInfoView;
    JKColorInfoView *secondColorInfoView;
    
    //获取最大值以便计算Y轴最大值
    double yFirstMaxValue = [[firstYDatas valueForKeyPath:@"@max.doubleValue"] doubleValue];
    double ySecondMaxValue = [[secondYDatas valueForKeyPath:@"@max.doubleValue"] doubleValue];
    double yMaxValue = MAX(yFirstMaxValue, ySecondMaxValue);
    //获取Y轴最大值
    double yAxisMaxValue = [self getAxisMaxValue:yMaxValue];
    //重新计算Y轴数据
    [self setYMaxValue:yAxisMaxValue > 10000 ? yAxisMaxValue/10000 : yAxisMaxValue];
    //添加第一组数据
    if (firstYDatas.count > 0) {
        //计算进度条宽度
        CGFloat progressViewWidth = (self.bounds.size.width - LeftSpace - RightSpace)*2/(firstYDatas.count*5);
        //计算X轴每等分宽度
        CGFloat divideWidth = (self.bounds.size.width - LeftSpace - RightSpace)/firstYDatas.count;
        //获取进度条色值数组
        const CGFloat *colorComponents = CGColorGetComponents(firstProgressColor.CGColor);
        for (int i = 0; i < firstYDatas.count; i++) {
            NSNumber *yValue = firstYDatas[i];
            JKProgressView *progressView = [[JKProgressView alloc] initVerticalProgressWithFrame:CGRectMake(divideWidth * i + LeftSpace, 0, progressViewWidth, self.bounds.size.height - BottomSpace) bgColor:[UIColor colorWithRed:colorComponents[0] green:colorComponents[1] blue:colorComponents[2] alpha:0.1] progressColor:firstProgressColor progressText:[NSString stringWithFormat:@"%.1f", [yValue doubleValue]]];
            progressView.verticalProgress = [yValue doubleValue]/yAxisMaxValue;
            progressView.progressTextColor = progressTextColor;
            progressView.showProgressText = isShow;
            [self addSubview:progressView];
            [self.progressViews addObject:progressView];
        }
        //添加色块信息
        if (firstProgressInfo) {
            firstColorInfoView = [[JKColorInfoView alloc] initWithFrame:CGRectMake(self.bounds.size.width - ProgressColorInfoViewWidth - 8, 6, ProgressColorInfoViewWidth, 12) title:firstProgressInfo color:firstProgressColor];
            [self addSubview:firstColorInfoView];
            [self.progressViews addObject:firstColorInfoView];
        }
    }
    //添加第二组数据
    if (secondYDatas.count > 0) {
        //计算进度条宽度
        CGFloat progressViewWidth = (self.bounds.size.width - LeftSpace - RightSpace)*2/(secondYDatas.count*5);
        //计算X轴每等分宽度
        CGFloat divideWidth = (self.bounds.size.width - LeftSpace - RightSpace)/secondYDatas.count;
        //获取进度条色值数组
        const CGFloat *colorComponents = CGColorGetComponents(secondProgressColor.CGColor);
        for (int i = 0; i < secondYDatas.count; i++) {
            NSNumber *yValue = secondYDatas[i];
            JKProgressView *progressView = [[JKProgressView alloc] initVerticalProgressWithFrame:CGRectMake(divideWidth * i + LeftSpace + progressViewWidth, 0, progressViewWidth, self.bounds.size.height - BottomSpace) bgColor:[UIColor colorWithRed:colorComponents[0] green:colorComponents[1] blue:colorComponents[2] alpha:0.1] progressColor:secondProgressColor progressText:[NSString stringWithFormat:@"%.1f", [yValue doubleValue]]];
            progressView.verticalProgress = [yValue doubleValue]/yAxisMaxValue;
            progressView.progressTextColor = progressTextColor;
            progressView.showProgressText = isShow;
            [self addSubview:progressView];
            [self.progressViews addObject:progressView];
        }
        //添加色块信息
        if (secondProgressInfo) {
            secondColorInfoView = [[JKColorInfoView alloc] initWithFrame:CGRectMake(self.bounds.size.width - ProgressColorInfoViewWidth - 8, 6 * 2 + 12, ProgressColorInfoViewWidth, 12) title:secondProgressInfo color:secondProgressColor];
            [self addSubview:secondColorInfoView];
            [self.progressViews addObject:secondColorInfoView];
        }
    }
    //将色值信息view放到顶层
    if (firstColorInfoView) {
        [self bringSubviewToFront:firstColorInfoView];
    }
    if (secondColorInfoView) {
        [self bringSubviewToFront:secondColorInfoView];
    }
}

/**
 添加横向条 与X轴平行
 
 @param xDatas 传入数值 NSNumber类型数组
 @param xMaxValue X轴最大值，若传0，则智能计算
 @param bgColor 进度条背景色
 @param progressColor 进度条颜色
 @param progressWidth 进度条宽度
 @param progressLineCapType 进度条类型
 @param progressTextColor 进度文本字体颜色
 @param isShow 是否显示进度文本
 */
- (void)addXDatas:(NSArray <NSNumber *>*)xDatas xMaxValue:(double)xMaxValue progressBgColor:(UIColor *)bgColor progressColor:(UIColor *)progressColor progressWidth:(CGFloat)progressWidth progressLineCapType:(JKProgressLineCapType)progressLineCapType progressTextColor:(UIColor *)progressTextColor showProgressText:(BOOL)isShow {
    if (!xDatas || xDatas.count == 0) {
        return;
    }
    //若xMaxValue为0，则智能计算
    if (xMaxValue == 0) {
        //获取最大值以便计算X轴最大值
        double maxValue = [[xDatas valueForKeyPath:@"@max.doubleValue"] doubleValue];
        //获取Y轴最大值
        xMaxValue = [self getAxisMaxValue:maxValue];
    }
    //清除进度条view
    [self removeProgressViews];
    CGFloat chartHeigh = self.bounds.size.height - BottomSpace;
    CGFloat progressCenterY = chartHeigh/(xDatas.count+1);
    for (int i = 0; i < xDatas.count; i++) {
        double xValue = [xDatas[i] doubleValue];
        NSString *prgressText;
        if (xValue > 10000) {
            prgressText = [NSString stringWithFormat:@"%.2f", xValue/10000];
        } else {
            prgressText = [NSString stringWithFormat:@"%.2f", xValue];
        }
        JKProgressView *progressView;
        if (progressLineCapType == JKProgressRoundType) {
            progressView = [[JKProgressView alloc] initLandscapeProgressWithFrame:CGRectMake(LeftSpace + progressWidth/2, progressCenterY*(i+1) - progressWidth/2, self.bounds.size.width - LeftSpace - RightSpace - progressWidth/2 , progressWidth) bgColor:bgColor progressColor:progressColor progressText:prgressText progressLineCapType:progressLineCapType];
        } else {
            progressView = [[JKProgressView alloc] initLandscapeProgressWithFrame:CGRectMake(LeftSpace, progressCenterY*(i+1), self.bounds.size.width - LeftSpace - RightSpace, progressWidth) bgColor:bgColor progressColor:progressColor progressText:prgressText progressLineCapType:progressLineCapType];
        }
        progressView.landscapeProgress = xValue/xMaxValue;
        progressView.progressTextColor = progressTextColor;
        progressView.showProgressText = isShow;
        [self addSubview:progressView];
        [self.progressViews addObject:progressView];
    }
}

/**
 添加折线图标

 @param pointDatas 折线图点数据
 @param maxValue 数据最大值
 @param pointColor 点颜色
 @param lineColor 线颜色
 @param lineWidth 线宽
 @param valueTextColor 数值文本颜色
 @param isShow 是否显示数值文本
 */
- (void)addPointLineDatas:(NSArray <NSNumber *>*)pointDatas maxValue:(double)maxValue pointColor:(UIColor *)pointColor lineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth valueTextColor:(UIColor *)valueTextColor showValueText:(BOOL)isShow {
    if (!pointDatas || pointDatas.count == 0) {
        return;
    }
    [self removeProgressViews];
    if (maxValue == 0) {
        //获取最大值以便计算X轴最大值
        double maxNum = [[pointDatas valueForKeyPath:@"@max.doubleValue"] doubleValue];
        //获取Y轴最大值
        maxValue = [self getAxisMaxValue:maxNum];
        //重新计算Y轴数据
        [self setYMaxValue:maxValue > 10000 ? maxValue/10000 : maxValue];
    }
    JKLineView *lineView = [[JKLineView alloc] initLineViewWithFrame:self.bounds pointDatas:pointDatas maxValue:maxValue pointColor:pointColor ? : [UIColor whiteColor] lineColor:lineColor ? : [UIColor whiteColor] lineWidth:lineWidth valueTextColor:valueTextColor ? : [UIColor whiteColor] showValueText:isShow edgeInset:UIEdgeInsetsMake(0, LeftSpace, BottomSpace, RightSpace)];
    [self addSubview:lineView];
    [self.progressViews addObject:lineView];
}

/**
 清除进度条
 */
- (void)removeProgressViews {
    if (!self.progressViews && self.progressViews.count == 0) {
        return;
    }
    for (UIView *view in self.progressViews) {
        [view removeFromSuperview];
    }
    [self.progressViews removeAllObjects];
}

#pragma mark - setter

/**
 设置X轴线颜色

 @param color 色值
 */
- (void)setXLineColor:(UIColor *)color {
    _xLineColor = color;
    _xLine.backgroundColor = color;
}

/**
 设置Y轴线颜色
 
 @param color 色值
 */
- (void)setYLineColor:(UIColor *)color {
    _yLineColor = color;
    _yLine.backgroundColor = color;
}

/**
 设置Y等分线颜色
 
 @param color 色值
 */
- (void)setDivideLineColor:(UIColor *)color {
    _divideLineColor = color;
    for (UIView *lineView in self.divideLineViews) {
        lineView.backgroundColor = color;
    }
}

/**
 设置是否显示X轴标题
 */
- (void)setShowXTitles:(BOOL)showXTitles {
    _showXTitles = showXTitles;
    for (UILabel *label in self.xLabelViews) {
        label.hidden = !showXTitles;
    }
}

/**
 设置是否显示Y轴标题
 */
- (void)setShowYTitles:(BOOL)showYTitles {
    _showYTitles = showYTitles;
    for (UILabel *label in self.yLabelViews) {
        label.hidden = !showYTitles;
    }
}

#pragma mark - getter
- (NSMutableArray *)progressViews {
    if (_progressViews) {
        return _progressViews;
    }
    _progressViews = [NSMutableArray array];
    return _progressViews;
}

- (NSMutableArray *)yLabelViews {
    if (_yLabelViews) {
        return _yLabelViews;
    }
    _yLabelViews = [NSMutableArray array];
    return _yLabelViews;
}

- (NSMutableArray *)xLabelViews {
    if (_xLabelViews) {
        return _xLabelViews;
    }
    _xLabelViews = [NSMutableArray array];
    return _xLabelViews;
}

- (NSMutableArray *)divideLineViews {
    if (_divideLineViews) {
        return _divideLineViews;
    }
    _divideLineViews = [NSMutableArray array];
    return _divideLineViews;
}

@end

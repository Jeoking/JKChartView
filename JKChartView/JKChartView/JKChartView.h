//
//  JKChartView.h
//  SaleActivity
//
//  Created by JayKing on 17/7/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKProgressView.h"

@interface JKChartView : UIView

/**
 初始化方法
 
 @param frame frame
 @param xTitles X轴标题数组
 @param yTitles Y轴标题数组
 @param xTitleColor X轴标题文字颜色
 @param yTitleColor Y轴标题文字颜色
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame xTitles:(NSArray <NSString *>*)xTitles yTitles:(NSArray <NSString *>*)yTitles xTitleColor:(UIColor *)xTitleColor yTitleColor:(UIColor *)yTitleColor;

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
- (instancetype)initWithFrame:(CGRect)frame xMaxValue:(NSInteger)xMaxValue xDivideCount:(NSInteger)xDivideCount yMaxValue:(NSInteger)yMaxValue yDivideCount:(NSInteger)yDivideCount xTitleColor:(UIColor *)xTitleColor yTitleColor:(UIColor *)yTitleColor;

/**
 饼状图初始化
 
 @param frame frame
 @param cakeDatas 百分比数据 0<x<1
 @param cakeColors 颜色值数组 可以为空
 @param cakeInfos 颜色代表的数据数组
 @return self
 */
- (instancetype)initCakeViewWithFrame:(CGRect)frame cakeDatas:(NSArray <NSNumber *>*)cakeDatas cakeColors:(NSArray <UIColor *>*)cakeColors cakeInfos:(NSArray <NSString *>*)cakeInfos;

/**
 添加一组进度条  与Y轴平行
 
 @param yDatas 传入数值 NSNumber类型数组
 @param progressColor 进度条颜色
 @param progressInfo 进度条含义
 @param progressTextColor 进度文本字体颜色
 @param isShow 是否显示进度文本
 */
- (void)addYDatas:(NSArray <NSNumber *>*)yDatas progressColor:(UIColor *)progressColor progressInfo:(NSString *)progressInfo progressTextColor:(UIColor *)progressTextColor showProgressText:(BOOL)isShow;

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
- (void)addTwoGroupYDatas:(NSArray <NSNumber *>*)firstYDatas secondYDatas:(NSArray <NSNumber *>*)secondYDatas firstProgressColor:(UIColor *)firstProgressColor secondProgressColor:(UIColor *)secondProgressColor firstProgressInfo:(NSString *)firstProgressInfo secondProgressInfo:(NSString *)secondProgressInfo progressTextColor:(UIColor *)progressTextColor showProgressText:(BOOL)isShow;

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
- (void)addXDatas:(NSArray <NSNumber *>*)xDatas xMaxValue:(double)xMaxValue progressBgColor:(UIColor *)bgColor progressColor:(UIColor *)progressColor progressWidth:(CGFloat)progressWidth progressLineCapType:(JKProgressLineCapType)progressLineCapType progressTextColor:(UIColor *)progressTextColor showProgressText:(BOOL)isShow;

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
- (void)addPointLineDatas:(NSArray <NSNumber *>*)pointDatas maxValue:(double)maxValue pointColor:(UIColor *)pointColor lineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth valueTextColor:(UIColor *)valueTextColor showValueText:(BOOL)isShow;

/**
 设置Y轴文本
 */
@property (assign, nonatomic) double yMaxValue;

/**
 设置X轴线颜色
 */
@property (strong, nonatomic) UIColor *xLineColor;

/**
 设置Y轴线颜色
 */
@property (strong, nonatomic) UIColor *yLineColor;

/**
 设置Y等分线颜色
 */
@property (strong, nonatomic) UIColor *divideLineColor;

/**
 设置是否显示X轴标题
 */
@property (assign, nonatomic) BOOL showXTitles;

/**
 设置是否显示Y轴标题
 */
@property (assign, nonatomic) BOOL showYTitles;


@end

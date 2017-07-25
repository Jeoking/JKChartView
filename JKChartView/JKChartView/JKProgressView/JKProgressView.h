//
//  JKProgressView.h
//  SaleActivity
//
//  Created by JayKing on 17/7/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JKProgressLineCapType) {
    JKProgressButtType,   //两端方形
    JKProgressRoundType,  //两端圆形
};

@interface JKProgressView : UIView

@property (strong, nonatomic) UIColor *progressTextColor;

@property (strong, nonatomic) UIColor *progressColor;

@property (assign, nonatomic) BOOL showProgressText;

@property (assign, nonatomic) CGFloat verticalProgress;

@property (assign, nonatomic) CGFloat landscapeProgress;

/**
 初始化竖向进度条
 
 @param frame frame
 @param bgColor 进度条背景色
 @param progressColor 进度条颜色
 @param progressText 进度值文本
 @return self
 */
- (instancetype)initVerticalProgressWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor progressColor:(UIColor *)progressColor progressText:(NSString *)progressText;

/**
 初始化横向进度条
 
 @param frame frame
 @param bgColor 进度条背景色
 @param progressColor 进度条颜色
 @param progressText 进度值文本
 @param lineCapType 进度条类型
 @return self
 */
- (instancetype)initLandscapeProgressWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor progressColor:(UIColor *)progressColor progressText:(NSString *)progressText progressLineCapType:(JKProgressLineCapType)lineCapType;

@end

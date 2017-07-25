//
//  JKCakeView.h
//  SaleActivity
//
//  Created by JayKing on 17/7/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKCakeView : UIView

/**
 饼状图
 
 @param frame frame
 @param cakeDatas 百分比数据 0 < x < 1
 @param colors  色值 可传空
 @return self
 */
- (instancetype)initCakeViewWithFrame:(CGRect)frame datas:(NSArray <NSNumber *>*)cakeDatas colors:(NSArray <UIColor *>*)colors;

@end

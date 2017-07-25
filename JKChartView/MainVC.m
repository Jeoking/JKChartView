//
//  ViewController.m
//  JKChartView
//
//  Created by JayKing on 17/7/25.
//  Copyright © 2017年 jeoking. All rights reserved.
//

#import "MainVC.h"
#import "JKChartView.h"

#define UIColorFromHexRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MainVC ()
//单项矩形图
@property (strong, nonatomic) JKChartView *singleRectChartView;
//双项对比矩形图
@property (strong, nonatomic) JKChartView *doubleRectChartView;
//横向图表
@property (strong, nonatomic) JKChartView *landscapeChartView;
//折线图
@property (strong, nonatomic) JKChartView *lineChartView;
//饼状图
@property (strong, nonatomic) JKChartView *cakeChartView;


@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.title = @"JKChartView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISegmentedControl *switchSC = [[UISegmentedControl alloc] initWithItems:@[@"矩形图",@"折线图",@"饼状图"]];
    switchSC.frame = CGRectMake(16, 80, self.view.bounds.size.width - 32, 30);
    switchSC.selectedSegmentIndex = 0;
    [switchSC addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchSC];
    
    [self.view addSubview:self.singleRectChartView];
    [self.view addSubview:self.doubleRectChartView];
    [self.view addSubview:self.landscapeChartView];
}

- (JKChartView *)singleRectChartView {
    if (_singleRectChartView) {
        return _singleRectChartView;
    }
    _singleRectChartView = [[JKChartView alloc] initWithFrame:CGRectMake(0, 130, self.view.bounds.size.width, 200) xMaxValue:12 xDivideCount:12 yMaxValue:2000 yDivideCount:10 xTitleColor:[UIColor whiteColor] yTitleColor:[UIColor whiteColor]];
    _singleRectChartView.backgroundColor = UIColorFromHexRGB(0x2eb6aa);
    
    //添加表数据
    [_singleRectChartView addYDatas:@[@1000,@2000,@5000,@4000,@9000,@3000,@6000,@4000,@2000,@5000,@1000,@3000] progressColor:UIColorFromHexRGB(0x66ece0) progressInfo:@"销售额(元)" progressTextColor:[UIColor whiteColor] showProgressText:YES];
    
    return _singleRectChartView;
}

- (JKChartView *)doubleRectChartView {
    if (_doubleRectChartView) {
        return _doubleRectChartView;
    }
    _doubleRectChartView = [[JKChartView alloc] initWithFrame:CGRectMake(0, 340, self.view.bounds.size.width, 200) xMaxValue:12 xDivideCount:12 yMaxValue:2000 yDivideCount:10 xTitleColor:[UIColor whiteColor] yTitleColor:[UIColor whiteColor]];
    _doubleRectChartView.backgroundColor = UIColorFromHexRGB(0xff6600);
    
    //添加表数据
    [_doubleRectChartView addTwoGroupYDatas:@[@1000,@2000,@5000,@4000,@9000,@3000,@6000,@4000,@2000,@5000,@1000,@3000] secondYDatas:@[@500,@800,@1200,@2000,@4000,@1000,@2000,@1500,@500,@2500,@200,@900] firstProgressColor:UIColorFromHexRGB(0xffb381) secondProgressColor:UIColorFromHexRGB(0xfff3a3)firstProgressInfo:@"销售额(元)" secondProgressInfo:@"毛利率(元)" progressTextColor:nil showProgressText:NO];
    
    return _doubleRectChartView;
}

- (JKChartView *)landscapeChartView {
    if (_landscapeChartView) {
        return _landscapeChartView;
    }
    _landscapeChartView = [[JKChartView alloc] initWithFrame:CGRectMake(0, 550, self.view.bounds.size.width-16, 120) xTitles:nil yTitles:@[@"现金", @"支付宝",@"微信"] xTitleColor:nil yTitleColor:[UIColor darkTextColor]];
    
    //添加表数据
    [_landscapeChartView addXDatas:@[@1000,@3000,@2000] xMaxValue:5000 progressBgColor:UIColorFromHexRGB(0xf6f6f8) progressColor:UIColorFromHexRGB(0xff6600) progressWidth:12 progressLineCapType:JKProgressRoundType progressTextColor:UIColorFromHexRGB(0x999999) showProgressText:YES];
    
    return _landscapeChartView;
}

- (JKChartView *)lineChartView {
    if (_lineChartView) {
        return _lineChartView;
    }
    _lineChartView = [[JKChartView alloc] initWithFrame:CGRectMake(0, 130, self.view.bounds.size.width, 200) xMaxValue:12 xDivideCount:12 yMaxValue:2000 yDivideCount:10 xTitleColor:[UIColor whiteColor] yTitleColor:[UIColor whiteColor]];
    _lineChartView.backgroundColor = UIColorFromHexRGB(0x2eb6aa);
    _lineChartView.xLineColor = UIColorFromHexRGB(0xffffff);
    _lineChartView.yLineColor = UIColorFromHexRGB(0xffffff);
    
    //添加表数据
    [_lineChartView addPointLineDatas:@[@1000,@2000,@5000,@4000,@9000,@3000,@2000,@7000,@2000,@5000,@1000,@3000] maxValue:0 pointColor:UIColorFromHexRGB(0xffffff) lineColor:UIColorFromHexRGB(0xffffff) lineWidth:1.0 valueTextColor:[UIColor whiteColor] showValueText:YES];
    
    return _lineChartView;
}

- (JKChartView *)cakeChartView {
    if (_cakeChartView) {
        return _cakeChartView;
    }
    _cakeChartView = [[JKChartView alloc] initCakeViewWithFrame:CGRectMake(10, 130, self.view.bounds.size.width-20, 260) cakeDatas:@[@0.4,@0.1,@0.3,@0.2] cakeColors:nil cakeInfos:@[@"现金",@"刷卡",@"微信",@"支付宝"]];
    
    return _cakeChartView;
}

- (void)switchAction:(id)sender {
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    switch (sc.selectedSegmentIndex) {
        case 0:
        {
            [self removeView:_cakeChartView];
            [self removeView:_lineChartView];
            _cakeChartView = nil;
            _lineChartView = nil;
            [self.view addSubview:self.singleRectChartView];
            [self.view addSubview:self.doubleRectChartView];
            [self.view addSubview:self.landscapeChartView];
        }
            break;
        case 1:
        {
            [self removeView:_singleRectChartView];
            [self removeView:_doubleRectChartView];
            [self removeView:_landscapeChartView];
            [self removeView:_cakeChartView];
            _singleRectChartView = nil;
            _doubleRectChartView = nil;
            _landscapeChartView = nil;
            _cakeChartView = nil;
            [self.view addSubview:self.lineChartView];
        }
            break;
        case 2:
        {
            [self removeView:_singleRectChartView];
            [self removeView:_doubleRectChartView];
            [self removeView:_landscapeChartView];
            [self removeView:_lineChartView];
            _singleRectChartView = nil;
            _doubleRectChartView = nil;
            _landscapeChartView = nil;
            _lineChartView = nil;
            [self.view addSubview:self.cakeChartView];
        }
            
        default:
            break;
    }
}

- (void)removeView:(UIView *)view {
    if (view) {
        [view removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

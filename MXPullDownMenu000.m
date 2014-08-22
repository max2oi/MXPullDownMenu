//
//  MXPullDownMenu000.m
//  MXPullDownMenu
//
//  Created by 马骁 on 14-8-21.
//  Copyright (c) 2014年 Mx. All rights reserved.
//

#import "MXPullDownMenu000.h"

@implementation MXPullDownMenu000
{
    
    CAShapeLayer *_menu;
    
    CATextLayer *_title_0;
    CAShapeLayer *_indicator_0;
    IndicatorStatus _indicatorStatus_0;
    UITableView *_tableView_0;

    CAShapeLayer *_separatorLine;
    
    CATextLayer *_title_1;
    CAShapeLayer *_indicator_1;
    IndicatorStatus _indicatorStatus_1;
    UITableView *_tableView_1;

    NSArray *_layers;
    
    UIView *_backGroundView;
    BackGroundViewStatus _backGroundViewStatus;
    
    
    
    //*****
    NSArray *_titles;
    NSArray *_indicators;
    NSMutableArray *_indicatorStatus;
    NSArray *_tableViews;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置menu, 并添加手势
        self.backgroundColor = [UIColor whiteColor];
        CGRect theFrame = CGRectMake(frame.origin.x, frame.origin.y, 320, 40);
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
        [self addGestureRecognizer:tapGesture];
        
        _title_0 = [self creatTextLayerWithNSString:@"商品排序" withColor:[UIColor orangeColor] andPosition:CGPointMake(theFrame.size.width / 4, theFrame.size.height / 2)];
        [self.layer addSublayer:_title_0];
        _indicator_0 = [self creatIndicatorWithColor:[UIColor redColor] andPosition:CGPointMake(120, theFrame.size.height / 2)];
        [self.layer addSublayer:_indicator_0];
        _indicatorStatus_0 = IndicatorStateHide;
        
        _separatorLine = [self creatSeparatorLineWithColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:243.0/255.0 alpha:1.0] andPosition:CGPointMake(160, theFrame.size.height / 2)];
        [self.layer addSublayer:_separatorLine];
        
        _title_1 = [self creatTextLayerWithNSString:@"全部商品" withColor:[UIColor orangeColor] andPosition:CGPointMake(theFrame.size.width * 3 / 4, theFrame.size.height / 2)];
        [self.layer addSublayer:_title_1];
        _indicator_1 = [self creatIndicatorWithColor:[UIColor redColor] andPosition:CGPointMake(280, theFrame.size.height / 2)];
        [self.layer addSublayer:_indicator_1];
        _indicatorStatus_1 = IndicatorStateHide;
        
        
        _tableView_0 = [self creatTableWithArray:@[ @"fff" ] atPosition:CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height)];
        _tableView_1 = [self creatTableWithArray:@[ @"fff" ] atPosition:CGPointMake(self.frame.origin.x + self.frame.size.width / 2, self.frame.origin.y + self.frame.size.height)];
        
        //indicatorStatus
        _indicators = @[ _indicator_0, _indicator_1 ];
        _indicatorStatus = [[NSMutableArray alloc] initWithArray:@[ @(_indicatorStatus_0), @(_indicatorStatus_1) ]];
        _titles = @[ _title_0, _title_1 ];
        _tableViews = @[ _tableView_0, _tableView_1 ];
        
        
        
        // 用_layers来保存所有的layers
//        _layers = @[ _title_0, _indicator_0, _separatorLine, _title_1, _indicator_1 ];
        
        // 创建背景
        _backGroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        // 透明
        _backGroundView.opaque = NO;
        // 给背景创建点击事件
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround:)];
        [_backGroundView addGestureRecognizer:gesture];
        
        
        
    }
    return self;
}

#pragma mark - tapEvent



// 处理菜单点击事件.
- (void)tapMenu:(UITapGestureRecognizer *)paramSender
{
    CGPoint touchPoint = [paramSender locationInView:self];
    
    // 思路: 根据indicator的状态去判断.
    NSInteger tapIndex;
    if (touchPoint.x < 160) {
        tapIndex = 0;
        
    } else {
        tapIndex = 1;
    }
    
    //除了被点击的,先全部恢复为初始状态.
    for (int i = 0; i < _indicatorStatus.count; i++) {
        // 若不是被点击的
        if (i != tapIndex) {
            [_indicatorStatus replaceObjectAtIndex:i withObject:@(IndicatorStateHide)];
            IndicatorStatus status = [_indicatorStatus[i] intValue];
            [self animateIndicator:_indicators[i] Forward:(status == IndicatorStateShow) complete:^{
                [self animateTableView:_tableViews[i] show:(status == IndicatorStateShow) complete:^{
                    // 什么也不做
                }];
            }];
        }
    }
    
    // 对于点击的, 更改其状态.
    NSInteger newStatus = ([_indicatorStatus[tapIndex] intValue] == IndicatorStateShow) ? IndicatorStateHide : IndicatorStateShow;
    [_indicatorStatus replaceObjectAtIndex:tapIndex withObject:@(newStatus)];

    // 对点击的做出改变, 对未点击的做出状态判断, 展开的收起来, 没有展开的什么也不做.
    [self animateIndicator:_indicators[tapIndex] Forward:(newStatus == IndicatorStateShow) complete:^{
        [self animateBackGroundView:_backGroundView show:(newStatus == IndicatorStateShow) complete:^{
            [self animateTableView:_tableViews[tapIndex] show:(newStatus == IndicatorStateShow) complete:^{
                // 什么也不做
            }];
        }];
    }];
    

}

- (void)tapBackGround:(UITapGestureRecognizer *)paramSender
{
    // 全部恢复状态.
    for (int i = 0; i < _indicatorStatus.count; i++) {
            [_indicatorStatus replaceObjectAtIndex:i withObject:@(IndicatorStateHide)];
            IndicatorStatus status = [_indicatorStatus[i] intValue];
            [self animateIndicator:_indicators[i] Forward:(status == IndicatorStateShow) complete:^{
                [self animateBackGroundView:_backGroundView show:(status == IndicatorStateShow) complete:^{
                    [self animateTableView:_tableViews[i] show:(status == IndicatorStateShow) complete:^{
                        // 什么也不做
                    }];
                }];
            }];
    }
    
    
    
}


#pragma mark - tableView

- (UITableView *)creatTableWithArray:(NSArray *)array atPosition:(CGPoint)point
{
    UITableView *tableView = [UITableView new];
    
    tableView.frame = CGRectMake(point.x, point.y, 160, 240);
    tableView.rowHeight = 40;
    
    
    return tableView;
}


#pragma mark - animation

- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [self getIndicatorAnimationForward:forward];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim andValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    complete();
}


- (CAKeyframeAnimation *)getIndicatorAnimationForward:(BOOL)forward
{
    CAKeyframeAnimation *animRotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animRotate.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    return animRotate;
}


- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete
{
    
    if (show) {
        
        
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        

        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];

        
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
        
    }
    complete();
    
}

- (void)animateTableView:(UITableView *)tableView show:(BOOL)show complete:(void(^)())complete
{
    if (show) {
        [self.superview addSubview:tableView];
    } else {
        [tableView removeFromSuperview];
    }
    complete();
    
}


#pragma mark - 绘图


- (CAShapeLayer *)creatIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)creatSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,0)];
    [path addLineToPoint:CGPointMake(160, 20)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}

// 创建textLayer
- (CATextLayer *)creatTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point
{
    CATextLayer *layer = [CATextLayer new];
    layer.string = string;
    layer.fontSize = 15.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 20);
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}



@end

#pragma mark - CALayer Category

@implementation CALayer (MXAddAnimationAndValue)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath
{
    // 用了KVC
    [self addAnimation:anim forKey:keyPath];
    [self setValue:value forKeyPath:keyPath];
}


@end

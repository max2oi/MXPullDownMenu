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
    IndicatorState _indicatorStatus_0;
    UITableView *_tableView_0;

    CAShapeLayer *_separatorLine;
    
    CATextLayer *_title_1;
    CAShapeLayer *_indicator_1;
    IndicatorState _indicatorStatus_1;
    UITableView *_tableView_1;

    NSArray *_layers;
    NSArray *_layersOriginPosition;
    NSArray *_layersConvertedPositon;
    
    CGPoint _touchPoint;
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blueColor];
        
        CGRect theFrame = CGRectMake(frame.origin.x, frame.origin.y, 320, 40);
        
        _menu = [self creatMenuWithColor:[UIColor whiteColor]];
        [self.layer addSublayer:_menu];
        
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
        
        _tableView_0 = [self creatTableWithArray:@[@"haha"] atPosition:CGPointMake(0, 0)];
//        [self addSubview:_tableView_0];
        
        
        
        // 用_layers来保存所有的layers
        _layers = @[ _menu, _title_0, _indicator_0, _separatorLine, _title_1, _indicator_1 ];
        _layersOriginPosition = [self getPositionValuesWithLayers:_layers convert:NO];
        _layersConvertedPositon = [self getPositionValuesWithLayers:_layers convert:YES];
        
    }
    return self;
}



- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward
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
}


- (CAKeyframeAnimation *)getIndicatorAnimationForward:(BOOL)forward
{
    CAKeyframeAnimation *animRotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animRotate.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    return animRotate;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    _touchPoint = [self pointWithTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.frame = [UIScreen mainScreen].bounds;
    [self relayoutLayers:_layers convert:YES];

    
    
    if (_touchPoint.x < 160 && [self pointWithTouches:touches].x < 160) {
        [self animateIndicator:_indicator_0 Forward:(_indicatorStatus_0 == IndicatorStateShow)];
        _indicatorStatus_0 = (_indicatorStatus_0 == IndicatorStateShow) ? IndicatorStateHide : IndicatorStateShow;
    }
    if (_touchPoint.x > 160 && [self pointWithTouches:touches].x > 160) {
        [self animateIndicator:_indicator_1 Forward:(_indicatorStatus_1 == IndicatorStateShow)];
        _indicatorStatus_1 = (_indicatorStatus_1 == IndicatorStateShow) ? IndicatorStateHide : IndicatorStateShow;
    }
    

}




- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    return point;
}

#pragma mark - tableView

- (UITableView *)creatTableWithArray:(NSArray *)array atPosition:(CGPoint)point
{
    UITableView *tableView = [UITableView new];
    
    tableView.frame = CGRectMake(point.x, point.y, 160, 240);
    tableView.rowHeight = 40;
    
    
    return tableView;
}

- (void)switchTableView:(UITableView *)tableView show:(BOOL)show
{
    if (show) {
        self.frame = [UIScreen mainScreen].bounds;
        
    }
}


#pragma mark - 绘图

- (CAShapeLayer *)creatMenuWithColor:(UIColor *)color
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    
    layer.path = path.CGPath;
    layer.lineWidth = self.frame.size.height;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    return layer;
}

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

- (void)removeLayers:(NSArray *)layers
{
    for (CALayer *layer in layers) {
        [layer removeFromSuperlayer];
    }
}

// 重新布局layers
- (void)relayoutLayers:(NSArray *)layers convert:(BOOL)convert
{

    if (convert) {
        
        for (CALayer *layer in layers) {
                        NSValue *positionValue = [_layersConvertedPositon objectAtIndex:[layers indexOfObject:layer]];
            layer.position = [positionValue CGPointValue];
            [self.layer addSublayer:layer];
        }
    } else {
        
        for (CALayer *layer in layers) {
            NSValue *positionValue = [_layersOriginPosition objectAtIndex:[layers indexOfObject:layer]];
            layer.position = [positionValue CGPointValue];
            [self.layer addSublayer:layer];
        }
    }
}

- (NSArray *)getPositionValuesWithLayers:(NSArray *)layers convert:(BOOL)convert
{
    NSMutableArray *positions = [[NSMutableArray alloc] initWithCapacity:5];
    
    if (convert) {
        for (CALayer *layer in layers) {
            
            // 由父layer调用, 将子layer的坐标转换到其他layer的坐标系统中, 返回转换后的结果. toLayer参数为空, 表示转换到屏幕坐标中.
            CGPoint newPosition = [self.layer convertPoint:layer.position toLayer:nil];
            [positions addObject:[NSValue valueWithCGPoint:newPosition]];
            
        }
    } else {
        for (CALayer *layer in layers) {
            [positions addObject:[NSValue valueWithCGPoint:layer.position]];
            
        }
    }
    
    return positions;
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

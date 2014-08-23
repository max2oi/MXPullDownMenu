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
    

    UIView *_backGroundView;
    UITableView *_tableView;
    
    NSMutableArray *_titles;
    NSMutableArray *_indicators;
    
    
    NSInteger _currentSelectedIndex;
    bool _show;
    
    NSInteger _numOfMenu;
    
    NSArray *_testArray;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    // 根据菜单的数量计算出每个菜单的位置.
    if (self) {
        
        _testArray = @[ @[ @"我是一ddddd", @"我是二哟", @"去你妈的" ], @[@"嗯嗯嗯", @"fuck!you!"], @[@"lalala", @"xixixixix"] ];
//      _testArray = @[ @[@"我是一", @"我是二哟", @"去你妈的"], @[@"嗯嗯嗯", @"fuck!you!"] ];

        
        
        _numOfMenu = _testArray.count;
        
        CGFloat textLayerInterval = frame.size.width / ( _numOfMenu * 2);
        CGFloat separatorLineInterval = frame.size.width / _numOfMenu;

        _titles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        _indicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        
        for (int i = 0; i < _numOfMenu; i++) {
            
            CGPoint position = CGPointMake( (i * 2 + 1) * textLayerInterval , frame.size.height / 2);
            CATextLayer *title = [self creatTextLayerWithNSString:_testArray[i][0] withColor:[UIColor redColor] andPosition:position];
            [self.layer addSublayer:title];
            [_titles addObject:title];
            
            
            CAShapeLayer *indicator = [self creatIndicatorWithColor:[UIColor orangeColor] andPosition:CGPointMake(position.x + title.bounds.size.width / 2 + 8, frame.size.height / 2)];
            [self.layer addSublayer:indicator];
            [_indicators addObject:indicator];
            
            if (i != _numOfMenu - 1) {
                CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, frame.size.height / 2);
                CAShapeLayer *separator = [self creatSeparatorLineWithColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:243.0/255.0 alpha:1.0] andPosition:separatorPosition];
                [self.layer addSublayer:separator];
            }
            

            
        }
        _tableView = [self creatTableViewAtPosition:CGPointMake(0, self.frame.origin.y + self.frame.size.height)];
        
        

        // 设置menu, 并添加手势
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
        [self addGestureRecognizer:tapGesture];
        
   
        
        // 创建背景
        _backGroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        // 透明
        _backGroundView.opaque = NO;
        // 给背景创建点击事件
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround:)];
        [_backGroundView addGestureRecognizer:gesture];
        
        
        
        _currentSelectedIndex = -1;
        _show = NO;
        
    }
    return self;
}

#pragma mark - tapEvent



// 处理菜单点击事件.
- (void)tapMenu:(UITapGestureRecognizer *)paramSender
{
    CGPoint touchPoint = [paramSender locationInView:self];
    
    // 得到tapIndex
    
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    

    
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                //什么也不做呀
            }];
        }
    }
    
    
    if (tapIndex == _currentSelectedIndex && _show) {
        [self animateIndicator:_indicators[_currentSelectedIndex] Forward:NO complete:^{
            [self animateBackGroundView:_backGroundView show:NO complete:^{
                [self animateTableView:_tableView show:NO complete:^{
                    _show = NO;
                }];
            }];
        }];
    } else {
        [self animateIndicator:_indicators[tapIndex] Forward:YES complete:^{
            [self animateBackGroundView:_backGroundView show:YES complete:^{
                [self animateTableView:_tableView show:YES complete:^{
                    _show = YES;
                }];
            }];
        }];
    }
    _currentSelectedIndex = tapIndex;

 

}

- (void)tapBackGround:(UITapGestureRecognizer *)paramSender
{
    
    [self animateIndicator:_indicators[_currentSelectedIndex] Forward:NO complete:^{
        [self animateBackGroundView:_backGroundView show:NO complete:^{
            [self animateTableView:_tableView show:NO complete:^{
                // 什么也不做
            }];
        }];
    }];

}


#pragma mark - tableView

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//}




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
    
    // 计算string的size
    CGFloat fontSize = 13.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    
    CATextLayer *layer = [CATextLayer new];
    layer.bounds = CGRectMake(0, 0, size.width, size.height);
    layer.string = string;
    layer.fontSize = fontSize;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    
    layer.position = point;
    
    return layer;
}


- (UITableView *)creatTableViewAtPosition:(CGPoint)point
{
    UITableView *tableView = [UITableView new];
    
    tableView.frame = CGRectMake(point.x, point.y, self.frame.size.width, 160);
    tableView.rowHeight = 36;
    
    return tableView;
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

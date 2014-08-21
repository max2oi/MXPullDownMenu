//
//  MXPullDownMenu.m
//  MXPullDownMenu
//
//  Created by 马骁 on 14-8-21.
//  Copyright (c) 2014年 Mx. All rights reserved.
//

#import "MXPullDownMenu.h"

@implementation MXPullDownMenu

- (id)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = (__bridge CGPathRef)([self drawBG]);
    }
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
}

- (UIBezierPath *)drawBG
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
        // 绘图代码
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [[UIColor grayColor] setFill];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(320, 0)];
        [path addLineToPoint:CGPointMake(320, 40)];
        [path addLineToPoint:CGPointMake(0, 40)];
        [path closePath];
        [path fill];
    
    CGContextRestoreGState(ctx);
    return path;
}

@end

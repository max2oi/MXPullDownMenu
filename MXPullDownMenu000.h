//
//  MXPullDownMenu000.h
//  MXPullDownMenu
//
//  Created by 马骁 on 14-8-21.
//  Copyright (c) 2014年 Mx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    IndicatorStateShow = 0,
    IndicatorStateHide
}
IndicatorState;


@interface MXPullDownMenu000 : UIView

@end



// 
@interface CALayer (MXAddAnimationAndValue)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath;

@end

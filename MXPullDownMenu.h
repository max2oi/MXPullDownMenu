//
//  MXPullDownMenu000.h
//  MXPullDownMenu
//
//  Created by 马骁 on 14-8-21.
//  Copyright (c) 2014年 Mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MXPullDownMenu;


typedef enum
{
    IndicatorStateShow = 0,
    IndicatorStateHide
}
IndicatorStatus;

typedef enum
{
    BackGroundViewStatusShow = 0,
    BackGroundViewStatusHide
}
BackGroundViewStatus;

@protocol MXPullDownMenuDelegate <NSObject>

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row;

@end

@interface MXPullDownMenu : UIView<UITableViewDelegate, UITableViewDataSource>

- (MXPullDownMenu *)initWithArray:(NSArray *)array selectedColor:(UIColor *)color;

@property (nonatomic) id<MXPullDownMenuDelegate> delegate;

@end


// CALayerCategory
/*
* for save the animation status
*/
@interface CALayer (MXAddAnimationAndValue)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath;

@end

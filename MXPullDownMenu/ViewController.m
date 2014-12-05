//
//  ViewController.m
//  MXPullDownMenu
//
//  Created by 马骁 on 14-8-21.
//  Copyright (c) 2014年 Mx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"NavigationBar";
    
    
    
    NSArray *testArray;
    testArray = @[ @[ @"这是长字符串的测试数据,所以要足够长", @"通过实现", @"代理来对", @"下拉菜单", @"的点击做" , @"出反馈" , @"就是这样" ], @[@"使用数组", @"进行初始化"], @[@"食物", @"水果", @"面食", @"肉类", @"素食"] ];
    
    
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor greenColor]];
    menu.delegate = self;
    menu.frame = CGRectMake(0, 200, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 实现代理.
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    NSLog(@"%ld -- %ld", (long)column, (long)row);
}

@end

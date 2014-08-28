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
    testArray = @[ @[ @"我是一fadfadsfasdfadsfasdfasdfsadfasdfddd", @"我是二哟", @"去你妈的", @"吃鸡巴把", @"大家好哟" , @"大家好ffff哟" , @"大家ewer好哟" ], @[@"嗯嗯嗯", @"fuck!you!"], @[@"lalala", @"xixixixix"] ];
    //      testArray = @[ @[@"我是一", @"我是二哟", @"去你妈的"], @[@"嗯嗯嗯", @"fuck!you!"] ];
    
//        testArray = @[ @[ @"我是一ddddd", @"我是二哟", @"去你妈的" ], @[@"嗯嗯嗯", @"fuck!you!"], @[@"lalala", @"xixixixix"], @[@"111fdfdf", @"543544534", @"fffefefefef", @"1234567890987654323456"]];
    
    
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

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    NSLog(@"%d -- %d", column, row);
}



#pragma mark - MXPullDownMenuDelegate


@end

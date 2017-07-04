//
//  ViewController.m
//  LeftAndRightHandSide
//
//  Created by PromptNow on 6/9/17.
//  Copyright © 2017 StunStudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<MyMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    v1.backgroundColor = [UIColor redColor];
    [self AddMenu:v1];
    
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    v2.backgroundColor = [UIColor yellowColor];
    [self AddMenu:v2];
    
    [self AddMenuTextOnly:@"EASY MODE"];
    [self AddMenuTextOnly:@"EASY MODE 1111111111111111111111111111111111111"];
    [self AddMenuTextOnly:@"EASY MODE 11111111"];
    
    UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    v3.backgroundColor = [UIColor brownColor];
    [self AddMenu:v3];
    
    [self AddMenuTextOnly:@"EASY MODE 1111111111111111"];
    [self AddMenuTextOnly:@"EASY MODE 11111111"];
    [self RefreshMenu];
    
    
    
    [self setTitle:@"XXXXX"];
    [self setColorBar:[UIColor lightGrayColor]];
    [self setTextTitleColor:[UIColor whiteColor]];
    [self setRightMenuWithText:@"Right" color:[UIColor whiteColor]];
    [self setLeftMenuWithText:@"Left" color:[UIColor whiteColor]];
    UIImage *mm = [UIImage imageNamed:@"Hamburger.png"];
    [self setImgLeftMenu:mm];
    // [self setImgRightMenu:mm];
    [self setLeftMenuColorBG:[UIColor darkGrayColor]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) TouchMenuDidStart:(NSInteger) rowTouch{
    NSInteger m = rowTouch;
    NSLog(@"selected %d row", m);
}

-(void)TouchRightTop{
    NSLog(@"TouchRightTop");
    [self OpenMenuLeft];
}
-(void)TouchLeftTop{
    NSLog(@"TouchLeftTop");
    [self OpenMenuRight];
}

@end

//
//  MyMenu.m
//  kruao
//
//  Created by PromptNow on 6/2/17.
//  Copyright © 2017 StunStudio. All rights reserved.
//

#import "MyLeftMenu.h"

@interface MyLeftMenu ()<UITableViewDataSource,UITableViewDelegate>{
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@end

@implementation MyLeftMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height - AACStatusBarHeight();
    // Do any additional setup after loading the view from its nib.
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, AACStatusBarHeight(), screenWidth, 50)];
    navbar.translucent = YES;
    //do something like background color, title, etc you self
    
    UIBarButtonItem *sendButtonLeft = [[UIBarButtonItem alloc]
                                       initWithTitle:@""
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:nil];
    
    UIBarButtonItem *sendButtonRight = [[UIBarButtonItem alloc]
                                        initWithTitle:@""
                                        style:UIBarButtonItemStylePlain
                                        target:self
                                        action:nil];
    
    
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Title"];
    item.rightBarButtonItem = sendButtonRight;
    item.leftBarButtonItem = sendButtonLeft;
    
    [navbar setItems:[NSArray arrayWithObject:item] animated:YES];
    
    navbar.tag = 1;
    [self.view addSubview:navbar];
    
    
    sizeLx = screenWidth*0.8;
    backShadow = [[UIView alloc] initWithFrame:CGRectMake(0, AACStatusBarHeight(), screenWidth, screenHeight)];
    [backShadow setBackgroundColor:[UIColor blackColor]];
    [backShadow setAlpha:0.2f];
    
    leftmenu = [[UIView alloc] initWithFrame: CGRectMake(-sizeLx, AACStatusBarHeight(), sizeLx, screenHeight)];
    [leftmenu setBackgroundColor:[UIColor blueColor]];
    
    
    Open = NO;
    AnimationNow = NO;
    fate = 0;
    [backShadow setAlpha:fate];
    
    tableMenu = [[UITableView alloc] initWithFrame:leftmenu.bounds style:UITableViewStylePlain];
    
    
    tableMenu.delegate = self;
    tableMenu.dataSource = self;
    
    tableMenu.backgroundColor = [UIColor clearColor];
    [leftmenu addSubview:tableMenu];
    
    menu = [[NSMutableArray alloc] init];
    slide = NO;
    
}

-(void) setSlideMenu:(Boolean) rr{
    slide = rr;
    if(slide){
        leftmenu.frame = CGRectMake(screenWidth, AACStatusBarHeight(), sizeLx, screenHeight);
    }else{
        
        leftmenu.frame = CGRectMake(-sizeLx, AACStatusBarHeight(), sizeLx, screenHeight);
    }
}

-(void) setLeftMenuColorBG:(UIColor *) cc{
    [leftmenu setBackgroundColor:cc];
}

-(void) setLeftMenuWithText:(NSString*) text  color:(UIColor*) cc {
    UINavigationBar *nav = [self.view viewWithTag:1];
    UINavigationItem *item = nav.items[0];
    
    UIBarButtonItem *sendButtonLeft = [[UIBarButtonItem alloc]
                                       initWithTitle:text
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(ButtonLeft)];
    [sendButtonLeft setTintColor:cc];
    [item setLeftBarButtonItem:sendButtonLeft];
}

-(void) setRightMenuWithText:(NSString*) text  color:(UIColor*) cc {
    UINavigationBar *nav = [self.view viewWithTag:1];
    UINavigationItem *item = nav.items[0];
    UIBarButtonItem *sendButtonRight = [[UIBarButtonItem alloc]
                                        initWithTitle:text
                                        style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(ButtonRight)];
    
    [sendButtonRight setTintColor:cc];
    [item setRightBarButtonItem:sendButtonRight];
}

-(void) setImgLeftMenu:(UIImage *) im{
    UINavigationBar *nav = [self.view viewWithTag:1];
    UINavigationItem *item = nav.items[0];
    
    UIButton *imgButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [imgButton setFrame:CGRectMake(5.0, 2.0, 30.0, 30.0)];
    [imgButton addTarget:self action:@selector(ButtonLeft) forControlEvents:UIControlEventTouchUpInside];
    [imgButton setImage:im forState:UIControlStateNormal];
    
    UIBarButtonItem *sendButtonLeft = [[UIBarButtonItem alloc]initWithCustomView:imgButton];
    
    [item setLeftBarButtonItem:sendButtonLeft];
}

-(void) setImgRightMenu:(UIImage *) im{
    UINavigationBar *nav = [self.view viewWithTag:1];
    UINavigationItem *item = nav.items[0];
    
    UIButton *imgButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [imgButton setFrame:CGRectMake(5.0, 2.0, 30.0, 30.0)];
    [imgButton addTarget:self action:@selector(ButtonRight) forControlEvents:UIControlEventTouchUpInside];
    [imgButton setImage:im forState:UIControlStateNormal];
    
    UIBarButtonItem *sendButtonRight = [[UIBarButtonItem alloc]initWithCustomView:imgButton];
    
    [item setRightBarButtonItem:sendButtonRight];
}

-(void) setTitle:(NSString *) title{
    UINavigationBar *nav = [self.view viewWithTag:1];
    UINavigationItem *item = nav.items[0];
    item.title = title;
}

-(void) setTextTitleColor:(UIColor *) cb{
    UINavigationBar *nav = [self.view viewWithTag:1];
    [nav setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:cb, NSForegroundColorAttributeName,
                                 nil]];
}
-(void) setColorBar:(UIColor*) cb{
    UINavigationBar *nav = [self.view viewWithTag:1];
    nav.barTintColor = cb;
}

-(void) addGesClose{
    UITapGestureRecognizer *touchClose =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(touchClose)];
    [backShadow addGestureRecognizer:touchClose];
}

-(void) removeGesClose{
    UITapGestureRecognizer *touchClose =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(touchClose)];
    [backShadow removeGestureRecognizer:touchClose];
}

CGFloat AACStatusBarHeight()
{
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    return MIN(statusBarSize.width, statusBarSize.height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return menu.count;
}

-(void) AddMenu:(UIView*) vv{
    UIView *cellVc = vv;
    [cellVc setFrame:CGRectMake(0, 0, sizeLx, cellVc.frame.size.height)];
    [menu addObject:cellVc];
    
}

-(void) AddMenuTextOnly:(NSString *) ss{
    UIView *cellVc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeLx, 40)];
    UILabel *textLB = [[UILabel alloc]initWithFrame:cellVc.bounds];
    textLB.text = ss;
    textLB.font = [UIFont systemFontOfSize:14];
    textLB.numberOfLines = 1;
    textLB.minimumScaleFactor = 0.2f;
    textLB.textColor = [UIColor whiteColor];
    textLB.textAlignment = NSTextAlignmentCenter;
    
    [cellVc addSubview:textLB];
    [menu addObject:cellVc];
    
}

-(void) RefreshMenu{
    [tableMenu reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *menuSet = [menu objectAtIndex:indexPath.row];
    return menuSet.frame.size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.allowsSelection = YES;
    [tableView setUserInteractionEnabled:YES];
    
    static NSString *CellIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //etc.
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.backgroundColor = [UIColor clearColor];
    UIView *menuSet = [menu objectAtIndex:indexPath.row];
    [cell addSubview:menuSet];
    
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate TouchMenuDidStart:indexPath.row];
}

-(void) startMenu:(BOOL) op {
    Open = op;
    if (!timer) {
        if(Open){
            [self.view addSubview:backShadow];
            [self addGesClose];
            [self.view addSubview:leftmenu];
        }
        AnimationNow = YES;
        speedX = 10;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.02f
                                                 target:self
                                               selector:@selector(Update:)
                                               userInfo:nil
                                                repeats:YES];
    }
}



- (void)Update:(NSTimer *) ss {
    speedX += 2;
    
    if(Open){
        if(slide){
            [leftmenu setFrame:CGRectMake(leftmenu.frame.origin.x - speedX,leftmenu.frame.origin.y,
                                          leftmenu.frame.size.width, leftmenu.frame.size.height)];
            
            if(leftmenu.frame.origin.x <= screenWidth - sizeLx){
                [leftmenu setFrame:CGRectMake(screenWidth - sizeLx, leftmenu.frame.origin.y,
                                              leftmenu.frame.size.width, leftmenu.frame.size.height)];
                [self stopTimer];
            }
        }else{
            [leftmenu setFrame:CGRectMake(leftmenu.frame.origin.x + speedX,leftmenu.frame.origin.y,
                                          leftmenu.frame.size.width, leftmenu.frame.size.height)];
            
            if(leftmenu.frame.origin.x >= 0){
                [leftmenu setFrame:CGRectMake(0, leftmenu.frame.origin.y,leftmenu.frame.size.width, leftmenu.frame.size.height)];
                [self stopTimer];
            }
        }
        
        
        fate += 0.05f;
        if(fate>0.4){
            fate = 0.4;
        }
        
        [backShadow setAlpha:fate];
    }else{
        
        
        if(slide){
            [leftmenu setFrame:CGRectMake(leftmenu.frame.origin.x + speedX,leftmenu.frame.origin.y,
                                          leftmenu.frame.size.width,leftmenu.frame.size.height)];
            
            
            if(leftmenu.frame.origin.x > screenWidth){
                [leftmenu setFrame:CGRectMake(screenWidth, leftmenu.frame.origin.y,
                                              leftmenu.frame.size.width, leftmenu.frame.size.height)];
                [self stopTimer];
                [backShadow removeFromSuperview];
                [self removeGesClose];
                [leftmenu removeFromSuperview];
            }
        }else{
            [leftmenu setFrame:CGRectMake(leftmenu.frame.origin.x - speedX,leftmenu.frame.origin.y,
                                          leftmenu.frame.size.width,leftmenu.frame.size.height)];
            
            
            if(leftmenu.frame.origin.x < (sizeLx * -1)){
                [leftmenu setFrame:CGRectMake(-sizeLx, leftmenu.frame.origin.y,
                                              leftmenu.frame.size.width, leftmenu.frame.size.height)];
                [self stopTimer];
                [backShadow removeFromSuperview];
                [self removeGesClose];
                [leftmenu removeFromSuperview];
            }
        }
        
        fate -= 0.1f;
        if(fate<0){
            fate = 0;
        }
        [backShadow setAlpha:fate];
        
    }
    
}
- (void)stopTimer {
    if ([timer isValid]) {
        [timer invalidate];
    }
    timer = nil;
    AnimationNow = NO;
}

-(void) touchClose {
    if(!AnimationNow){
        [self startMenu:NO];
    }
}

-(void) ButtonLeft {
    if(slide == NO){
        if(!AnimationNow){
            if(Open){
                [self startMenu:NO];
            }else{
                [self startMenu:YES];
            }
            
        }
    }else{
        [_delegate TouchLeftTop];
    }
    
}
-(void) ButtonRight {
    
    if(slide){
        if(!AnimationNow){
            if(Open){
                [self startMenu:NO];
            }else{
                [self startMenu:YES];
            }
            
        }
    }else{
        [_delegate TouchRightTop];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

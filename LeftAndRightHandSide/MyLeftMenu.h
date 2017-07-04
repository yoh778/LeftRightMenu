//
//  MyMenu.h
//  kruao
//
//  Created by PromptNow on 6/2/17.
//  Copyright © 2017 StunStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyLeftMenu;
@protocol MyMenuDelegate <NSObject>
- (void) TouchMenuDidStart:(NSInteger) rowTouch;
- (void) TouchRightTop;
- (void) TouchLeftTop;

@end

@interface MyLeftMenu : UIViewController{
    BOOL Open;
    BOOL AnimationNow;
    UIView *leftmenu;
    UIView *backShadow;
    NSTimer *timer;
    int sizeLx;
    int speedX;
    float fate;
    UITableView *tableMenu;
    
    NSMutableArray *menu;
    
    BOOL slideFormRL;
}

@property (nonatomic, weak) NSObject <MyMenuDelegate> *delegate;


-(void) AddMenu:(UIView*) vv;
-(void) AddMenuTextOnly:(NSString *) ss;
-(void) RefreshMenu;

-(void) setLeftMenuColorBG:(UIColor *) cc;
-(void) setLeftMenuWithText:(NSString*) text  color:(UIColor*) cc;
-(void) setRightMenuWithText:(NSString*) text  color:(UIColor*) cc;
-(void) setImgLeftMenu:(UIImage *) im;
-(void) setImgRightMenu:(UIImage *) im;
-(void) setTitle:(NSString *) title;
-(void) setTextTitleColor:(UIColor *) cb;
-(void) setColorBar:(UIColor*) cb;
-(void) OpenMenuRight;
-(void) OpenMenuLeft;

@end

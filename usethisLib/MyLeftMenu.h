#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MyLeftMenu;
@protocol MyMenuDelegate <NSObject>
- (void) TouchMenuDidStart:(NSInteger) rowTouch;
- (void) TouchRightTop;
- (void) TouchLeftTop;
@end

@interface MyLeftMenu : UIViewController {
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
    
    BOOL slide;
}
    
@property (nonatomic, strong) NSObject <MyMenuDelegate> *delegate;
    
-(void) setSlideMenu:(Boolean) rr;
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
    @end

# LeftAndRightHandSide

## How to Create Menu 
* Begin Create
```
    1.go to you ViewControler.h
    2.#import "MyLeftMenu.h"
    3.Change UIViewControler to MyLeftMenu
      ex. @interface ViewController : MyLeftMenu
```

* Set Menu
```
    1.go to you ViewController.m 
    2.add self.delegate = self; in (void)viewDidLoad 
    3.add menu with text or uiview
        ex. UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
            v1.backgroundColor = [UIColor redColor];
            [self AddMenu:v1];
      or text menu
        ex. [self AddMenuTextOnly:@"MenuText"];
    4.set title on centertop 
        ex. [self setTitle:@"Title"];
    5.set title color [self setTextTitleColor:[UIColor whiteColor]];
    6.set Left Menu BackgroundColor [self setLeftMenuColorBG:[UIColor darkGrayColor]];
    7.call this when set all menu finish ex. [self RefreshMenu];
   
```
* Set Menu Delegate
```
    1.go to you ViewController.m 
    2.Set Delegate -> @interface ViewController ()<MyMenuDelegate>
    3.And Add Func
        Touch index menu
        - (void) TouchMenuDidStart:(NSInteger) rowTouch

        Touch right menu
        -(void)TouchRightTop

        Touch left menu
        -(void)TouchLeftTop

        Call Menu form Right
        -(void) OpenMenuRight;

        Call Menu form Left
        -(void) OpenMenuLeft;

            ex. if you wnat call Left menu form left
                -(void)TouchLeftTop{
                    NSLog(@"TouchLeftTop");
                    [self OpenMenuRight];
                }

```

## LEFT HAND SIDE
* Add Left Menu
```
    1.Add Left top with image or text
        ex text->   [self setLeftMenuWithText:@"Left" color:[UIColor whiteColor]];
        ex image->  UIImage *img = [UIImage imageNamed:@"Hamburger.png"]; 
                    [self setImgLeftMenu:img];
```
<p align="center">
<img src="http://i.imgur.com/5c5vrs1.png"/>
</p>


## RIGHT HAND SIDE
* Add Right Menu
```
    1.Add Right top with image or text
    ex text->   [self setRightMenuWithText:@"Right" color:[UIColor whiteColor]];
    ex image->  UIImage *img = [UIImage imageNamed:@"Hamburger.png"]; 
                [self setImgRightMenu:img];
```
<p align="center">
<img src="http://i.imgur.com/Ovis3Zh.png"/>
</p>


## Requirements
IOS 8.0 Above

## License
LeftAndRightHandSide is provided under the Stunstudio license.

# My App
# https://stunstudio.co
# https://www.facebook.com/stunstudio/

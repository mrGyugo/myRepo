//
//  ViewController.h
//  AnimationHome
//
//  Created by Виктор Мишустин on 01.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ViewControllerParamsBoxViewUpLeft =     1,
    ViewControllerParamsBoxViewUpWrite =    2,
    ViewControllerParamsBoxViewDownWrite =  3,
    ViewControllerParamsBoxViewDownLeft =   4
    
}ViewControllerParamsBoxView;

@interface ViewController : UIViewController

@property (assign, nonatomic) ViewControllerParamsBoxView * params;


@end


//
//  NotificationController.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "NotificationController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "NotificationView.h"
#import "ArrayModelNotification.h"
#import "SWRevealViewController.h"

@implementation NotificationController

- (void) viewDidLoad
{
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"УВЕДОМЛЕНИЯ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcon.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 32, 24);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    //    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
#pragma mark - Initialization
    
    //основной вью контент---------------------------------------
    NotificationView * viewContent = [[NotificationView alloc] initWithView:self.view andArray:[ArrayModelNotification setArrayNotification]];
    [self.view addSubview:viewContent];
    

    
}

@end

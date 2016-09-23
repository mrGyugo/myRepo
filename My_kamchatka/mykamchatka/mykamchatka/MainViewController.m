//
//  MainViewController.m
//  mykamchatka
//
//  Created by Viktor on 14.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "TitleClass.h"
#import "MainView.h"


@implementation MainViewController

- (void) viewDidLoad
{
    
#pragma mark - Title
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"МОЯ ЛЮБИМАЯ КАМЧАТКА"];
    self.navigationItem.titleView = title;
    
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"7aafcf"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcons.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, 20, 20);
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar

#pragma mark - Initialization
    
    //Отображение View-----------------------------------------
    MainView * mainView = [[MainView alloc] initWithView:self.view];
    [self.view addSubview:mainView];
    
    

}



@end

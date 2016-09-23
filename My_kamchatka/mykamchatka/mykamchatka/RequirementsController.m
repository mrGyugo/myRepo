//
//  RequirementsController.m
//  mykamchatka
//
//  Created by Viktor on 16.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "RequirementsController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "RequirementsView.h"


@implementation RequirementsController

- (void) viewDidLoad {
    
#pragma mark - Title
    
    
    //Заголовок-----------------------------------------------
    
    TitleClass * title = [[TitleClass alloc]initWithLiteTitle:@"ТРЕБОВАНИЯ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"b3ddf4"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcons.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 20, 20);
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar
    
#pragma mark - Initialization
    
    //Основное вью-----------------------------------------------
    RequirementsView * requirementsView = [[RequirementsView alloc] initWithView:self.view];
    [self.view addSubview:requirementsView];
    
}

@end

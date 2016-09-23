//
//  RulesController.m
//  mykamchatka
//
//  Created by Viktor on 15.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "RulesController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "RulesView.h"
#import "ModelRuler.h"

@implementation RulesController

- (void) viewDidLoad {

#pragma mark - Title


    //Заголовок-----------------------------------------------

    TitleClass * title = [[TitleClass alloc]initWithLiteTitle:@"ПРАВИЛА"];
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
    
    //Данные---------------------------------------------------
    ModelRuler * modelRules = [[ModelRuler alloc] init];
    NSArray * arrayName = [modelRules addArrayName];
    NSArray * arrayData = [modelRules addArrayData];
    
    //Основное вью---------------------------------------------
    RulesView * rulesView = [[RulesView alloc] initWithView:self.view andArrayName:arrayName andArrayData:arrayData];
    [self.view addSubview: rulesView];
    
    
}

@end

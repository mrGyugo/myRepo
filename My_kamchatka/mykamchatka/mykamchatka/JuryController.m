//
//  JuryController.m
//  mykamchatka
//
//  Created by Viktor on 18.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "JuryController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "JuryView.h"
#import "JuryModel.h"

@implementation JuryController

#pragma mark - Title

- (void) viewDidLoad {
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithLiteTitle:@"ЖЮРИ"];
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
    
    //Прогружаем данные------------------------------------------
    JuryModel * juryModel = [[JuryModel alloc] init];
    
    //Создание оснвного вью--------------------------------------
    JuryView * juryView = [[JuryView alloc] initWithView:self.view ansArrayJuri:[juryModel setArrayJuri]];
    [self.view addSubview:juryView];
    
}

@end

//
//  SettingsController.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 19/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SettingsController.h"
#import "UIColor+HexColor.h"
#import "TitleClass.h"
#import "ButtonMenu.h"
#import "BackgroundFone.h"
#import "SettingsView.h"
#import "BasketController.h"

@implementation SettingsController

- (void) viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"НАСТРОЙКИ"];
    self.navigationItem.titleView = title;
    
    //Кнопка корзины---------------------------------------------
    UIButton * buttonBasket = [ButtonMenu createButtonBasket];
    [buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:buttonBasket];
    self.navigationItem.rightBarButtonItem = mailbutton;
    
#pragma mark - Initialization
    
    BackgroundFone * fone = [[BackgroundFone alloc] initWithView:self.view andImage:@"backgroudMainImage.png"];
    [self.view addSubview:fone];
    
    SettingsView * mainView = [[SettingsView alloc] initWithView:self.view];
    [self.view addSubview:mainView];
    
    
}


#pragma mark - Buttons Action

- (void) buttonBasketAction
{
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}


@end

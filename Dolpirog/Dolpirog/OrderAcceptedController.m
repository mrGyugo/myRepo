//
//  OrderAcceptedController.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 21/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OrderAcceptedController.h"
#import "UIColor+HexColor.h"
#import "TitleClass.h"
#import "ButtonMenu.h"
#import "BackgroundFone.h"
#import "TitleClass.h"
#import "CatalogController.h"

@implementation OrderAcceptedController

- (void) viewDidLoad
{
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"РАДИО"];
    self.navigationItem.titleView = title;
    
#pragma mark - Initializayion
    
    BackgroundFone * fone = [[BackgroundFone alloc] initWithView:self.view andImage:@"backGroundOrder.png"];
    [self.view addSubview:fone];
    
}


#pragma mark - Buttons Action

- (void) buttonBasketAction
{
    NSLog(@"Корзина");
}


@end

//
//  CatalogDetailController.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 18/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogDetailController.h"
#import "ButtonMenu.h"
#import "BackgroundFone.h"
#import "TitleClass.h"
#import "CatalogDetailView.h"
#import "Macros.h"
#import "OrderController.h"
#import "BasketController.h"

@implementation CatalogDetailController

- (void) viewDidLoad {
#pragma mark - Header
    
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ОСЕТИНСКИЕ ПИРОГИ"];
    self.navigationItem.titleView = title;
    
    //Кнопка корзины---------------------------------------------
    UIButton * buttonBasket = [ButtonMenu createButtonBasket];
    [buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:buttonBasket];
    self.navigationItem.rightBarButtonItem = mailbutton;
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [ButtonMenu createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - Initialization
    BackgroundFone * fone = [[BackgroundFone alloc] initWithView:self.view andImage:@"backgroudMainImage.png"];
    [self.view addSubview:fone];
    
    CatalogDetailView * mainView = [[CatalogDetailView alloc] initWithView:self.view];
    [self.view addSubview:mainView];
    
    //Нотификации---------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushOrderController)
                                                 name:NOTIFICATION_SCROLL_VIEW_IMAGE_PUSH_ORDER_CONTROLLER object:nil];
    
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods

- (void) buttonBasketAction
{
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)buttonBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) pushOrderController
{
    OrderController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end

//
//  CatalogController.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 05/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogController.h"
#import "UIColor+HexColor.h"
#import "TitleClass.h"
#import "ButtonMenu.h"
#import "LoginView.h"
#import "Macros.h"
#import "BackgroundFone.h"
#import "CatalogView.h"
#import "CatalogModel.h"
#import "CatalogDetailController.h"
#import "BasketController.h"

@implementation CatalogController



- (void) viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"КАТАЛОГ"];
    self.navigationItem.titleView = title;
    
    //Нотификации-------------------------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToCatalogDetailController) name:NOTIFIVATION_CATALOG_VIEW_PUSH_CATALOG_DETAIL_CONTROLLER object:nil];
    
    //Кнопка корзины---------------------------------------------
    UIButton * buttonBasket = [ButtonMenu createButtonBasket];
    [buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:buttonBasket];
    self.navigationItem.rightBarButtonItem = mailbutton;
    
#pragma mark - Initialization
    
    BackgroundFone * fone = [[BackgroundFone alloc] initWithView:self.view andImage:@"backgroudMainImage.png"];
    [self.view addSubview:fone];
    
    CatalogView * mainView = [[CatalogView alloc] initWithView:self.view andDate:[CatalogModel arrayData]];
    [self.view addSubview:mainView];    
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Buttons Action

- (void) buttonBasketAction
{
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) pushToCatalogDetailController
{
    CatalogDetailController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogDetailController"];
    [self.navigationController pushViewController:detail animated:YES];
}




@end

//
//  OrderController.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 18/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OrderController.h"
#import "ButtonMenu.h"
#import "BackgroundFone.h"
#import "TitleClass.h"
#import "SingleTone.h"
#import "OrderView.h"
#import "BasketController.h"

@implementation OrderController

- (void) viewDidLoad {
#pragma mark - Header 
    NSDictionary * mainDict = [[SingleTone sharedManager] dictOrder];
    NSString * stringTitle = [[mainDict objectForKey:@"name"] uppercaseString];
    
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:stringTitle];
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
    BackgroundFone * fone = [[BackgroundFone alloc] initWithView:self.view andImage:@"imageBackRoundTwo.png"];
    [self.view addSubview:fone];
    
    OrderView * mainView = [[OrderView alloc] initWithView:self.view andDate:nil];
    [self.view addSubview:mainView];
    
}




- (void) buttonBasketAction
{
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)buttonBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

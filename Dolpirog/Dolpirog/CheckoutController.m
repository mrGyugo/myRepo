//
//  CheckoutController.m
//  FlowersOnline
//
//  Created by Viktor on 20.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CheckoutController.h"
#import "UIColor+HexColor.h"
#import "ButtonMenu.h"
#import "TitleClass.h"
#import "CheckoutView.h"
#import "SingleTone.h"
#import "BackgroundFone.h"
#import "OrderAcceptedController.h"

@implementation CheckoutController

- (void) viewDidLoad
{
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ОФОРМЛЕНИЕ"];
    self.navigationItem.titleView = title;
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [ButtonMenu createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushOrderAccepted) name:NOTIFICATION_CHECKOUT_VIEW_PUSH_ORDER_ACCEPTED_CONTROLLER object:nil];
    
#pragma mark - Initializayion
    
    BackgroundFone * fone = [[BackgroundFone alloc] initWithView:self.view andImage:@"imageBackRoundTwo.png"];
    [self.view addSubview:fone];
    
    CheckoutView * mainView = [[CheckoutView alloc] initWithView:self.view];
    [self.view addSubview:mainView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [[SingleTone sharedManager] viewBasketBar].alpha = 0;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[SingleTone sharedManager] viewBasketBar]. alpha = 1;
}

- (void)buttonBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) pushOrderAccepted
{
    OrderAcceptedController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderAcceptedController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

//
//  RatesController.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "RatesController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "RatesView.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "YandexSalesController.h"
#import "AgreementController.h"

@implementation RatesController
{
    NSDictionary * dictResponse;
}

- (void) viewDidLoad
{
#pragma mark - Header
    
    self.view.userInteractionEnabled = YES;
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ТАРИФЫ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initialization
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushYandex) name:@"PushYandexNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushAgreement) name:@"PushActionWithAgreementController" object:nil];

    [self getAPIWithBlock:^{
        if ([[dictResponse objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray * mainArray = [NSArray arrayWithArray:[dictResponse objectForKey:@"data"]];
            //Основной контент вью----------------------------------------
            RatesView * viewContent = [[RatesView alloc] initWithView:self.view andArray:mainArray];
            [self.view addSubview:viewContent];
        } else {
            NSLog(@"Не массив");
        }
    }];
    
   
    
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] tariffID], @"id_category", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"list_category_tariff" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            
            block();
        }
    }];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) pushYandex
{
    
    YandexSalesController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"YandexSalesController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) pushAgreement
{
    AgreementController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"AgreementController"];
    [self.navigationController pushViewController:detail animated:YES];
}



@end

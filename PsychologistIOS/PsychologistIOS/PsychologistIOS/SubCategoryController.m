//
//  SubCategoryController.m
//  PsychologistIOS
//
//  Created by Viktor on 04.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SubCategoryController.h"
#import "SWRevealViewController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "SingleTone.h"
#import "SubCategoryView.h"
#import "Macros.h"
#import "SubjectViewController.h"
#import "APIGetClass.h"
#import "ViewNotification.h"
#import "NotificationController.h"
#import "AlertClass.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "BookmarksController.h"

@implementation SubCategoryController
{
    NSDictionary * dictResponse;
    UIButton * buttonBookmark;
    NSDictionary * dictRates;
}

- (void) viewDidLoad
{
#pragma mark - Header
    
    //Заголовок-----------------------------------------------    
    TitleClass * title = [[TitleClass alloc]initWithTitle:[[[SingleTone sharedManager] titleCategory] uppercaseString]];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
        
#pragma mark - Initilization
    
    [self getAPIWithBlock:^{
        
        if ([[dictResponse objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray * arrayMainResponce = [NSArray arrayWithArray:[dictResponse objectForKey:@"data"]];
            SubCategoryView * contentView = [[SubCategoryView alloc] initWithContent:self.view andArray:arrayMainResponce];
            [self.view addSubview:contentView];
        } else {
            NSLog(@"Не массив");
        }
        
        NSString * stringText = @"У вас 5 новых уведомлений в разделе";
        NSString * stringTitle = @"\"Женские секреты\"";
        
        ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
        [self.view addSubview:viewNotification];
        
        buttonBookmark = (UIButton*)[self.view viewWithTag:246];
        [buttonBookmark addTarget:self action:@selector(addBuukmark) forControlEvents:UIControlEventTouchUpInside];

        
    }];
    
    SubCategoryView * backgroundView = [[SubCategoryView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithSubject) name:NOTIFICATION_SUB_CATEGORY_PUSH_TU_SUBCATEGORY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chetBookMarkSub:) name:@"notificationChekBookMarkSubcategory" object:nil];

}

- (void) notificationPushWithSubject
{
    SubjectViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"show_tree", [[SingleTone sharedManager] identifierCategory], @"id_parent",  nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"show_category" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}

- (void) getAPIWithParamsWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             [[SingleTone sharedManager] identifierSubCategory], @"id_category",
                             [[SingleTone sharedManager] userID], @"id_user",nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"check_subscribe" complitionBlock:^(id response) {
        
        dictRates = (NSDictionary*) response;
        
        //Провека закладок------------
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] identifierSubCategory], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"category", @"type", nil];
        APIGetClass * apiGallery = [APIGetClass new];
        [apiGallery getDataFromServerWithParams:params method:@"check_fav" complitionBlock:^(id response) {
            dictResponse = (NSDictionary*) response;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"animationSubCatregoryAlertView" object:nil];
            if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
                NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
                //ТУТ UILabel когда нет фоток там API выдает
            } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
                NSLog(@"response %@", response);
                if ([[response objectForKey:@"favorite_count"] integerValue] == 0) {
                    [buttonBookmark setTitle:@"ДОБАВИТЬ В ЗАКЛАДКИ" forState:UIControlStateNormal];
                } else if ([[response objectForKey:@"favorite_count"] integerValue] == 1) {
                    [buttonBookmark setTitle:@"УЖЕ В ЗАКЛАДКАХ" forState:UIControlStateNormal];
                }
            }
        }];

        if ([[dictRates objectForKey:@"error"] integerValue] == 1) {
                        NSLog(@"ошибка ! %@", [dictRates objectForKey:@"error_msg"]);
        } else if ([[dictRates objectForKey:@"error"] integerValue] == 0) {            
            NSLog(@"dictRates\\\\|||||//////   %@", dictRates);
        }
        block();
    }];
}

- (void) chetBookMarkSub: (NSNotification*) notification
{
    if ([notification.object boolValue]) {
        //Проверка подписки-----------
        [self getAPIWithParamsWithBlock:^{
            UIButton * buttonBuy = [self.view viewWithTag:1265];
            UIButton * openButton = [self.view viewWithTag:382];
            if ([dictRates objectForKey:@"data"] != [NSNull null]) {
                buttonBuy.alpha = 0.f;
            } else {
                openButton.alpha = 0.f;
                NSLog(@"Не оплеченный саб");
            }
        }];
    } else {
        
        //Провека закладок------------
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] identifierSubCategory], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"category", @"type", nil];
        APIGetClass * apiGallery = [APIGetClass new];
        [apiGallery getDataFromServerWithParams:params method:@"check_fav" complitionBlock:^(id response) {
            dictResponse = (NSDictionary*) response;
            if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
                NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
                //ТУТ UILabel когда нет фоток там API выдает
            } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
                NSLog(@"response %@", response);
                if ([[response objectForKey:@"favorite_count"] integerValue] == 0) {
                    [buttonBookmark setTitle:@"ДОБАВИТЬ В ЗАКЛАДКИ" forState:UIControlStateNormal];
                } else if ([[response objectForKey:@"favorite_count"] integerValue] == 1) {
                    [buttonBookmark setTitle:@"УЖЕ В ЗАКЛАДКАХ" forState:UIControlStateNormal];
                }
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"animationSubCatregoryAlertView" object:nil];
            
        }];
        
    }
    
}

- (void) addBuukmark
{
    if ([[buttonBookmark titleForState:UIControlStateNormal] isEqualToString:@"ДОБАВИТЬ В ЗАКЛАДКИ"]) {
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] identifierSubCategory], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"subcategory", @"type", nil];
        
        APIGetClass * apiGallery = [APIGetClass new];
        [apiGallery getDataFromServerWithParams:params method:@"add_fav" complitionBlock:^(id response) {
            
            dictResponse = (NSDictionary*) response;
            
            if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
                NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
                //ТУТ UILabel когда нет фоток там API выдает
            } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
//                NSLog(@"response %@", response);
                [UIView animateWithDuration:0.3 animations:^{
                    [buttonBookmark setTitle:@"УЖЕ В ЗАКЛАДКАХ" forState:UIControlStateNormal];
                }];
            }
        }];
    } else if ([[buttonBookmark titleForState:UIControlStateNormal] isEqualToString:@"УЖЕ В ЗАКЛАДКАХ"]) {
        BookmarksController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BookmarksController"];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}


- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end

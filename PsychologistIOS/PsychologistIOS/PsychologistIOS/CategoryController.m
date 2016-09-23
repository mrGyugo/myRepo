//
//  CategoryController.m
//  PsychologistIOS
//
//  Created by Viktor on 31.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "CategoryController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "CategoryView.h"
#import "TitleClass.h"
#import "Macros.h"
#import "SubCategoryController.h"
#import "RatesController.h"
#import "APIGetClass.h"
#import "Macros.h"
#import "ViewNotification.h"
#import "NotificationController.h"
#import "SingleTone.h"
#import "AlertClass.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "BookmarksController.h"

@implementation CategoryController
{
    NSDictionary * dictResponse;
    UIButton * buttonBookmark;
    NSDictionary * dictRates;
}



- (void) viewDidLoad {
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"РАЗДЕЛ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcon.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 32, 24);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
#pragma mark - Initilization
    
    self.view.userInteractionEnabled = YES;
    
    NSString * stringName;
    NSLog(@"USERNAME %@",[[SingleTone sharedManager] userName]);
    NSLog(@"id %@", [[SingleTone sharedManager] userID]);
    if ([[[SingleTone sharedManager] userName] isEqual: [NSNull null]]) {
        stringName = [NSString stringWithFormat:@"гость %@", [[SingleTone sharedManager] userID]];
    } else {
        stringName = [[SingleTone sharedManager] userName];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CHECK_NAME_LABEL object:stringName];
    
    [self getAPIWithBlock:^{
        
        NSMutableArray * mainArrayAPI = [NSMutableArray arrayWithArray:[dictResponse objectForKey:@"data"]];
        CategoryView * contentView = [[CategoryView alloc] initWithContent:self.view andArray:mainArrayAPI];
        [self.view addSubview:contentView];
        
        NSString * stringText = @"У вас 5 новых уведомлений в разделе";
        NSString * stringTitle = @"\"Женские секреты\"";
        
        ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
        [self.view addSubview:viewNotification];
        
        
        buttonBookmark = (UIButton*)[self.view viewWithTag:246];
        [buttonBookmark addTarget:self action:@selector(addBuukmark) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    
    CategoryView * backgroundView = [[CategoryView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithSubCategory) name:NOTIFICATION_CATEGORY_PUSH_TU_SUBCATEGORY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithRates) name:NOTIFICATION_PUSH_BUY_CATEGORY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chetBookMark:) name:@"notificationChekBookMark" object:nil];
    
}


- (void) pushViewController
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods

- (void) notificationPushWithSubCategory
{
    SubCategoryController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SubCategoryController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) notificationPushWithRates
{
    RatesController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RatesController"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"show_tree", nil];
    
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
                             [[SingleTone sharedManager] identifierCategory], @"id_category",
                             [[SingleTone sharedManager] userID], @"id_user",nil];
    
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"check_subscribe" complitionBlock:^(id response) {
        
        dictRates = (NSDictionary*) response;
                //Провека закладок------------
                NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] identifierCategory], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"category", @"type", nil];
                APIGetClass * apiGallery = [APIGetClass new];
                [apiGallery getDataFromServerWithParams:params method:@"check_fav" complitionBlock:^(id response) {
                    dictResponse = (NSDictionary*) response;
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"animationAlertView" object:nil];
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
//            NSLog(@"ошибка ! %@", [dictRates objectForKey:@"error_msg"]);
        } else if ([[dictRates objectForKey:@"error"] integerValue] == 0) {
            
            NSLog(@"dictRates\\\\|||||//////   %@", dictRates);
            block();
            
        }
    }];
}

- (void) chetBookMark: (NSNotification*) notification
{
    if ([notification.object boolValue]) {
        //Проверка подписки-----------
        [self getAPIWithParamsWithBlock:^{
            UIButton * buttonBuy = [self.view viewWithTag:1875];
            if ([dictRates objectForKey:@"data"] != [NSNull null]) {
                buttonBuy.alpha = 0.f;
            }
        }];
    } else {
        
        //Провека закладок------------
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] identifierCategory], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"category", @"type", nil];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"animationAlertView" object:nil];
            
        }];

    }

    
}

- (void) addBuukmark
{
    if ([[buttonBookmark titleForState:UIControlStateNormal] isEqualToString:@"ДОБАВИТЬ В ЗАКЛАДКИ"]) {
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] identifierCategory], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"category", @"type", nil];
        
        APIGetClass * apiGallery = [APIGetClass new];
        [apiGallery getDataFromServerWithParams:params method:@"add_fav" complitionBlock:^(id response) {
            
            dictResponse = (NSDictionary*) response;
            
            if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
                NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
                //ТУТ UILabel когда нет фоток там API выдает
            } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
                NSLog(@"response %@", response);
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

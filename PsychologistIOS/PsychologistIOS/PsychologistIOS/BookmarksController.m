//
//  BookmarksController.m
//  PsychologistIOS
//
//  Created by Viktor on 12.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "BookmarksController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "BookmarksView.h"
#import "BoolmarksModel.h"
#import "OpenSubjectController.h"
#import "MeditationController.h"
#import "ViewNotification.h"
#import "NotificationController.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "SubCategoryController.h"
#import "SubjectViewController.h"
#import "OpenSubjectController.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "RatesController.h"



@implementation BookmarksController
{
    NSDictionary * dictResponse;
    NSDictionary * dictRates;
    NSDictionary * dictSubInfo;
}

- (void) viewDidLoad {
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ЗАКЛАДКИ"];
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
    
    BookmarksView * backgroundView = [[BookmarksView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    [self getAPIWithBlock:^{
        if ([[dictResponse objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray * mainArray = [NSArray arrayWithArray:[dictResponse objectForKey:@"data"]];
            BookmarksView * viewContent = [[BookmarksView alloc] initWithContent:self.view andArray:mainArray];
            [self.view addSubview:viewContent];
        }
    }];
    NSString * stringText = @"У вас 5 новых уведомлений в разделе";
    NSString * stringTitle = @"\"Женские секреты\"";
    
    ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
    CGRect myRect = viewNotification.frame;
    myRect.origin.y -= 64;
    viewNotification.frame = myRect;
    [self.view addSubview:viewNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushBookMerkWithCategory:) name:NOTIFICATION_PUSH_BOOKMARK_CATEGORY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushBookMerkWithSubCategory:) name:NOTIFICATION_PUSH_BOOKMARK_SUB_CATEGORY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushBookMerkWithSubject:) name:NOTIFICATION_PUSH_BOOKMARK_SUBJECT object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCell:) name:NOTIFICATION_DELET_CELL_BOOKMARK object:nil];

}

#pragma mark - API

- (void) deleteCell: (NSNotification*) notification
{
    NSLog(@"notification %@", notification.userInfo);
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[notification.userInfo objectForKey:@"id"], @"id", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"del_fav" complitionBlock:^(id response) {
        if ([[response objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [response objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[response objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"response %@", response);
            NSLog(@"ячейка удалена");
        }
    }];
}

- (void) pushBookMerkWithCategory: (NSNotification*) notification
{
    SubCategoryController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SubCategoryController"];
    [self.navigationController pushViewController:detail animated:YES];
}


//Переход и категорий-------------------------------


- (void) getAPIWithParamsID: (NSString*) subCategory
andWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             subCategory, @"id_category",
                             [[SingleTone sharedManager] userID], @"id_user",nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"check_subscribe" complitionBlock:^(id response) {
        
        dictRates = (NSDictionary*) response;
        
        
        if ([[dictRates objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"ошибка ! %@", [dictRates objectForKey:@"error_msg"]);
        } else if ([[dictRates objectForKey:@"error"] integerValue] == 0) {
            
        }
        block();
    }];
}

- (void) pushBookMerkWithSubCategory: (NSNotification*) notification
{
    
    dictSubInfo = notification.userInfo;
    if ([[dictSubInfo objectForKey:@"paid"] boolValue]) {
        [self getAPIWithParamsID:[dictSubInfo objectForKey:@"id"] andWithBlock:^{
            if ([dictRates objectForKey:@"data"] != [NSNull null]) {
                SubjectViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectViewController"];
                [self.navigationController pushViewController:detail animated:YES];
            } else {
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                alert.customViewColor = [UIColor colorWithHexString:@"d46559"];
                [alert addButton:@"Оплатить" target:self selector:@selector(pushRates)];
                [alert showSuccess:self title:@"Внимание" subTitle:@"Данная категория не оплачена" closeButtonTitle:@"Отмена" duration:0.0f];
            }
        }];
    } else {
            SubjectViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectViewController"];
            [self.navigationController pushViewController:detail animated:YES];
    }
    

}

- (void) pushRates
{
    [[SingleTone sharedManager] setTariffID:[dictSubInfo objectForKey:@"id"]];
    [[SingleTone sharedManager] setRules:[dictSubInfo objectForKey:@"rules"]];
    RatesController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RatesController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) pushBookMerkWithSubject: (NSNotification*) notification
{
    OpenSubjectController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenSubjectController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] userID], @"id_user", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"show_fav" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}

#pragma mark - DEALLOC
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods

- (void) notificationAction: (NSNotification*) notification
{
    if ([notification.object isEqualToString:@"Медитации"]) {
        MeditationController * detail = [self.storyboard
                                         instantiateViewControllerWithIdentifier:@"MeditationController"];
        [self.navigationController pushViewController:detail animated:YES];
        
    } else {
    
    OpenSubjectController * detail = [self.storyboard
                                      instantiateViewControllerWithIdentifier:@"OpenSubjectController"];
    [self.navigationController pushViewController:detail animated:YES];
        
    }
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}


@end

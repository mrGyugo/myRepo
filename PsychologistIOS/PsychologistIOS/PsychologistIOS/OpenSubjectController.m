//
//  OpenSubjectController.m
//  PsychologistIOS
//
//  Created by Viktor on 05.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "OpenSubjectController.h"
#import "SWRevealViewController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SingleTone.h"
#import "OpenSubjectView.h"
#import "DiscussionsController.h"
#import "APIGetClass.h"
#import "ViewNotification.h"
#import "NotificationController.h"

@implementation OpenSubjectController
{
    NSDictionary * dictResponse;
    NSDictionary * dictResponseMessage;
}

- (void) viewDidLoad
{
#pragma mark - Header
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:[[[SingleTone sharedManager] titleSubject] uppercaseString]];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initialization
    
    [self getAPIWithBlock:^{
        
        if ([[dictResponse objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary * mainDict = [dictResponse objectForKey:@"data"];
            [[SingleTone sharedManager] setPostID:[mainDict objectForKey:@"id"]];
            //Основной контент-----------------------------------------
            OpenSubjectView * mainContent = [[OpenSubjectView alloc] initWithView:self.view andDict:mainDict];
            [self.view addSubview:mainContent];
        } else {
            NSLog(@"Не дикшенери");
        }
        
        NSString * stringText = @"У вас 5 новых уведомлений в разделе";
        NSString * stringTitle = @"\"Женские секреты\"";
        
        ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
        [self.view addSubview:viewNotification];
        
        [self getAPIMessageWithBlock:^{
            NSMutableArray * mArrayChat = [NSMutableArray new];
            if ([[dictResponseMessage objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray * myArray = [NSArray arrayWithArray:[dictResponseMessage objectForKey:@"data"]];
            for (int i = 0; i < myArray.count; i++) {
                NSDictionary * dict = [myArray objectAtIndex:i];
                if ([[dict objectForKey:@"type"] isEqualToString:@"message"] && mArrayChat.count < 2) {
                    [mArrayChat addObject:dict];
                }
            }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_SEE_MESSAGE" object:mArrayChat];
            }
        }];
        

    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithDiscussions) name:NOTIFICATION_OPEN_SUBJECT_PUSH_TU_DISCUSSIONS object:nil];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - ACTION METHODS

- (void) notificationPushWithDiscussions
{
    DiscussionsController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscussionsController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] identifierSubjectModel], @"id",  nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"show_post" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}

//Показать все сообщения-----------------------------------------------
- (void) getAPIMessageWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             [[SingleTone sharedManager]postID], @"id_post",
                             [[SingleTone sharedManager]userID], @"id_user" , @"1", @"desc", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"chat_show_message" complitionBlock:^(id response) {
        
        dictResponseMessage = (NSDictionary*) response;        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}



@end

//
//  SubscriptionController.m
//  PsychologistIOS
//
//  Created by Viktor on 07.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SubscriptionController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SubscriptionView.h"
#import "SubscriptionModel.h"
#import "OpenSubjectController.h"
#import "ViewNotification.h"
#import "NotificationController.h"

@implementation SubscriptionController

- (void) viewDidLoad
{
#pragma mark - Header
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ПОДПИСКИ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initilization
    SubscriptionView * backgroundView = [[SubscriptionView alloc] initBackGrounWithView:self.view];
    [self.view addSubview:backgroundView];
    
    SubscriptionView * viewContent = [[SubscriptionView alloc] initWithContent:self.view andArray:[SubscriptionModel setArraySubscription]];
    [self.view addSubview:viewContent];
    
    NSString * stringText = @"У вас 5 новых уведомлений в разделе";
    NSString * stringTitle = @"\"Женские секреты\"";
    
    ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
    [self.view addSubview:viewNotification];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:NOTIFICATION_PUSH_SUBSCRIPTION_WITH_OPENSUBJECT object:nil];
}

#pragma mark - DEALLOC
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods

- (void) notificationAction: (NSNotification*) notification
{
        OpenSubjectController * detail = [self.storyboard
                                          instantiateViewControllerWithIdentifier:@"OpenSubjectController"];
        [self.navigationController pushViewController:detail animated:YES];
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}









@end

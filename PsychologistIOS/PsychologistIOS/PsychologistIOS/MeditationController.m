//
//  MeditationController.m
//  PsychologistIOS
//
//  Created by Viktor on 12.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "MeditationController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "MeditationView.h"
#import "MeditationModel.h"
#import "ViewNotification.h"
#import "NotificationController.h"

@implementation MeditationController

- (void) viewDidLoad {
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"МЕДИТАЦИИ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initiliztion
    
    MeditationView * contentView = [[MeditationView alloc] initWithView:self.view andArray:[MeditationModel setArraySubject]];
    [self.view addSubview:contentView];
    
    
    NSString * stringText = @"У вас 5 новых уведомлений в разделе";
    NSString * stringTitle = @"\"Женские секреты\"";
    
    ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
    [self.view addSubview:viewNotification];
    
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

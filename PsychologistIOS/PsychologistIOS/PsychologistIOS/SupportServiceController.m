//
//  SupportServiceController.m
//  PsychologistIOS
//
//  Created by Viktor on 13.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SupportServiceController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "SWRevealViewController.h"
#import "SupportServiceView.h"
#import "APIGetClass.h"
#import "ViewNotification.h"
#import "NotificationController.h"

@implementation SupportServiceController

- (void) viewDidLoad {
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"СЛУЖБА ПОДДЕРЖКИ"];
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
    
#pragma mark - Initiliztion
    
    //Основной вью контент--------------------------------------
    SupportServiceView * contentView = [[SupportServiceView alloc] initWithView:self.view];
    [self.view addSubview:contentView];
    
    NSString * stringText = @"У вас 5 новых уведомлений в разделе";
    NSString * stringTitle = @"\"Женские секреты\"";
    
    ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
    CGRect myRect = viewNotification.frame;
    myRect.origin.y -= 64;
    viewNotification.frame = myRect;
    [self.view addSubview:viewNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAction:) name:NOTIFICATION_SEND_EMAIL_SUPPORT object:nil];
    
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}


-(void)sendAction: (NSNotification*) notification{
    
    NSDictionary * dictSend = notification.object;
    [self sendEmail:[dictSend objectForKey:@"email"] name:[dictSend objectForKey:@"name"]
               text:[dictSend objectForKey:@"text"]];
    
}

-(void) sendEmail:(NSString *) email name:(NSString*) name text:(NSString*) text
{
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             name,@"name",
                             email,@"email",
                             text,@"text",
                             nil];
    
    
    
    
    
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:params method:@"send_email" complitionBlock:^(id response) {
        //        NSLog(@"%@", response);
        
        NSDictionary * result = (NSDictionary*)response;
        NSLog(@"resp: %@",result);
        
    }];
}

@end

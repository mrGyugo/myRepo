//
//  GalleryController.m
//  mykamchatka
//
//  Created by Viktor on 18.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "GalleryController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "GalleryView.h"
#import "APIGetClass.h"
#import "GalleryDetailsController.h"
#import "SingleTone.h"

@implementation GalleryController
{
    NSDictionary * dictResponse;
    NSArray * mainArray;
    GalleryView * galleryViewFirst;
    GalleryView * backgroungView;
    GalleryView * galleryViewSecond;

}

#pragma mark - Title

- (void) viewDidLoad {
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithLiteTitle:@"ГАЛЕРЕЯ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"b3ddf4"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcons.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 20, 20);
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar
    
    //Редактирование кнопки назад--------------------------------
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Назад"
                                   style:UIBarButtonItemStylePlain
                                   target:nil
                                   action:nil];
    self.navigationItem.backBarButtonItem=backButton;
    self.navigationItem.backBarButtonItem.image = [UIImage imageNamed:@""];
    
#pragma mark - Initialization
    
    //Реалезация нотификации--------------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotificationChangeMonth:) name:NOTIFICARION_GALLERY_VVIEW_CHANGE_MONTH object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotificationPushGallaryDetail:) name:NOTIFICATION_GALLARY_PUSH_GALLARY_DETAIL object:nil];
    
    //Основной вью-----------------------------------------------
    //Фон вью----------------------------------------------------
    backgroungView = [[GalleryView alloc] initBackgroundWithView:self.view];
    [self.view addSubview:backgroungView];
    //Выводим АПИ--------
    [self getAPIWithIdentifier:@"97" andBlock:^{
  
        mainArray = [NSArray arrayWithArray:[dictResponse objectForKey:@"gallery"]];
        galleryViewFirst = [[GalleryView alloc] initWithView:self.view ansArrayGallery:mainArray andFirst:YES];
        [backgroungView addSubview:galleryViewFirst];
    }];
}

#pragma mark - NotificationSelectors

- (void) actionNotificationChangeMonth: (NSNotification*) notification
{
    
    //Новая графика--------------------------------------------------------------
//    NSLog(@"Новое окно %@", notification.object);
    [self getAPIWithIdentifier:notification.object andBlock:^{
        mainArray = [NSArray arrayWithArray:[dictResponse objectForKey:@"gallery"]];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = galleryViewFirst.frame;
            rect.origin.x -= 400;
            galleryViewFirst.frame = rect;
            
        } completion:^(BOOL finished) {
            galleryViewSecond = [[GalleryView alloc] initWithView:self.view ansArrayGallery:mainArray andFirst:NO];
            

            
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rect = galleryViewSecond.frame;
                rect.origin.x += 400;
                galleryViewSecond.frame = rect;
            } completion:^(BOOL finished) {
                for (UIButton * button in [[SingleTone sharedManager] buttonsArray]) {
                    button.userInteractionEnabled = YES;
                }
                
                [[[SingleTone sharedManager] buttonsArray] removeAllObjects];
            }];

            [backgroungView addSubview:galleryViewSecond];
            galleryViewFirst = galleryViewSecond;
            
      
    }];
    }];
}

- (void) actionNotificationPushGallaryDetail: (NSNotification*) notification
{
    [[SingleTone sharedManager] setDictImage:notification.userInfo];
    GalleryDetailsController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"GalleryDetailsController"];
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark - API

- (void) getAPIWithIdentifier: (NSString*) string andBlock: (void (^)(void))block
{
    
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:string, @"catid", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:dictParams method:@"get_gallery" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        } 
    }];
}

#pragma mark - DEALLOCK
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

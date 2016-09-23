//
//  ApplicationController.m
//  mykamchatka
//
//  Created by Viktor on 26.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "ApplicationController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "ApplicationView.h"
#import "TitleClass.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import <AFNetworking/AFNetworking.h>
#import "MainViewController.h"
#import "AlertClass.h"

@implementation ApplicationController

#pragma mark - Title

- (void) viewDidLoad {
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithLiteTitle:@"ЗАЯВКА"];
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
    
#pragma mark - Initialization
    
    //Подвязываем бэкграунд фон---------------------------------
    ApplicationView * applicationViewWithBackGround = [[ApplicationView alloc] initBackgroundWithView:self.view];
    [self.view addSubview:applicationViewWithBackGround];
    
    //Подвязываем остальные UI элементы------------------------
    ApplicationView * applicationView = [[ApplicationView alloc] initWithView:self.view];
    [self.view addSubview:applicationView];
    
    //Нотификация----------------------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushWithMainView) name:NOTIFICATION_APPLICATION_PUSH_ON_MAIN_VIEW object:nil];
    
}

#pragma mark - PHOTO
//Действие кнопки выбрать фотографию-----------------------
- (void)openPhotoLibraryButton:(id)sender {
    NSLog(@"Выбираем фоточки");
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
    
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
        picker.allowsEditing = NO;
        
        [self presentViewController:picker animated:true completion:nil];
    }
    
}

// IMAGE PICKER DELEGATE =================
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image];
    [self dismissViewControllerAnimated:true completion:nil];
}

// SAVE IMAGE
- (void)saveImage: (UIImage*) image {
//    NSLog(@"%@",image);
    
    NSString *stringUrl = [NSString stringWithFormat:@"http://photokamchatka.irinayarovaya.ru/API/uploader.php"];
    NSData *imageLoad = UIImageJPEGRepresentation(image,0.8);

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:stringUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData:imageLoad name:@"userfile" fileName:@"audio.caf" mimeType:@"audio/caf"];
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSDictionary *response =(NSDictionary *)responseObject;
         [[SingleTone sharedManager] setUrlImage:[response objectForKey:@"url"]];
         
         

         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@ ***** %@", operation.responseString, error);
     }];

    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CHANGE_BUTTON_LOAD_PHOTO object:nil];
//    NSLog(@"OK");
}

#pragma mark - API
- (void) getAPIWithFio: (NSString*) fio andEmail: (NSString *) email
{
//    NSLog(@"URL %@",[[SingleTone sharedManager] urlImage]);
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                 fio, @"fio",
                                 email, @"email",
                                 [[SingleTone sharedManager] urlImage], @"url",nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:dictParams method:@"send_photo" complitionBlock:^(id response) {
        
       NSDictionary * dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
//            [AlertClass showAlertWithMessage:@"Ваша галлерея пуста"];
        }
    }];
}

#pragma mark - NOTIFICATION METHODS

- (void) pushWithMainView
{
    MainViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - DEALLOC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

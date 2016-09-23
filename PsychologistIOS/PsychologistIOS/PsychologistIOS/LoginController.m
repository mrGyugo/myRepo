//
//  LoginController.m
//  PsychologistIOS
//
//  Created by Viktor on 31.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "LoginController.h"
#import "SWRevealViewController.h"
#import "LoginView.h"
#import "Macros.h"
#import "CategoryController.h"
#import "VKApi.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKCoreKit/FBSDKGraphRequestConnection.h>

#import "Auth.h"
#import "AuthDbClass.h"
#import "SingleTone.h"
#import <AFNetworking/AFNetworking.h>
#import "APIGetClass.h"
#import "LicenseAgreementController.h"
#import "AlertClass.h"
#import "KrVideoPlayerController.h"

@interface LoginController () <UIWebViewDelegate>

@property (strong,nonatomic) NSString * loginString;
@property (strong,nonatomic) NSString * socTokenString;
@property (strong,nonatomic) NSString * socType;
@property (strong,nonatomic) NSString * type_auth;

@end

@implementation LoginController
{
    UIWebView * authWebView;
    NSDictionary * dictResponse;
    
    BOOL isBool;
    NSDictionary * responsePassword;
    NSDictionary * responseInfo;
    AuthDbClass * authDbClass;
    BOOL phoneAndMail;
    UIView * avtorizationView;
    UIActivityIndicatorView * activityView;

}

- (void) viewDidLoad
{
    
#pragma mark - Auth
    
    authDbClass = [[AuthDbClass alloc] init];
    isBool = NO;
    phoneAndMail = YES;
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = YES;
       
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
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
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar
    
#pragma mark - Initialization
    
    
    //Основной фон-------------------------------------
    LoginView * backgroundView = [[LoginView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    //Основные графические элементы--------------------
    LoginView * mainContentView = [[LoginView alloc] initWithContentView:self.view];
    [self.view addSubview:mainContentView];
    
    LoginView * buttonLigin = [[LoginView alloc] initButtonLogin];
    [mainContentView addSubview:buttonLigin];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushWithMainView) name:NOTIFICATION_LOGIN_VIEW_PUSH_MAIN_VIEW object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSmsCode:) name:NOTIFICATION_SEND_SMS_CODE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getEmailCode:) name:NOTIFICATION_SEND_EMAIL_CODE object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationVKAvto) name:@"VKN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFaceAvto) name:@"FaceBookN" object:nil];
    
    //Элементы авторизации------------------------------------
    avtorizationView = [[UIView alloc] initWithFrame:self.view.frame];
    avtorizationView.alpha = 0.f;
    avtorizationView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:avtorizationView];
    activityView = [[UIActivityIndicatorView alloc] initWithFrame:self.view.frame];
    activityView.backgroundColor = [UIColor clearColor];
    activityView.alpha = 0.f;
    [activityView stopAnimating];
    [self.view addSubview:activityView];
    
    UIButton * buttonLicense = (UIButton*)[self.view viewWithTag:386];
    [buttonLicense addTarget:self action:@selector(licensePush) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - CheckAuth
    //Проверка при запуске приложеия
    NSLog(@"COUNT %@",[authDbClass showAllUsers]);
    if([authDbClass showAllUsers].count>0){
        Auth * userInfo = [[authDbClass showAllUsers] objectAtIndex:0];
        //        NSLog(@"userInfo.salt: %@",userInfo.salt);
        
        //Проверка CoreData на существование password, token FB, token VK
        NSLog(@"TO %@",userInfo.login);
        NSLog(@"TO %@",userInfo.password);
        NSLog(@"TOT %@",userInfo.token_vk);
        if(userInfo.password.length != 0 || userInfo.token_fb.length != 0 || userInfo.token_vk.length != 0){
            NSLog(@"GO AUTH AUTO");
            avtorizationView.alpha = 0.6f;
            activityView.alpha = 1.f;
            [activityView startAnimating];
            [self performSelector:@selector(checkAuth) withObject:nil afterDelay:1.8f]; //Запуск проверки с паузой
        }else{
            [self showLoginWith:NO];
        }
    }else{
        [self showLoginWith:NO];
    }

}

#pragma mark - Video


//Показ проверки и анимация появления авторизации
-(void)showLoginWith:(BOOL) animation{
    if(animation){
        //Повяление с анимацией
        [UIView animateWithDuration:2.0 animations:^{
            avtorizationView.alpha = 0.6f;
            activityView.alpha = 1.f;
            [activityView startAnimating];
        }];
        
    }else{
        avtorizationView.alpha = 0.f;
        activityView.alpha = 0.f;
        [activityView stopAnimating];
    }
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - action Methods

- (void) getEmailCode: (NSNotification*) notification
{
    NSLog(@"Выводим почту %@", notification.object);
    self.loginString=notification.object;
    
    NSLog(@"%@",self.loginString);
    [self getPassword:notification.object type:@"email"];
    self.type_auth=@"pass";
}

- (void) getSmsCode: (NSNotification*) notification
{
    NSLog(@"NOTIF %@",notification.object);
    
    self.loginString = [notification.object stringByReplacingOccurrencesOfString: @"+" withString: @""];
    NSLog(@"%@",self.loginString);
    [self getPassword:notification.object type:@"phone"];
    self.type_auth=@"pass";
    
    
}

- (void) pushWithMainView
{
    
    
    UITextField * textFildSMS = (UITextField*)[self.view viewWithTag:120];

    
    if (textFildSMS.text.length < 5) {
        NSLog(@"%lu", textFildSMS.text.length);
        [AlertClass showAlertViewWithMessage:@"Код должен быть меньше 5 символов"];
    } else {
        NSLog(@"DEVICET %@",[[SingleTone sharedManager] token_ios]);
   
        
        [self getInfo:self.loginString andPassword:textFildSMS.text andDeviceToken:[[SingleTone sharedManager] token_ios] andSocToken:@"" andTypeAuth:self.type_auth andBlock:^{
            NSLog(@"INFO: %@",responseInfo);
            
            if ([[responseInfo objectForKey:@"error"]integerValue]==0) {
                
                NSString * token_fb;
                NSString * token_vk;
                
               
                
                NSDictionary * respData = [responseInfo objectForKey:@"data"];
                NSLog(@"VK: %@",respData);
                
                //Пустые токены
                
                if([[respData objectForKey:@"vk_token"] isEqual: [NSNull null]]){
                    
                    token_vk=@"";
                }else{
                    token_vk=[respData objectForKey:@"vk_token"];
                }
                
                if([[respData objectForKey:@"fb_token"] isEqual: [NSNull null]]){
                    
                    token_fb=@"";
                }else{
                    token_fb=[respData objectForKey:@"fb_token"];
                }
                
                //
                
                
                //Обновление базы данных
                [authDbClass updateUser:self.loginString andPassword:textFildSMS.text andIdUser:[respData objectForKey:@"id"] andTokenVk:token_vk andTokenFb:token_fb andTypeAuth:@"pass" ];
                
                
                CategoryController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryController"];
                
                
                [[SingleTone sharedManager]setLogin:[respData objectForKey:@"login"]];
                NSString * userID =[NSString stringWithFormat:@"%@",[respData objectForKey:@"id"]];
                [[SingleTone sharedManager]setUserID:userID];
                [[SingleTone sharedManager] setUserName:[respData objectForKey:@"name"]];
                
                [self.navigationController pushViewController:detail animated:YES];
            } else if ([[responseInfo objectForKey:@"error"]integerValue]==1) {
                
                NSLog(@"ERROR:%@",[responseInfo objectForKey:@"error_msg"]);
                [AlertClass showAlertViewWithMessage:@"Не верно введен код"];
                
            }
        }];
        
        

        
   
}
    
}

- (void) notificationFaceAvto
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else {
             NSLog(@"Logged in");
             
             NSString * string = result.token.appID;
             NSString * strng2 = result.token.tokenString;
             self.socTokenString=result.token.tokenString;
             NSLog(@"%@", string);
             NSLog(@"%@", strng2);
           //-------------
             
             
             [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                parameters:@{@"fields": @"name, first_name, last_name, email"}]
              startWithCompletionHandler:^(FBSDKGraphRequestConnection * connection, id result, NSError * error) {
                  if (!error) {
                      
                      NSLog(@"result %@", result);
                      
                     [self saveSocToken:self.socTokenString type:@"fb" andFname:[result objectForKey:@"first_name"] andLname:[result objectForKey:@"last_name"] andBdate:@"" andCity:@""];
                      
                      
                  }
                  else{
                      NSLog(@"%@", [error localizedDescription]);
                  }
              }];


             
          //-----------
             
         }
     }];
}

- (void) notificationVKAvto
{
    //создаем webView
    authWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    authWebView.tag = 1024;
    authWebView.delegate = self;
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:authWebView];
    [authWebView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://oauth.vk.com/authorize?client_id=5461383&scope=wall,offline&redirect_uri=oauth.vk.com/blank.html&display=touch&response_type=token"]]];
    //обеспечиваем появление клавиатуры для авторизации
    [self.view.window makeKeyAndVisible];
    //создаем кнопочку для закрытия окна авторизации
    closeButton.frame = CGRectMake(5, 15, 20, 20);
    closeButton.tag = 1025;
    [closeButton addTarget:self action:@selector(closeWebView) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
}

-(void) closeWebView {
    [[self.view viewWithTag:1024] removeFromSuperview];
    [[self.view viewWithTag:1025] removeFromSuperview];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    //создадим хеш-таблицу для хранения данных
    NSMutableDictionary* user = [[NSMutableDictionary alloc] init];
    //смотрим на адрес открытой станицы
    NSString *currentURL = webView.request.URL.absoluteString;
    NSRange textRange =[[currentURL lowercaseString] rangeOfString:[@"access_token" lowercaseString]];
    //смотрим, содержится ли в адресе информация о токене
    if(textRange.location != NSNotFound){
        //Ура, содержится, вытягиваем ее
        NSArray* data = [currentURL componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
        [user setObject:[data objectAtIndex:1] forKey:@"access_token"];
        [user setObject:[data objectAtIndex:3] forKey:@"expires_in"];
        [user setObject:[data objectAtIndex:5] forKey:@"user_id"];
        
        //Получаем нужные строки
        NSString * access_token = [user objectForKey:@"access_token"];
        NSString * user_id = [user objectForKey:@"user_id"];
        //Передаем данные в АПИ
        [self getApiWithUserID:user_id andUserToken:access_token andBlock:^{
            self.socTokenString=access_token;
            
            NSArray * response = (NSArray *) [dictResponse objectForKey:@"response"];
            NSDictionary * result = (NSDictionary *)[response objectAtIndex:0];
            NSLog(@"VK DICT%@", result);
             VKApi * vkApi = [VKApi new];
            [vkApi getСityFromVK:[result objectForKey:@"city"] complitionBlock:^(id response) {
                NSLog(@"%@",response);
                
                NSArray * array = [response objectForKey:@"response"];
                NSDictionary * resDict;
                if(array.count>0){
                    resDict = [array objectAtIndex:0];
                }else{
                    resDict = nil;
                }
                
                
                
                [self saveSocToken:access_token type:@"vk" andFname:[result objectForKey:@"first_name"] andLname:[result objectForKey:@"last_name"] andBdate:[result objectForKey:@"bdate"] andCity:[resDict objectForKey:@"name"]];
            }];
            
            
            
        }];
        
    
        
        
        [self closeWebView];
        //передаем всю информацию специально обученному классу
        //[[VkontakteDelegate sharedInstance] loginWithParams:user];
//        [[VkontakteDelegate sharedInstance] postToWall];
    }
    else {
        //Ну иначе сообщаем об ошибке...
        textRange =[[currentURL lowercaseString] rangeOfString:[@"access_denied" lowercaseString]];
        if (textRange.location != NSNotFound) {
            NSLog(@"Check your internet connection and try again!");
            [self closeWebView];
        }
    }
}

#pragma mark - VK API
//Зпрос данных
- (void) getApiWithUserID: (NSString*) userIdD andUserToken: (NSString*) userToken andBlock: (void (^)(void))block
{
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:userIdD, @"user_id",
                                 userToken, @"access_token", nil];
    VKApi * vkApi = [VKApi new];
    [vkApi getUserWithParams:dictParams complitionBlock:^(id response) {
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}

//Вывод сообщения не стену------------
- (void) postVKAPIWithMessage: (NSString*) message
                    andUserID: (NSString*) userIdD
                 andUserToken: (NSString*) userToken
                 andURLString: (NSString*) urlString
{
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:userIdD, @"user_id",
                                 userToken, @"access_token", urlString, @"attachments", nil];
    VKApi * vkAPI = [VKApi new];
    [vkAPI postWallWithParams:dictParams message:message andLinkAttach:nil complitionBlock:^(id response) {
        if ([[response objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [response objectForKey:@"error_msg"]);
            
            
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[response objectForKey:@"error"] integerValue] == 0) {
            
            NSLog(@"Все хорошо");

        }
    }];
}

#pragma mark - API

-(void) getPassword:(NSString *) login type:(NSString*) type
{
    NSDictionary * params;
    NSString * method;
    if([type isEqualToString:@"phone"]){
        NSString * phoneResult = [login stringByReplacingOccurrencesOfString: @"+" withString: @""];
        params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 phoneResult,@"phone",
                                 nil];
        method = @"get_password";
    }else if([type isEqualToString:@"email"]){
        
        params = [[NSDictionary alloc] initWithObjectsAndKeys:
                  login,@"email",
                  nil];
        method = @"get_password_email";
        
    }
   
    
    
    
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:params method:method complitionBlock:^(id response) {
        //        NSLog(@"%@", response);
        
        responsePassword = (NSDictionary*)response;
        NSLog(@"resp: %@",responsePassword);
        NSLog(@"error_msg: %@",[responsePassword objectForKey:@"error_msg"]);
        
    }];
}

-(void) saveSocToken:(NSString *) token type:(NSString*) type andFname:(NSString *) fname andLname: (NSString *) lname
            andBdate:(NSString *) bdate andCity:(NSString *) city_name

{
    NSDictionary * params;
    NSString * auth;
   
    if([type isEqualToString:@"vk"]){
     auth=@"vk";

    }else if([type isEqualToString:@"fb"]){
        NSLog(@"FNAME %@",fname);
        
        auth=@"fb";
  
        
    }
    NSString * idUser;
    
    
    if([[[SingleTone sharedManager] userID] isEqual: [NSNull null]]){
        
      idUser = @"";
        
    }else{
       idUser = [[SingleTone sharedManager] userID];
    }
    
   
    params = [[NSDictionary alloc] initWithObjectsAndKeys:
              token,@"soc_token",
              auth,@"type",
              fname,@"first_name",
              lname,@"last_name",
              city_name,@"city_name",
              bdate,@"bdate",
              idUser,@"id_user",
              
              nil];
     NSLog(@"CITY %@",city_name);
    
    
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:params method:@"save_soc_token" complitionBlock:^(id response) {
        
        
        responsePassword = (NSDictionary*)response;
        NSLog(@"resp: %@",responsePassword);
        if ([[responsePassword objectForKey:@"error"] integerValue] == 0) {
            NSString * userID =[NSString stringWithFormat:@"%@",[responsePassword objectForKey:@"id"]];
            NSLog(@"USERID %@",userID);
            [[SingleTone sharedManager] setUserID:userID];
            [[SingleTone sharedManager] setUserName:[responsePassword objectForKey:@"name"]];
              
            if([type isEqualToString:@"vk"]){
               [authDbClass updateUser:@"" andPassword:@"" andIdUser:userID andTokenVk:self.socTokenString andTokenFb:@"" andTypeAuth:auth];
                
            }else if([type isEqualToString:@"fb"]){
               [authDbClass updateUser:@"" andPassword:@"" andIdUser:userID andTokenVk:@"" andTokenFb:self.socTokenString andTypeAuth:auth];
                
                
            }
            
            
            CategoryController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryController"];
            
            
            [self.navigationController pushViewController:detail animated:YES];
            
        }else{
                NSLog(@"error_msg: %@",[responsePassword objectForKey:@"error_msg"]);
           
        }
        
        
    }];
}

-(void) getInfo:(NSString *) login andPassword:(NSString*) password andDeviceToken: (NSString*) token_ios andSocToken: (NSString*) token_soc andTypeAuth: (NSString*) type_auth
       andBlock:(void (^)(void))block
{
    
    NSString *socToken;
    if([token_soc isEqual: [NSNull null]]){
        socToken=@"";
    }else{
        socToken=token_soc;
    }
    
    NSString * iosToken;
    
    if([token_ios isEqual: [NSNull null]]){
        iosToken=@"";
    }else{
        iosToken=token_ios;
    }
   
    
    NSString * loginResult = [login stringByReplacingOccurrencesOfString: @"+" withString: @""];
    
    NSLog(@"TYPE L: %@",loginResult);
    NSLog(@"TYPE P: %@",password);
    NSLog(@"TYPE T: %@",iosToken);
    NSLog(@"TYPE ST: %@",socToken);
    NSLog(@"TYPE A: %@",type_auth);
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             loginResult,@"login",
                             password,@"password",
                             iosToken,@"token",
                             socToken,@"soc_token",
                             type_auth,@"type_auth",
                             nil];
    
    NSLog(@"PARAMS %@",params);
  
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:params method:@"show_user_token" complitionBlock:^(id response) {
               NSLog(@"АВТОРИЗАЦИЯ %@", response);
        
        responseInfo = (NSDictionary*)response;
        block();
        
    }];
}

-(void) checkAuth
{
    
    if([authDbClass showAllUsers].count>0){
        Auth * userInfo = [[authDbClass showAllUsers] objectAtIndex:0];
        NSDictionary * params;
        if([userInfo.type_auth isEqualToString:@"pass"]){
            params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     userInfo.login,@"login",
                                     userInfo.password, @"password",
                                     userInfo.token_ios,@"token",
                                     @"",@"soc_token",
                                     @"pass",@"type_auth",
                                     nil];
        }else if([userInfo.type_auth isEqualToString:@"vk"]){
            params = [[NSDictionary alloc] initWithObjectsAndKeys:
                      userInfo.login,@"login",
                      userInfo.password, @"password",
                      userInfo.token_ios,@"token",
                      userInfo.token_vk,@"soc_token",
                      @"vk",@"type_auth",
                      nil];
        }else if([userInfo.type_auth isEqualToString:@"fb"]){
            params = [[NSDictionary alloc] initWithObjectsAndKeys:
                      userInfo.login,@"login",
                      userInfo.password, @"password",
                      userInfo.token_ios,@"token",
                      userInfo.token_vk,@"soc_token",
                      @"fb",@"type_auth",
                      nil];
        }
        
       
        
        
        APIGetClass * getInfo = [[APIGetClass alloc] init];
        
        if((userInfo.password.length != 0 &&userInfo.login.length != 0) || userInfo.token_vk.length !=0 || userInfo.token_fb.length !=0){
            [getInfo getDataFromServerWithParams:params method:@"show_user_token" complitionBlock:^(id response) {
                
                
                NSDictionary * responseCheckInfo = (NSDictionary*)response;
            
                
                //Записываем имя при проврке
                
                
                
                
                if ([[responseCheckInfo objectForKey:@"error"] integerValue] == 0) {
                    [self showLoginWith:YES];
                    
                    NSDictionary * data = [responseCheckInfo objectForKey:@"data"];
                    
                    //Берем userID
                    [[SingleTone sharedManager] setUserID:[data objectForKey:@"id"]];
                    [[SingleTone sharedManager] setLogin:[data objectForKey:@"login"]];
                    [[SingleTone sharedManager] setUserName:[data objectForKey:@"name"]];
                   
                   
                    
                    CategoryController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryController"];
                    
                    
                    [self.navigationController pushViewController:detail animated:YES];
                    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.5];

                    
                } else {
                    NSLog(@"%@", [responseCheckInfo objectForKey:@"error_msg"]);
                    
                    
                    [self showLoginWith:NO];
                    
                }
                
                
            }];
        }else{
            [self showLoginWith:NO];
            
        }
    }
}

- (void) stopAnimation
{
    avtorizationView.alpha = 0.f;
    activityView.alpha = 0.f;
    [activityView stopAnimating];
}

- (void) licensePush
{
    LicenseAgreementController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"LicenseAgreementController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end

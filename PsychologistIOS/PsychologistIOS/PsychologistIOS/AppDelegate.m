//
//  AppDelegate.m
//  PsychologistIOS
//
//  Created by Viktor on 31.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "AppDelegate.h"
#import "SingleTone.h"
#import <FBSDKSettings.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import <MagicalRecord/MagicalRecord.h>
#import "Auth.h"
#import "AuthDbClass.h"
#import "SingleTone.h"
#import "Macros.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
[[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    [[AVAudioSession sharedInstance] setDelegate:self];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    UInt32 size = sizeof(CFStringRef);
    CFStringRef route;
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &size, &route);
    NSLog(@"route = %@", route);
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    
      AuthDbClass * auth = [AuthDbClass new];
    [[SingleTone sharedManager] setToken_ios:@"TEST"];
    
    if(![auth checkDeviceToken:@"TEST"]){
        
        [auth putDeviceToken:@"TEST"];
        Auth * userInfo = [[auth showAllUsers] objectAtIndex:0];
        NSLog(@"ADD TOKEN: %@",userInfo.token_ios);
        
    }else{
        [auth updateToken:@"TEST"];
        Auth * userInfo = [[auth showAllUsers] objectAtIndex:0];
        NSLog(@"UPDATE TOKEN: %@",userInfo.token_ios);
    }

    
    self.window.clipsToBounds = YES;
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
    self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height);
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    // Для iOS 8 и выше
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    
    
    
    
//    //Тестовый вызов нотификации через 10 секунд-----------------------------
//    [NSTimer scheduledTimerWithTimeInterval:5.0f
//                                     target:self selector:@selector(upViewNotification) userInfo:nil repeats:YES];
    
    
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)theEvent {
    
    if (theEvent.type == UIEventTypeRemoteControl)  {
        switch(theEvent.subtype)        {
            case UIEventSubtypeRemoteControlPlay:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TogglePlayPause" object:nil];
                break;
            case UIEventSubtypeRemoteControlPause:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TogglePlayPause" object:nil];
                break;
            case UIEventSubtypeRemoteControlStop:
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TogglePlayPause" object:nil];
                break;
            default:
                return;
        }
    }
}

//Тестовый метод подъема вью нотификации
- (void) upViewNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UP_VIEW_NOTIFICATION object:nil];
}

//Для получение push
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken  {
    
    AuthDbClass * auth = [AuthDbClass new];
    NSString * deviceTokenString = [[[[deviceToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    [[SingleTone sharedManager] setToken_ios:deviceTokenString];
    
      NSLog(@"My token is: %@",  [[SingleTone sharedManager] token_ios]);
    
    if(![auth checkDeviceToken:deviceTokenString]){
        
        [auth putDeviceToken:deviceTokenString];
        Auth * userInfo = [[auth showAllUsers] objectAtIndex:0];
        NSLog(@"ADD TOKEN: %@",userInfo.token_ios);
        
    }else{
        [auth updateToken:deviceTokenString];
        Auth * userInfo = [[auth showAllUsers] objectAtIndex:0];
        NSLog(@"UPDATE TOKEN: %@",userInfo.token_ios);
    }
    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //    NSLog(@"Failed to get token, error: %@", error);
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
       NSLog(@"Received notification: %@", userInfo);
    if([[userInfo objectForKey:@"info"] isEqualToString:@"badge_null"]){
        //        application.applicationIconBadgeNumber=0;
    }
    
    if([[userInfo objectForKey:@"info"] isEqualToString:@"rch"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadChat" object:self];
    }
    
    if([[userInfo objectForKey:@"info"] isEqualToString:@"pay"]){
        
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"CategoryController"];
        

        
    }
}
//

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadChat" object:self];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

- (void) changeBadge: (NSNotification*) notification
{
    NSString * strinhBadge = (NSString*)notification.object;
    NSLog(@"strinhBadge - %@", strinhBadge);
    
    NSInteger intBadge = [strinhBadge integerValue];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:intBadge];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

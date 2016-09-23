//
//  AuthDbClass.h
//  PsychologistIOS
//
//  Created by Кирилл Ковыршин on 14.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthDbClass : NSObject

- (void) putDeviceToken:(NSString *) deviceToken;
- (BOOL)checkDeviceToken:(NSString*) deviceToken;
- (void)updateToken:(NSString *)deviceToken;
- (void)updateUser:(NSString *) login
       andPassword: (NSString*) password
         andIdUser: (NSString*) id_user
        andTokenVk: (NSString*) token_vk
        andTokenFb: (NSString*) token_fb
       andTypeAuth: (NSString*) typeAuth;
- (BOOL)checkTokens:(NSString*) token type:(NSString*) type;
- (NSArray *) showAllUsers;
- (void) deleteAll;





@end

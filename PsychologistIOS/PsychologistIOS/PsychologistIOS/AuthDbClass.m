//
//  AuthDbClass.m
//  PsychologistIOS
//
//  Created by Кирилл Ковыршин on 14.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "AuthDbClass.h"
#import "Auth.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AuthDbClass

//Метод сохраняющий deviceToken для push уведомлений
-(void) putDeviceToken:(NSString *) deviceToken {
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    Auth *auth = [Auth MR_createEntityInContext:localContext];
    auth.uid =@"1";
    auth.token_ios=deviceToken;
    
    NSLog(@"SAVE DEVICE TOKEN");
    [localContext MR_saveToPersistentStoreAndWait];
    
}

//Проверка токена в CoreData
- (BOOL)checkDeviceToken:(NSString*) deviceToken{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"token_ios ==[c] %@ AND uid ==[c] 1",deviceToken];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (authFounded)
    {
        return YES;
    }else{
        return NO;
    }
}

//Обновление токена
- (void)updateToken:(NSString *)deviceToken
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        
        authFounded.token_ios = deviceToken;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}
//

//Обновление данных пользователя
- (void)updateUser:(NSString *) login
           andPassword: (NSString*) password
       andIdUser: (NSString*) id_user
         andTokenVk: (NSString*) token_vk
        andTokenFb: (NSString*) token_fb
        andTypeAuth: (NSString*) typeAuth

{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        
        authFounded.login = login;
        authFounded.password = password;
        authFounded.id_user = id_user;
        authFounded.token_fb = token_fb;
        authFounded.token_vk = token_vk;
        authFounded.type_auth = typeAuth;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}



//Проверка токена в CoreData
- (BOOL)checkTokens:(NSString*) token type:(NSString*) type{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    NSPredicate *predicate ;
    
    if([type isEqualToString:@"vk"]){
            predicate                  = [NSPredicate predicateWithFormat:@"token_vk ==[c] %@ AND uid ==[c] 1",token];
    }else if([type isEqualToString:@"fb"]){
            predicate                  = [NSPredicate predicateWithFormat:@"token_fb ==[c] %@ AND uid ==[c] 1",token];
    }else if([type isEqualToString:@"pass"]){
        predicate                  = [NSPredicate predicateWithFormat:@"password ==[c] %@ AND uid ==[c] 1",token];
    }
   
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (authFounded)
    {
        return YES;
    }else{
        return NO;
    }
}


-(NSArray *) showAllUsers{
    NSArray *users            = [Auth MR_findAll];
    return users;
}

-(void) deleteAll{
    
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        // Delete the person found
        [authFounded MR_deleteEntityInContext:localContext];
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}


@end

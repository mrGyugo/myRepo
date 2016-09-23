//
//  Auth+CoreDataProperties.h
//  PsychologistIOS
//
//  Created by Кирилл Ковыршин on 15.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Auth.h"

NS_ASSUME_NONNULL_BEGIN

@interface Auth (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *login;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *token_fb;
@property (nullable, nonatomic, retain) NSString *token_ios;
@property (nullable, nonatomic, retain) NSString *token_vk;
@property (nullable, nonatomic, retain) NSString *type_auth;
@property (nullable, nonatomic, retain) NSString *id_user;
@property (nullable, nonatomic, retain) NSString *fio;
@property (nullable, nonatomic, retain) NSString *uid;

@end

NS_ASSUME_NONNULL_END

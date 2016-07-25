//
//  Patient.h
//  Protocols
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © /Users/viktormisustin/Documents/Develop/Scutorenko/Protocols/Protocols/Developer.m2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Patient <NSObject>

@property (strong, nonatomic) NSString * name;

- (BOOL) areYouOk;
- (void) takePill;
- (void) makeShot;

@optional

- (NSString*) howIsYouFamily;
- (NSString*) howIsYouJob;

@end

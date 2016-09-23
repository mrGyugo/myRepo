//
//  SingleTone.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "SingleTone.h"

@implementation SingleTone

@synthesize titleSubCategory;
@synthesize titleCategory;
@synthesize titleSubject;
@synthesize titleInstruction;

@synthesize identifierCategory;
@synthesize identifierSubCategory;
@synthesize identifierSubjectModel;

@synthesize tariffDict;

@synthesize apiImage;
@synthesize tariffID;

@synthesize audioURL;

@synthesize token_ios;
@synthesize login;

@synthesize userID;
@synthesize postID;

@synthesize userName;

@synthesize postType;

@synthesize rules;




#pragma mark Singleton Methods

+ (id)sharedManager{
    static SingleTone *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


@end

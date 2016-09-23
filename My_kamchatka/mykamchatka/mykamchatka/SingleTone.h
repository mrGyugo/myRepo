//
//  SingleTone.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTone : NSObject

@property (strong, nonatomic) NSDictionary * dictImage;
@property (strong, nonatomic) NSString * urlImage;
@property (strong, nonatomic) NSMutableArray * buttonsArray;

+ (id)sharedManager;

@end

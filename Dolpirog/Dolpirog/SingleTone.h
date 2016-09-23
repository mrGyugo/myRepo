//
//  SingleTone.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SingleTone : NSObject

@property (strong, nonatomic) UIView * viewBasketBar;
@property (strong, nonatomic) UILabel * labelCountBasket;
@property (strong, nonatomic) NSDictionary * dictOrder;

+ (id)sharedManager;

@end

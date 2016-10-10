//
//  AlertView.h
//  MapOfEurope
//
//  Created by Виктор Мишустин on 09.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertView : NSObject

+ (void) showAlertViewWithCountry: (NSString*) country andColor: (UIColor*) color;

@end

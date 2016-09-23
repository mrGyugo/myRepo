//
//  APIClass.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIGetClass : NSObject
//Метод получающий данные с сервера
-(void) getDataFromServerWithParams: (NSDictionary *) params method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack;
@end

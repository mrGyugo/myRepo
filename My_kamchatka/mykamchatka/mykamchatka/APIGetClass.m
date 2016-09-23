//
//  APIClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "APIGetClass.h"
#import <AFNetworking/AFNetworking.h>


#define MAIN_URL @"http://photokamchatka.irinayarovaya.ru/API/api.php" //Адрес сервера
#define API_KEY @"MFswDQYJKoZIhvcNAQEBBQADSgAwRwJAaL6Ep736vhUaI813qZvqegTk1qf8T" //Ключ API

@implementation APIGetClass


//Запрос на сервер
-(void) getDataFromServerWithParams: (NSDictionary *) params method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack{
//-----------
    NSString * url = [NSString stringWithFormat:@"%@?api_key=%@&action=%@",MAIN_URL,API_KEY,method];
//    NSLog(@"URL: %@",url);
    NSString * encodedURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
//-------------------
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    //Запрос
    [manager GET: encodedURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Вызов блока
        compitionBack (responseObject);
        
        
        //Ошибки
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end

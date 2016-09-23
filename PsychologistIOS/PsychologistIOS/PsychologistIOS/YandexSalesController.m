//
//  YandexSalesController.m
//  PsychologistIOS
//
//  Created by Viktor on 11.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "YandexSalesController.h"
#import "YMAAPISession.h"
#import "YMAHostsProvider.h"
#import <YandexMoneySDKObjc/YMAAPISession.h>
#import "YMAExternalPaymentRequest.h"
#import "YMAExternalPaymentResponse.h"
#import "SingleTone.h"

@interface YandexSalesController () <UIWebViewDelegate>

@end

@implementation YandexSalesController
{
    UIWebView * mainWeb;
    YMAAPISession * session;
    NSString * token;
}

- (void) viewDidLoad
{
    mainWeb = [[UIWebView alloc] initWithFrame:self.view.frame];
    mainWeb.delegate = self;
    
    NSString * paymentType = @"";
    NSString * shopId = @"58658";
    NSString * scid = @"536545";
    NSDictionary * tariffDict = [[SingleTone sharedManager] tariffDict];
    NSLog(@"TDICT %@",tariffDict);
    
    NSString * sum = [tariffDict objectForKey:@"cost"];
    //customerNumber - id пользователя
    NSString * customerNumber = [[SingleTone sharedManager] userID];
    //shopArticleId - идентификатор тарифа
    
    
    NSString * id_tariff = [tariffDict objectForKey:@"id_tariff"];
    NSString * id_category = [tariffDict objectForKey:@"id_category"];
    
    NSString *urlStr = [NSString stringWithFormat:@"https://demomoney.yandex.ru/eshop.xml?paymentType=%@&shopId=%@&scid=%@&sum=%@&customerNumber=%@&id_tariff=%@&id_category=%@",paymentType, shopId, scid, sum, customerNumber, id_tariff, id_category];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"urlSTR %@",urlStr);
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [mainWeb loadRequest:requestObj];
    [self.view addSubview:mainWeb];

}



@end

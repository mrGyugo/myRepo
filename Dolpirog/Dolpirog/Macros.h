//
//  Macros.h
//  ITDolgopa
//
//  Created by Viktor on 05.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

/*Наименование нотификайии состоит из 3ех частей
 1 часть - Идентификатор нотификиции
 2 часть - Название класса где созданна нотификаци
 3 часть - Действие которое выполняет нотификации
*/

#ifndef Macros_h
#define Macros_h




//Макросы для приложения ---------------------------------------------------

//Элементы под разные устройства----------------------------------------------
#define isiPhone6  ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone4s  ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE
#define isiPhone6Plus  ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE


//Шрифты--------------------------------------------------------------------------
#define FONTREGULAR @"PFAgoraSlabPro-Regular"
#define FONTBOND @"PFAgoraSlabPro-Bold"

//Цвета----------------------------------------------------------------------------
#define COLORGREEN @"49c903"
#define COLORBLACK @"000000"
#define COLORBROWN @"7a3505"
#define COLORTEXTGRAY @"4d4d4b"
#define COLORPINCK @"fe3a63"
#define COLORLITEGRAY @"ababa9"
#define COLORORANGE @"fba906"
#define COLORTEXTWHITE @"fcfcfc"
#define COLORTEXTORANGE @"cf9d5b"
#define COLORTEXTLITE @"e3e4e0"

//Нотификации класса LoginView and LoginController
#define NOTIFICATION_LOGIN_VIEW_PUSH_BOUQUETS_CONTROLLER @"NOTIFICATION_LOGIN_VIEW_PUSH_BOUQUETS_CONTROLLER"
//Нотификация класса BasketController
#define NOTIFICATION_BASKET_CONTROLLER_PUSH_CHEKOUT_CONTROLLER @"NOTIFICATION_BASKET_CONTROLLER_PUSH_CHEKOUT_CONTROLLER"
//Нотификация класса CatalogView
#define NOTIFIVATION_CATALOG_VIEW_PUSH_CATALOG_DETAIL_CONTROLLER @"NOTIFIVATION_CATALOG_VIEW_PUSH_CATALOG_DETAIL_CONTROLLER"
//Нотификация класса ScrollViewImage
#define NOTIFICATION_SCROLL_VIEW_IMAGE_PUSH_ORDER_CONTROLLER @"NOTIFICATION_SCROLL_VIEW_IMAGE_PUSH_ORDER_CONTROLLER"
//Нотификация класса CheckoutView
#define NOTIFICATION_CHECKOUT_VIEW_PUSH_ORDER_ACCEPTED_CONTROLLER @"NOTIFICATION_CHECKOUT_VIEW_PUSH_ORDER_ACCEPTED_CONTROLLER"

#endif /* Macros_h */

//
//  Macros.h
//  ITDolgopa
//
//  Created by Viktor on 05.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//Список кастомных тегов объектов приложени--------------------------------


//Макросы для приложения ---------------------------------------------------
//Тут записанны общие данные о хар-ках приложения---------------------------

//Шрифты и размеры в зависимости от устройства------------------------------

#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height <= 568)?TRUE:FALSE

//Шрифты--------------------------------------------------------------------------
#define FONTREGULAR @"SFUIDisplay-Regular"
#define FONTLITE @"SFUIDisplay-Light"
#define FONTBOND @"SFUIDisplay-Bold"

//Цвета---------------------------------------------------------------------------
#define COLORLITEGRAY @"929597"
#define COLORLITELITEGRAY @"f9fafa"

#define COLORBLUETEXT @"05a4f6"

//Нотификации---------------------------------------------------------------------
#define NOTIFICARION_GALLERY_VVIEW_CHANGE_MONTH @"NOTIFICARION_GALLERY_VVIEW_CHANGE_MONTH"
#define NOTIFICATION_GALLARY_PUSH_GALLARY_DETAIL @"NOTIFICATION_GALLARY_PUSH_GALLARY_DETAIL"
#define NOTIFICATION_APPLICATION_PUSH_ON_MAIN_VIEW @"NOTIFICATION_APPLICATION_PUSH_ON_MAIN_VIEW"
#define NOTIFICATION_CHANGE_BUTTON_LOAD_PHOTO @"NOTIFICATION_CHANGE_BUTTON_LOAD_PHOTO"
#define NOTIFICATION_BACK_BUTTONS_YEARS @"NOTIFICATION_BACK_BUTTONS_YEARS"



#endif /* Macros_h */

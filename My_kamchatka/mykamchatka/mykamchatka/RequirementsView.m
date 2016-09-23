//
//  RequirementsView.m
//  mykamchatka
//
//  Created by Viktor on 16.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "RequirementsView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation RequirementsView
{
    UIScrollView * mainScrolView;
    
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //Создаем фон из двух частей фонофого затемнения и изображения--------------------
        UIView * secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        secondView.backgroundColor = [UIColor colorWithHexString:@"eceff3"];
        [self addSubview:secondView];
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        mainImageView.image = [UIImage imageNamed:@"RequirementsFon.jpg"];
        mainImageView.alpha = 0.25f;
        [secondView addSubview:mainImageView];
        
        //Создаем скрол вью---------------------------------------------------------------
        //Создаем рабочий скрол вью-------------------------------------------------------
        mainScrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mainImageView.frame.size.width, mainImageView.frame.size.height)];
        [self addSubview:mainScrolView];
        
        //Наносим текст-------------------------------------------------------------------
        UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, mainScrolView.frame.size.width - 60, 1100)];
        labelText.text = @"В фотоконкурсе могут принять участие молодые фотографы-любители Камчатского края в возрасте до 21 года, согласные с условиями фотоконкурса и Положением о фотоконкурсе.\n\n\nДля участия в фотоконкурсе необходимо до 18 мая 2016 г. сделать постановочные и/или репортажные, и/или выбранные из семейного архива фотографии, соответствующие заявленной теме фотоконкурса, прислать работы в электронном виде по электронному адресу:  photokamchatka@irinayarovaya.ru\nс пометкой фотоконкурс «Моя любимая Камчатка – приглашение к путешествию». В сопроводительном письме указать контактную информацию об авторе-участнике (контактное лицо, возраст, номер телефона).\n\n\nКоличество фоторабот от одного участника не может быть более трех.\n\nФотоконкурс проводится в один этап по\n\n• «Зима»;\n• «Весна»;\n• «Лето»;\n• «Осень».\n\nТехнические требования к фотографиям:\n\n• Формат файла: JPG, TIFF;\n• Разрешение изображения: 300 dpi;\n• Принимаются фотографии как вертикальной, так и горизонтальной расположенности;\n• Размер изображения: основным критерием является возможность распечатать фотографию размером 40х60 см. высокого качества;\n• Размер файла желательно не превышать 10 Мб;\n• Рассматриваются исключительно фотографии без дополнительных надписей, рамок, подписей и прочих элементов, добавленных поверх фото, полученного с камеры или после базовой постобработки;\n• Допускается обработка фотографий, направляемых на Фотоконкурс, с помощью компьютерных программ (графических редакторов).";
        labelText.numberOfLines = 0;
        labelText.textColor = [UIColor blackColor];
        labelText.font = [UIFont fontWithName:FONTREGULAR size:16];
        if (isiPhone5) {
            labelText.frame = CGRectMake(30, 40, mainScrolView.frame.size.width - 60, 1300);
        }
        [mainScrolView addSubview:labelText];
        
        mainScrolView.contentSize = CGSizeMake(0, labelText.frame.size.height + 130);
        
        
    }
    return self;
}

@end

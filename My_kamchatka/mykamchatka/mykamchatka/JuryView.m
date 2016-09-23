//
//  JuryView.m
//  mykamchatka
//
//  Created by Viktor on 18.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "JuryView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation JuryView
{
    UIScrollView * mainScrollView;
}

- (instancetype)initWithView: (UIView*) view ansArrayJuri: (NSMutableArray*) array
    {
        self = [super init];
        if (self) {
            self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            
            //Создаем фон из двух частей фонофого затемнения и изображения--------------------
            UIView * secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            secondView.backgroundColor = [UIColor colorWithHexString:@"eceff3"];
            [self addSubview:secondView];
            UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            mainImageView.image = [UIImage imageNamed:@"JuriFon.jpeg"];
            mainImageView.alpha = 0.25f;
            [secondView addSubview:mainImageView];
            
            //Создаем рабочий скрол вью-------------------------------------------------------
            mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mainImageView.frame.size.width, mainImageView.frame.size.height)];
            [self addSubview:mainScrollView];
            
            for (int i = 0; i < 6; i++) {

                NSDictionary * dictJuri = [array objectAtIndex:i];
                
                //Основное окно ячейки------------------------
                UIView * viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 150 * i, mainScrollView.frame.size.width, 150)];
                viewCell.backgroundColor = [UIColor clearColor];
                [mainScrollView addSubview:viewCell];
                
                //Изображение участника жюри------------------
                UIImageView * imageJuri = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 100, 100)];
                imageJuri.image = [UIImage imageNamed:[dictJuri objectForKey:@"image"]];
                imageJuri.layer.cornerRadius = 50;
                if (isiPhone5) {
                    imageJuri.frame = CGRectMake(20, 35, 70, 70);
                    imageJuri.layer.cornerRadius = 35;
                }
                [viewCell addSubview:imageJuri];
                
                //Заголовок (фамилия участника жюри)----------
                UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 200, 15)];
                if (isiPhone5) {
                    titleLabel.frame = CGRectMake(110, 10, 200, 15);
                }
                titleLabel.text = [dictJuri objectForKey:@"title"];
                titleLabel.textColor = [UIColor colorWithHexString:COLORBLUETEXT];
                titleLabel.font = [UIFont fontWithName:FONTBOND size:14];
                [viewCell addSubview:titleLabel];
                
                //Подзаголовок (Имя Отчество участника жюри)--
                UILabel * subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 25, 200, 15)];
                if (isiPhone5) {
                    subTitleLabel.frame = CGRectMake(110, 25, 200, 15);
                }
                subTitleLabel.text = [dictJuri objectForKey:@"subTitle"];
                subTitleLabel.textColor = [UIColor colorWithHexString:COLORBLUETEXT];
                subTitleLabel.font = [UIFont fontWithName:FONTREGULAR size:14];
                [viewCell addSubview:subTitleLabel];
                
                //Описание участника жюри---------------------
                UILabel * juriLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 35, 230, 115)];
                if (isiPhone5) {
                    juriLabel.frame = CGRectMake(110, 35, 200, 115);
                }
                juriLabel.text = [dictJuri objectForKey:@"text"];
                juriLabel.numberOfLines = 0;
                juriLabel.textColor = [UIColor colorWithHexString:@"474646"];
                juriLabel.font = [UIFont fontWithName:FONTLITE size:11];
                [viewCell addSubview:juriLabel];
                
                //Разделитель ячеек---------------------------
                UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(30, viewCell.frame.size.height - 1, viewCell.frame.size.width - 60, 1)];
                borderView.backgroundColor = [UIColor colorWithHexString:@"d3d1d1"];
                [viewCell addSubview:borderView];
                
                if (i == 5) {
                    borderView.alpha = 0.f;
                }
            }
            mainScrollView.contentSize = CGSizeMake(0, 60 + 150 * 6);
    }
    return self;
}
@end

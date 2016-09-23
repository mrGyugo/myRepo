//
//  ViewNotification.m
//  PsychologistIOS
//
//  Created by Виктор Мишустин on 19.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "ViewNotification.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation ViewNotification
{
    bool isBool;
}

- (instancetype)initWithView: (UIView*) view andIDDel: (id) object
               andTitleLabel: (NSString*) title andText: (NSString*) text
{
    self = [super init];
    if (self) {
        
        isBool = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upNotificationView) name:NOTIFICATION_UP_VIEW_NOTIFICATION object:nil];
        
        //Всплывающее вью нотификации-------------------------------------
        self.frame = CGRectMake(20, view.frame.size.height - 90, view.frame.size.width - 40, 80);
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.f;
        
        UIImageView * imageViewNotification = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imageViewNotification.userInteractionEnabled = YES;
        imageViewNotification.image = [UIImage imageNamed:@"notificationAlert.png"];
        [self addSubview:imageViewNotification];
        
        UIButton * buttonSend = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSend.frame = CGRectMake(imageViewNotification.frame.size.width - 90, 0, 80, 80);
        [buttonSend setTitle:@"Перейти" forState:UIControlStateNormal];
        [buttonSend setTitleColor:[UIColor colorWithHexString:@"8a8989"] forState:UIControlStateNormal];
        buttonSend.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:11];
        [buttonSend addTarget:object action:@selector(pushNotificationWithNotification) forControlEvents:UIControlEventTouchUpInside];
        [imageViewNotification addSubview:buttonSend];
        
        UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(buttonSend.frame.origin.x - 1, 10, 1, 60)];
        viewBorder.backgroundColor = [UIColor blackColor];
        [self addSubview:viewBorder];
        
        UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, viewBorder.frame.origin.x - 10, 20)];
        labelText.text = text;
        labelText.textColor = [UIColor colorWithHexString:@"8a8989"];
        labelText.font = [UIFont fontWithName:FONTREGULAR size:11];
        [self addSubview:labelText];
        
        UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, viewBorder.frame.origin.x - 10, 20)];
        labelTitle.text = title;
        labelTitle.textColor = [UIColor colorWithHexString:@"8a8989"];
        labelTitle.font = [UIFont fontWithName:FONTBOND size:11];
        [self addSubview:labelTitle];

    }
    return self;
}

- (void) upNotificationView {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(backAnimation) withObject:nil afterDelay:5];
    }];
}

- (void) backAnimation
{
        [UIView animateWithDuration:0.3 animations:^{
//            self.alpha = 0.f;
        } completion:^(BOOL finished) {
        }];
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

//
//  SettingsView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 19/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SettingsView.h"
#import "CustomView.h"
#import "CustomLabels.h"
#import "InputTextView.h"
#import "Macros.h"
#import "UIColor+HexColor.h"
#import "MBSwitch.h"

@interface SettingsView ()

@property (strong, nonatomic) MBSwitch * swithPush;

@end

@implementation SettingsView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.width - 64);
        
        NSArray * arrayPlaysHolders = [NSArray arrayWithObjects:@"Старый пароль", @"Новый пароль", @"Повторите пароль", nil];
        
        CustomLabels * labelPush = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:40
                                                                             andColor:COLORTEXTORANGE andText:@"Получать Push уведоления" andTextSize:14];
        [self addSubview:labelPush];
        
        _swithPush = [[MBSwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 80, 35, 45, 23)];
        _swithPush.onTintColor = [UIColor lightGrayColor];
        _swithPush.offTintColor = [UIColor whiteColor];
        _swithPush.thumbTintColor = [UIColor colorWithHexString:COLORORANGE];
        [_swithPush addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventValueChanged];

        [self addSubview:_swithPush];
        
        for (int i = 0; i < 3; i ++) {
            InputTextView * inputText = [[InputTextView alloc] initCustonTextViewWithRect:CGRectMake(20, 100 + 45 * i, self.frame.size.width - 40, 30) andTextPlaceHolder:[arrayPlaysHolders objectAtIndex:i] andCornerRadius:5.f andView:self fonColor:@"ffffff" andTextColor:@"9a9a99"];
            if (isiPhone4s) {
                inputText.height = 75 + 45 * i;
            }
            [self addSubview:inputText];
            }
        
        UIButton * buttonChangePussword = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonChangePussword.frame = CGRectMake(20, 235, self.frame.size.width - 40, 30);
        [buttonChangePussword setTitle:@"Сменить пароль" forState:UIControlStateNormal];
        [buttonChangePussword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonChangePussword.backgroundColor = [UIColor colorWithHexString:COLORORANGE];
        buttonChangePussword.layer.cornerRadius = 5.f;
        [buttonChangePussword addTarget:self action:@selector(buttonChangePusswordAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonChangePussword];

        
    }
    return self;
    
}

#pragma mark - Action Methods

- (void) pushAction
{
    if (_swithPush.on) {
        NSLog(@"Push ON");
    } else {
        NSLog(@"Push OFF");
    }
}

- (void) buttonChangePusswordAction
{
    NSLog(@"buttonChangePusswordAction");
}

@end


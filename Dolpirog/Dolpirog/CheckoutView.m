//
//  CheckoutView.m
//  FlowersOnline
//
//  Created by Viktor on 20.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CheckoutView.h"
#import "InputTextView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation CheckoutView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        
        NSArray * arrayPlaceHolder = [NSArray arrayWithObjects:
                                      @"Имя получателя", @"Телефон получателя",
                                      @"Email получателя", @"Адрес получателя",
                                      @"Комментарий к заказу", nil];
        
        for (int i = 0; i < arrayPlaceHolder.count; i++) {
            InputTextView * inputText = [[InputTextView alloc] initCheckoutWithView:self PointY:80 + 50 * i andTextPlaceHolder:[arrayPlaceHolder objectAtIndex:i]];
            inputText.tag = 20 + i;
            if (isiPhone5) {
                inputText.height = 40 + 50 * i;
            } else if (isiPhone4s) {
                inputText.height = 15 + 38 * i;
            }
            inputText.layer.borderColor = [UIColor colorWithHexString:COLORBROWN].CGColor;
            inputText.layer.cornerRadius = 5.f;
            inputText.layer.borderWidth = 2.f;
            [self addSubview:inputText];
        }


        //Оформить заказ--------------------------------------
        UIButton * buttonCheckout = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonCheckout.frame = CGRectMake(20, self.frame.size.height - 100, self.frame.size.width - 40, 40);
        buttonCheckout.backgroundColor = [UIColor colorWithHexString:COLORORANGE];
        [buttonCheckout setTitle:@"Оформить" forState:UIControlStateNormal];
        buttonCheckout.layer.cornerRadius = 5.f;
        [buttonCheckout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonCheckout.titleLabel.font = [UIFont fontWithName:FONTBOND size:20];
        [buttonCheckout addTarget:self action:@selector(buttonCheckoutAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCheckout];
        
        
    }
    return self;
}

#pragma mark - Action Methods

- (void) buttonCheckoutAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CHECKOUT_VIEW_PUSH_ORDER_ACCEPTED_CONTROLLER object:nil];
}

@end

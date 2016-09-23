//
//  InputTextToView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 21/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "InputTextToView.h"
#import "CustomTextView.h"
#import "Macros.h"

@interface InputTextToView () <UITextViewDelegate>

@property (strong, nonatomic) CustomTextView * mainTextView;
@property (strong, nonatomic) UILabel * placeHolderLabel;

@end

@implementation InputTextToView

- (instancetype)initWithTextViewFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        _mainTextView = [[CustomTextView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _mainTextView.delegate = self;
        _mainTextView.isBool = NO;
        _mainTextView.font = [UIFont fontWithName:FONTREGULAR size:16];
        [self addSubview:_mainTextView];
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 7, 200, 20)];
        _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        _placeHolderLabel.font = _mainTextView.font;
        [_mainTextView addSubview:_placeHolderLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationMethod) name:UITextViewTextDidChangeNotification object:nil];
        
        
    }
    return self;
}

- (void) setPlaceholder:(NSString *)placeholder
{
    _placeHolderLabel.text = placeholder;
}
- (void) setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeHolderLabel.textColor = placeholderColor;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) animationMethod
{
    if (_mainTextView.text.length != 0) {
        if (!_mainTextView.isBool) {
            [UIView animateWithDuration:0.2 animations:^{
                _placeHolderLabel.alpha = 0.f;
                
                CGRect rect = _placeHolderLabel.frame;
                rect.origin.x += 100;
                _placeHolderLabel.frame = rect;
            }];
            _mainTextView.isBool = YES;
        }
    } else if (_mainTextView.text.length == 0) {
        if (_mainTextView.isBool) {
            [UIView animateWithDuration:0.2 animations:^{
                _placeHolderLabel.alpha = 1.f;
                
                CGRect rect = _placeHolderLabel.frame;
                rect.origin.x -= 100;
                _placeHolderLabel.frame = rect;
            }];
            _mainTextView.isBool = NO;
        }
    }

}

@end

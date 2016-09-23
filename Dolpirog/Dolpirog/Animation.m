//
//  Animation.m
//  Lesson1
//
//  Created by Viktor on 12.09.15.
//  Copyright (c) 2015 Viktor. All rights reserved.
//

#import "Animation.h"

@implementation Animation
//Самый простой метод анимации--------------------------------------------
+ (void)anitetionView:(UIView*)view withColor:(UIColor*)color
{

    [UIView animateWithDuration:0.3f
                     animations:^{

                         view.backgroundColor = color;

                     }];
}
//Второй метод анимации----------------------------------------------------
+ (void)animateTextInLabel:(UILabel*)label withText:(NSString*)text
{

    CATransition* animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    animation.duration = 1.3;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:
                                                            kCAMediaTimingFunctionEaseInEaseOut]];

    [label.layer addAnimation:animation forKey:nil];

    label.text = text;
}

//Изменение frame-------------------------------------------------------------

+ (void)animateFrameView:(UIView*)view withFrame:(CGRect)rect
{
    //Добавление динамического движения (пружинкой)
    [UIView animateWithDuration:2.3f
        delay:0.0
        usingSpringWithDamping:0.08f
        initialSpringVelocity:2.3
        options:0
        animations:^{
            view.frame = rect;
        }
        completion:^(BOOL finished){

        }];

    //
    //    [UIView animateWithDuration:2.3 animations:^{
    //        view.frame = rect;
    //    }];
    //
}

//Общий метод анимации----------------------------------------------------------
+ (void)animateTransformView:(UIView*)view withScale:(CGFloat)scale move_X:(CGFloat)moveX move_Y:(CGFloat)moveY alpha:(CGFloat)alpha delay:(CGFloat)delay
{

    [UIView animateWithDuration:0.3f
        delay:0.f
        usingSpringWithDamping:40.0f
        initialSpringVelocity:0.0f
        options:0.f
        animations:^{

            CGFloat transformX = 0.f;
            CGFloat transformY = 0.f;
            CGFloat transformScale = 0.f;

            transformX = moveX;
            transformY = moveY;
            transformScale = scale;

            CGAffineTransform scaleT = CGAffineTransformMakeScale(scale, scale);
            CGAffineTransform trans = CGAffineTransformMakeTranslation(transformX,
                                                                       transformY);
            CGAffineTransform resultTransform = CGAffineTransformConcat(trans, scaleT);

            view.transform = resultTransform;
            view.alpha = alpha;

        }
        completion:^(BOOL finished){

        }];
}

+ (void) animationTestView:(UIView*)view move_Y: (CGFloat)moveY
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = view.frame;
        rect.origin.y = rect.origin.y + moveY;
        view.frame = rect;
        
    }];
}


//Интересная реализация анимации-------------------------------------------------------

+ (void) animationImageView: (UIImageView*) imageView image: (UIImage*) image {
    
     [UIView transitionWithView:imageView
                       duration:1.3f
                        options:UIViewAnimationOptionTransitionCurlDown
                     animations:^{
                         imageView.image = image;
                     }
                     completion:NULL];
    
}










@end

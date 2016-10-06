//
//  ViewController.m
//  TouchesWork
//
//  Created by Виктор Мишустин on 04.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView * dragginView;

@property (assign, nonatomic) CGPoint touchOffcet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i = 0; i < 8; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10 + 110 * i, 100, 100, 100)];
        view.backgroundColor = [self randomCollor];
         [self.view addSubview:view];
        
    }

//    self.testView = view;
//    self.view.multipleTouchEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Touches


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesBegan"];
    
    UITouch * touch = [touches anyObject];
    
    CGPoint pointOnMainView = [touch locationInView:self.view];
    
    UIView * view = [self.view hitTest:pointOnMainView withEvent:event];
    
    if (![view isEqual:self.view]) {
        self.dragginView = view;
        
        [self.view bringSubviewToFront:self.dragginView];
        
        CGPoint touchPoint = [touch locationInView:self.dragginView];
        
        self.touchOffcet = CGPointMake(CGRectGetMidX(self.dragginView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.dragginView.bounds) - touchPoint.y);
        
        [self.dragginView.layer removeAllAnimations]; //Удаление всех анимаций
        
        [UIView animateWithDuration:0.3 animations:^{
            self.dragginView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            self.dragginView.alpha = 0.3f;
        }];
        
    } else {
        self.dragginView = nil;
    }
    

    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesMoved"];
    
    if (self.dragginView) {
        
        UITouch * touch = [touches anyObject];
        
        CGPoint pointOnMainView = [touch locationInView:self.view];
        CGPoint correction = CGPointMake(pointOnMainView.x + self.touchOffcet.x,
                                         pointOnMainView.y + self.touchOffcet.y);
        
        self.dragginView.center = correction;
    }
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesEnded"];
    [self cancelAnimation];
  
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesCancelled"];
    [self cancelAnimation];
    
}

#pragma mark - Other

- (void) logTouches: (NSSet<UITouch *> *) touches withMethod: (NSString*) methodName {
    
    NSMutableString * string = [NSMutableString stringWithString:methodName];
    for (UITouch * touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        [string appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    
    
    NSLog(@"%@", string);
 
}

- (void) cancelAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.dragginView.transform = CGAffineTransformMakeScale(1.f, 1.f);
        self.dragginView.alpha = 1.f;
    }];
    
    self.dragginView = nil;
}

- (CGFloat) randomFromZeroToOne {
    return (float)(arc4random() % 256) / 255;
}

- (UIColor*) randomCollor {
    CGFloat r = [self randomFromZeroToOne];
    CGFloat g = [self randomFromZeroToOne];
    CGFloat b = [self randomFromZeroToOne];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}


@end

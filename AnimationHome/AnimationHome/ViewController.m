//
//  ViewController.m
//  AnimationHome
//
//  Created by Виктор Мишустин on 01.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray * arrayView;
@property (assign, nonatomic) NSInteger identifierNumber;
@property (strong, nonatomic) NSMutableArray * arrayViewBox;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.identifierNumber = 0;
    self.arrayView = [NSMutableArray array];
    self.arrayViewBox = [NSMutableArray array];

    
    for (int i = 0; i < 4; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(200.f, 260.f + 180 * i, 150, 150)];
        view.backgroundColor = [self randomColor];
        [self.view addSubview:view];
        [self.arrayView addObject:view];

    }
    
    for (int i = 1; i < 5; i++) {
        UIView * boxForView = [self createViewForBoxWithParams:i];
        boxForView.tag = i;
        boxForView.backgroundColor = [self colorForBoxWithIdentifier:i - 1];
        [self.view addSubview:boxForView];
        [self.arrayViewBox addObject:boxForView];
    }

}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    for (int i = 0; i < 4; i++) {
        UIView * view = [self.arrayView objectAtIndex:i];
        [self animationViewWith:view andAnimationOptions: i << 16];
    }
    
    [self animationMethodForBox];
}


#pragma mark - Views

- (UIView*) createViewForBoxWithParams: (ViewControllerParamsBoxView) params {
    
    CGPoint pointView;
    if (params == ViewControllerParamsBoxViewUpLeft) {
        pointView = CGPointMake(0, 0);
    } else if (params == ViewControllerParamsBoxViewUpWrite) {
        pointView = CGPointMake(CGRectGetWidth(self.view.bounds) - 150, 0);
    } else if (params == ViewControllerParamsBoxViewDownWrite) {
        pointView = CGPointMake(CGRectGetWidth(self.view.bounds) - 150, CGRectGetHeight(self.view.bounds) - 150);
    } else if (params == ViewControllerParamsBoxViewDownLeft) {
        pointView = CGPointMake(0, CGRectGetHeight(self.view.bounds) - 150);
    }
    UIView * viewForBox = [[UIView alloc] initWithFrame:CGRectMake(pointView.x, pointView.y, 150, 150)];
    viewForBox.backgroundColor = [UIColor blueColor];
    
    return viewForBox;
}


#pragma mark - Animations

- (void) animationMethodForBox {
    
    
    [UIView animateWithDuration:3 animations:^{
        if (arc4random() % 2) {
            for (UIView * view in self.arrayViewBox) {
                [self moveDownWithView:view];
            }
        } else {
            for (UIView * view in self.arrayViewBox) {
                [self moveToWithView:view];
            }
        }
    } completion:^(BOOL finished) {
        [self animationMethodForBox];
    }];
    
 
}

- (void) animationViewWith: (UIView*) view andAnimationOptions: (UIViewAnimationOptions) viewAnimationOptions {
    [UIView animateWithDuration:3
                          delay:0
                        options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | viewAnimationOptions
                     animations:^{
                         view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(view.frame) - 400, 0);
                         view.backgroundColor = [self randomColor];
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"completion %@", finished ? @"YES" : @"NO");
                     }];
}


#pragma mark - Other



- (UIColor*) colorForBoxWithIdentifier: (NSInteger) identifier {
    
    NSArray * arrayColors = [NSArray arrayWithObjects:
                             [UIColor greenColor],
                             [UIColor redColor],
                             [UIColor yellowColor],
                             [UIColor blueColor], nil];
    
    return [arrayColors objectAtIndex:identifier];
    
    
}

- (CGFloat) randomFromZeroToOne {
    return (float)(arc4random() % 256) / 255;
}

- (UIColor *) randomColor {
    CGFloat r = [self randomFromZeroToOne];
    CGFloat g = [self randomFromZeroToOne];
    CGFloat b = [self randomFromZeroToOne];
    
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) moveToWithView: (UIView*) view {
    if (view.frame.origin.x == 0 && view.frame.origin.y == 0) {
        view.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 150, 0, 150, 150);
        view.backgroundColor = [self colorForBoxWithIdentifier:1];
    } else if (view.frame.origin.x > 0 && view.frame.origin.y == 0) {
        view.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 150, CGRectGetHeight(self.view.bounds) - 150, 150, 150);
        view.backgroundColor = [self colorForBoxWithIdentifier:2];
    } else if (view.frame.origin.x > 0 && view.frame.origin.y > 0) {
        view.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 150, 150, 150);
        view.backgroundColor = [self colorForBoxWithIdentifier:3];
    } else {
        view.frame = CGRectMake(0, 0, 150, 150);
        view.backgroundColor = [self colorForBoxWithIdentifier:0];
    }
}

- (void) moveDownWithView: (UIView*) view {
    if (view.frame.origin.x == 0 && view.frame.origin.y == 0) {
        view.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 150, 150, 150);
        view.backgroundColor = [self colorForBoxWithIdentifier:3];
    } else if (view.frame.origin.x > 0 && view.frame.origin.y == 0) {
        view.frame = CGRectMake(0, 0, 150, 150);
        view.backgroundColor = [self colorForBoxWithIdentifier:0];
    } else if (view.frame.origin.x > 0 && view.frame.origin.y > 0) {
        view.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 150, 0, 150, 150);
        view.backgroundColor = [self colorForBoxWithIdentifier:1];
    } else {
        view.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 150, CGRectGetHeight(self.view.bounds) - 150, 150, 150);
        view.backgroundColor = [self colorForBoxWithIdentifier:2];
    }
}


@end

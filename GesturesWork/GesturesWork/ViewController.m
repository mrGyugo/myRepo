//
//  ViewController.m
//  GesturesWork
//
//  Created by Виктор Мишустин on 07.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView * testView;

@property (assign, nonatomic) CGFloat testViewScale;
@property (assign, nonatomic) CGFloat testViewRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 50,
                                                             CGRectGetMidY(self.view.bounds) - 50,
                                                             100, 100)];
    
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                             UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    self.testView = view;
    
    UITapGestureRecognizer * tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer * doubleTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];
    
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    UITapGestureRecognizer * doubleTapDoubleTouchGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleDoubleTapDoubleTouch:)];
    doubleTapDoubleTouchGesture.numberOfTapsRequired = 2;
    doubleTapDoubleTouchGesture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapDoubleTouchGesture];
    
    UIPinchGestureRecognizer * pinchGesture =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer * rotationGesture =
    [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
    
    UIPanGestureRecognizer * panGesture =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handlePan:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    
    UISwipeGestureRecognizer * verticalSwipeGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleVerticalSwipe:)];
    verticalSwipeGesture.direction = UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionUp;
    verticalSwipeGesture.delegate = self;
    [self.view addGestureRecognizer:verticalSwipeGesture];
    
    UISwipeGestureRecognizer * horizontalSwipeGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleHorizontalSwipe:)];
    horizontalSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    verticalSwipeGesture.delegate = self;
    [self.view addGestureRecognizer:horizontalSwipeGesture];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gestures

- (void) handleTap:(UITapGestureRecognizer*) tapGesture {
    
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    [UIView animateWithDuration:0.3 animations:^{
        self.testView.backgroundColor = [self randomColor];
    }];
    

}

- (void) handleDoubleTap: (UITapGestureRecognizer*) tapGesture {
    
    NSLog(@"Double Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    [UIView animateWithDuration:0.3 animations:^{
        self.testView.transform = [self changeScaleWithView:self.testView andPointe:1.2];
    }];
    self.testViewScale = 1.2;
    
}

- (void) handleDoubleTapDoubleTouch: (UITapGestureRecognizer*) tapGesture {
    NSLog(@"Double Tap Double Touch: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    [UIView animateWithDuration:0.3 animations:^{
        self.testView.transform = [self changeScaleWithView:self.testView andPointe:0.8];
    }];
    self.testViewScale = 0.8;
    
}

- (void) handlePinch: (UIPinchGestureRecognizer*) pinchGesture {
    NSLog(@"handlePinch %1.3f", pinchGesture.scale);
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewScale = 1;
    }
    CGFloat delta = 1.0f + pinchGesture.scale - self.testViewScale;
    self.testView.transform = [self changeScaleWithView:self.testView andPointe:delta];
    self.testViewScale = pinchGesture.scale;
}

- (void) handleRotation: (UIRotationGestureRecognizer*) rotationGesture {
    
    NSLog(@"handleRotation %1.3f", rotationGesture.rotation);
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewScale = 0;
    }
    CGFloat newRotation = rotationGesture.rotation - self.testViewRotation;
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.testView.transform = newTransform;
    self.testViewRotation = rotationGesture.rotation;
}

- (void) handlePan: (UIPanGestureRecognizer*) panGesture {
    NSLog(@"handlePan");
    self.testView.center = [panGesture locationInView:self.view];
}

- (void) handleVerticalSwipe: (UISwipeGestureRecognizer*) verticalSwipeGesture {
    NSLog(@"handleVerticalSwipe");    
}

- (void) handleHorizontalSwipe: (UISwipeGestureRecognizer*) horizontalSwipeGesture {    
    NSLog(@"handleHorizontalSwipe");
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
            shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
            shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
           [otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]];
    
}


#pragma mark - Help Methods

- (UIColor*) randomColor {
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (CGAffineTransform) changeScaleWithView: (UIView *) view andPointe: (CGFloat) pointe {
    
    CGAffineTransform currentTransform = view.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, pointe, pointe);
    
    return newTransform;
    
}




@end

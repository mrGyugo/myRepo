//
//  ViewController.m
//  AnimationsTest
//
//  Created by Виктор Мишустин on 30.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView * viewMain;
@property (strong, nonatomic) NSMutableArray * array;

//@property (strong, nonatomic) UIImageView * imageTestView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [NSMutableArray array];
    
    UIImage * image1 = [UIImage imageNamed:@"1.jpg"];
    UIImage * image2 = [UIImage imageNamed:@"2.jpg"];
    UIImage * image3 = [UIImage imageNamed:@"3.jpg"];
    UIImage * image4 = [UIImage imageNamed:@"4.jpg"];
    UIImage * image5 = [UIImage imageNamed:@"5.jpg"];
    UIImage * image6 = [UIImage imageNamed:@"6.jpg"];
    UIImage * image7 = [UIImage imageNamed:@"7.jpg"];
    UIImage * image8 = [UIImage imageNamed:@"8.jpg"];
    UIImage * image9 = [UIImage imageNamed:@"9.jpg"];
    UIImage * image10 = [UIImage imageNamed:@"10.jpg"];
    
    NSArray *arrayImages = [NSArray arrayWithObjects:image1, image2, image3, image4, image5, image6, image7, image8, image9, image10, nil];
    
    for (int i = 0; i < 10; i++) {
        UIImageView *  imageTestView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        imageTestView.backgroundColor = [UIColor greenColor];
        
        
        
        imageTestView.animationImages = arrayImages;
        imageTestView.animationDuration = 1;
        [imageTestView startAnimating];
        
        [self.view addSubview:imageTestView];
        
        [self.array addObject:imageTestView];
    }
    

    

    
}

- (void) moveView: (UIView*) view {
    
    CGRect rect = self.view.bounds;
    rect = CGRectInset(rect, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    
    
    CGFloat x = arc4random() % (int)CGRectGetWidth(rect) + CGRectGetMinX(rect);
    CGFloat y = arc4random() % (int)CGRectGetHeight(rect) + CGRectGetMinY(rect);
    
    CGFloat s = (float)(arc4random() % 151) / 100 + 0.5f;
    
    
    CGFloat r = (float)(arc4random() % (int)(M_PI * 2 * 10000) / 10000 - M_PI);
    
    CGFloat d = (float)(arc4random() % (20001) / 10000 + 2);
    
    
    [UIView animateWithDuration:d
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         view.center = CGPointMake(x, y);
                         view.backgroundColor = [self randomCollor];
                         
//                         CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
//                         CGAffineTransform rotation = CGAffineTransformMakeRotation(r);
//                         
//                         
//                         CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
                         
                         
//                         view.transform = transform;
                         
                         
                         
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"animation finish! %d", finished);
                         NSLog(@"\nview frame = %@\nview bounds %@", NSStringFromCGRect(view.frame), NSStringFromCGRect(view.bounds));
                         
                         UIView * __weak v = view;
                         
                         [self moveView:v];
                     }];
    
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

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    for (UIImageView * imageView in self.array) {
         [self moveView:imageView];
    }

    
    
   
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

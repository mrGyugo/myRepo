//
//  ViewController.m
//  IBOutlets
//
//  Created by Виктор Мишустин on 29.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *CollectionStick;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self stayColorWithdColor:[self randomCollor]];
    } else if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
      [self stayColorWithdColor:[self randomCollor]];
    } else if (fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
      [self stayColorWithdColor:[self randomCollor]];
    } else {
        [self stayColorWithdColor:[self randomCollor]];
    }
}

- (void) stayColorWithdColor: (UIColor*) color {
    for (UIView * view in self.CollectionStick) {
        view.backgroundColor = color;
    }
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

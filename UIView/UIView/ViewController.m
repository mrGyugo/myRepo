//
//  ViewController.m
//  UIView
//
//  Created by Виктор Мишустин on 26.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ViewController.h"
#import "TestPatient.h"

@interface ViewController ()

@property (weak, nonatomic) UIView * testView;
@property (strong, nonatomic) NSMutableArray * arrayView;
@property (strong, nonatomic) UIView * box;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.arrayView = [NSMutableArray array];

    
    self.box = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, CGRectGetWidth(self.view.frame) - 10, CGRectGetWidth(self.view.frame) - 10)];
    self.box.center = self.view.center;
    
    self.box.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.box.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:self.box];
    
    CGFloat sizeBox = CGRectGetWidth(self.box.frame) / 8;
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0 + sizeBox * j, 0 + sizeBox * i, sizeBox, sizeBox)];
            if ((i + j) % 2 == 0) {
                view.backgroundColor = [UIColor blackColor];
                [self.arrayView addObject:view];

            }
            [self.box addSubview:view];
            
            if ([view.backgroundColor isEqual:[UIColor blackColor]] && i < 3) {
                [self createViewWithColor:[UIColor greenColor] andViewCenter:view andSuperView:self.box];
            } else if ([view.backgroundColor isEqual:[UIColor blackColor]] && i > 4) {
                [self createViewWithColor:[UIColor brownColor] andViewCenter:view andSuperView:self.box];
            }
            
            
        }
    }
    


}

- (void) createViewWithColor: (UIColor*) color andViewCenter: (UIView*) viewCenter andSuperView: (UIView*) supView {
    UIView * viewShak = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 20, 20)];
    viewShak.center = viewCenter.center;
    viewShak.backgroundColor = color;
    [supView addSubview:viewShak];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self stayColorWithArray:self.arrayView andColor:[UIColor blueColor]];
    } else if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self stayColorWithArray:self.arrayView andColor:[UIColor blackColor]];
    } else if (fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self stayColorWithArray:self.arrayView andColor:[UIColor redColor]];
    } else {
        [self stayColorWithArray:self.arrayView andColor:[UIColor yellowColor]];
    }
    
    for (UIView * view in self.box.subviews) {
        if (view.frame.size.width == 20) {
            view.backgroundColor = arc4random() % 2 ? [UIColor greenColor] : [UIColor brownColor];
        }
    }

}

- (void) stayColorWithArray: (NSMutableArray*) array andColor: (UIColor*) color {
    for (UIView * view in array) {
        view.backgroundColor = color;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}



@end

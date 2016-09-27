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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 200, 50)];
    view1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8f];
    [self.view addSubview:view1];
    
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(80, 130, 50, 250)];
    view2.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.8f];
    view2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:view2];
    
    TestPatient * test = [[TestPatient alloc] init];
    
    [UIAlertAction actionWithTitle:@"Hello" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}



@end

//
//  Student.m
//  ThraedsHome
//
//  Created by Виктор Мишустин on 23/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)initWithName: (NSString*) name
{
    self = [super init];
    if (self) {
        
        self.name = name;
        
        [self sayNumber:arc4random() % 100];
        
    }
    return self;
}


- (void) sayNumber: (NSInteger) intValue {
    
    NSLog(@"для студента %@ yгадываемое число %ld", self.name, (long)intValue);
    
   __block NSInteger myInt = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"Студент %@ начал считать", self.name);
        
        while (intValue != myInt) {
            myInt = arc4random() % 100;
        }
        NSLog(@"Студент %@ одгадал", self.name);
    });
  
}

- (void) dealloc {
    NSLog(@"Студент Мертв");
}

- (void) resultBlock: (void (^)(Student* studetn)) studentBlcok {
    
}



@end

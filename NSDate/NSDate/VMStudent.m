//
//  VMStudent.m
//  NSDate
//
//  Created by Виктор Мишустин on 28.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "VMStudent.h"

@implementation VMStudent

- (instancetype)initWithDateofBirth: (NSDate*) dateOfBirth
{
    self = [super init];
    if (self) {
        self.dateOfBirth = dateOfBirth;
        [self customNamesWith:self];
        [self customSecondNamesWith:self];

    }
    return self;
}

- (NSString*) description {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM/dd/yyyy"];
    return [NSString stringWithFormat:@"Студент %@ %@ родился %@", self.name, self.lastName, [dateFormatter stringFromDate:self.dateOfBirth]];
}

- (void) customNamesWith: (VMStudent*) student {
    NSArray * arrayNames = [NSArray arrayWithObjects:@"Вова", @"Виктор", @"Володя", @"Владимер", @"Сергей", @"Григорий", @"Дмитрий", @"Федер", nil];
    
    student.name = [arrayNames objectAtIndex:arc4random() % 8];
}

- (void) customSecondNamesWith: (VMStudent*) student {
    NSArray * arraySecondNames = [NSArray arrayWithObjects:@"Петров", @"Сидоров", @"Смирнов", @"Кузнецов", @"Коновалов", @"Железкин", @"Будаев", @"Кожелев", nil];
    
    student.lastName = [arraySecondNames objectAtIndex:arc4random() % 8];
}

@end

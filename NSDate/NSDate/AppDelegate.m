//
//  AppDelegate.m
//  NSDate
//
//  Created by Виктор Мишустин on 28.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AppDelegate.h"
#import "VMStudent.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSDate * startDate;
@property (assign, nonatomic) NSInteger countDay;
@property (strong, nonatomic) NSMutableArray * arrayStudents;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    self.arrayStudents = [[NSMutableArray alloc] init];
//    
//    self.countDay = 0;
//
//    for (int i = 0; i < 30; i ++) {
//        VMStudent * student = [[VMStudent alloc] initWithDateofBirth:[self dateOfBirth]];
//        [self.arrayStudents addObject:student];
//    }
//    
//    self.arrayStudents = [self sortArrayWithArrray:self.arrayStudents];
//    
//    for (VMStudent * student in self.arrayStudents) {
//        NSLog(@"%@", student);
//    }
//    
//    self.startDate = [self startDate];
//    
////    [NSTimer scheduledTimerWithTimeInterval:0.00005f target:self selector:@selector(dayTimer:) userInfo:nil repeats:YES];
//    
//    VMStudent * firstStudent = [self.arrayStudents firstObject];
//    VMStudent * lastStudent = [self.arrayStudents lastObject];
//    
//    NSCalendar * calendar = [NSCalendar currentCalendar];
//    NSDateComponents * components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:firstStudent.dateOfBirth toDate:lastStudent.dateOfBirth options:0];
//    
//    NSLog(@"%@", components);
    
    
    
    
    
    NSCalendar * calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setCalendar:calendar];
    [components setDay:1];
    [components setYear:2016];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM d, yyyy"];
    NSDateFormatter * year = [[NSDateFormatter alloc] init];
    [year setDateFormat:@"yyyy"];
    
    NSDateFormatter * dayWeek = [[NSDateFormatter alloc] init];
    [dayWeek setDateFormat:@"e"];
    
    NSDate * date = [calendar dateFromComponents:components];
    
    NSInteger dayWork = 0;
    
    while ([[year stringFromDate:date] isEqualToString:@"2016"]) {

        components.day += 1;
        date = [calendar dateFromComponents:components];
        
        
        
        if (![[dayWeek stringFromDate:date] isEqualToString:@"7"] && ![[dayWeek stringFromDate:date] isEqualToString:@"1"]) {
            dayWork += 1;
        }
    }
    
    NSLog(@"%d", dayWork);
    
    
    

    
    
    

    
    return YES;
}

- (void) dayTimer: (NSTimer*) timer {
    [self addDayWithDate];
    NSDate * date = [self addDayWithDate];

    
    for (VMStudent * student in self.arrayStudents) {
        
        if ([[self formatWithDate:date] isEqualToString:[self formatWithDate:student.dateOfBirth]]) {
            NSLog(@"У студента %@ %@ день рождения", student.name, student.lastName);
        }
    }

    
    self.countDay += 1;
    
}

- (NSString *) formatWithDate: (NSDate*) date {
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM dd yyyy"];
    NSString * string = [format stringFromDate:date];
    
    return string;
    
}

- (NSDate*) dateOfBirth {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * dateComponents = [[NSDateComponents alloc] init];
    NSInteger startCount = 16;
    
    [dateComponents setYear: -(startCount + arc4random() % 50 - startCount)];
    [dateComponents setMonth:arc4random() % 12];
    [dateComponents setDay:arc4random() % 31];
    
    NSDate * dateOfBirth = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    return dateOfBirth;
}

- (NSDate*) startDate {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear: -50];
    
    
    return [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
}

- (NSMutableArray*) sortArrayWithArrray: (NSMutableArray*) array {
    
    [array sortUsingComparator:^NSComparisonResult(VMStudent * obj1, VMStudent * obj2) {
        return [[obj1 dateOfBirth] compare:[obj2 dateOfBirth]];
    }];
    
    return array;
}

- (NSDate*) addDayWithDate {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay: + self.countDay];
    
    NSDate * dateFin = [calendar dateByAddingComponents:dateComponents toDate:self.startDate options:0];
    
    return dateFin;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

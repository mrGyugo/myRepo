//
//  VMSmart.m
//  RoboWars
//
//  Created by Виктор Мишустин on 26.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "VMSmart.h"
#import "Target.h"

@interface VMSmart ()

@property (strong, nonatomic) NSMutableArray * targets;

@end

@implementation VMSmart

#pragma mark - VSPilotProtocol

- (void) restart {
    
    self.targets = [NSMutableArray array];

    CGRect selfArea = CGRectInset(self.robotRect, -1, -1);
    
    CGFloat minSize = MIN(CGRectGetWidth(self.robotRect), CGRectGetHeight(self.robotRect));
    CGFloat maxSize = MAX(CGRectGetWidth(self.robotRect), CGRectGetHeight(self.robotRect));
    
    NSArray * verticalTargets = [self arrayOfTargetsWithSize:CGSizeMake(minSize, maxSize) andExcludingRect:selfArea inFieldWithSize:self.fieldSize];
    
    NSArray * horizontalTargets = [self arrayOfTargetsWithSize:CGSizeMake(maxSize , minSize) andExcludingRect:selfArea inFieldWithSize:self.fieldSize];
    
    [self.targets addObjectsFromArray:verticalTargets];
    [self.targets addObjectsFromArray:horizontalTargets];
}

- (NSString*) robotName {

    
    return @"Smart";
    
}

- (CGPoint) fire {
    
    NSArray * minHealthTargets = [self lessHealthTargets];
    
    NSArray * coordinateToFier = [self bestHitChanceCoordinatesFromTargets:minHealthTargets];
    
    if ([coordinateToFier count] == 0) {
        NSLog(@"Cannot shoot");
        return CGPointMake(- 10.f, - 10.f);
    }
    
    NSString * striingCoord = [coordinateToFier firstObject];
    return CGPointFromString(striingCoord);

}

- (void) shotFrom:(id<VSPilotProtocol>) robot withCoordinate:(CGPoint) coordinate andResult:(VSShotResult) result {
    
    if (result == VSShotResultMiss) {
        [self missAtCordinate:coordinate andArrayTargets:self.targets];
    } else {
        [self hitAtCordinate:coordinate andArrayTargets:self.targets];
        
    }
    
    
}



- (NSString*) victoryPhrase {
    return @"I am the winner!";
}
- (NSString*) defeatPhrase {
    return @"Goodbye guys!";
}


#pragma mark - Other

- (NSArray*) arrayOfTargetsWithSize:(CGSize) size
                   andExcludingRect: (CGRect) excludingRect
                    inFieldWithSize: (CGSize) fildSize {
    
    NSMutableArray * array = [NSMutableArray array];
    
    for (int i = 0; i <= fildSize.width - size.width; i++) {
        for (int j = 0; j <= fildSize.height - size.height; j++) {
            CGRect rect = CGRectMake(i, j, size.width, size.height);
            if (!CGRectIntersectsRect(excludingRect, rect)) {
                Target * target = [[Target alloc] initWithRect:rect];
                [array addObject:target];
            }
        }
    }
    return array;
}

- (void) missAtCordinate: (CGPoint) cordinate andArrayTargets: (NSMutableArray*) arrayTargets  {
    for (int i = (int)arrayTargets.count - 1; i >= 0; i--) {
        
        Target * target = [arrayTargets objectAtIndex:i];
        
        if (CGRectContainsPoint(target.rect, cordinate)) {
            [self.targets removeObject:target];
        }
    }
}

- (void) hitAtCordinate: (CGPoint) cordinate andArrayTargets: (NSMutableArray*) arrayTargets {
    
    NSString * hp = NSStringFromCGPoint(cordinate);
    
    CGRect desctoidRect = CGRectZero;
    
    for (int i = (int)arrayTargets.count - 1; i >= 0; i--) {
        
        Target * target = [arrayTargets objectAtIndex:i];
        
        if ([target.health containsObject:hp]) {
            [target.health removeObject:hp];
            
            if (target.health.count == 0) {
                desctoidRect = target.rect;
                [self.targets removeObjectAtIndex:i];
            }
        }
    }
    
    if (!CGRectIsEmpty(desctoidRect)) {
        [self targetDestroidAtRect:desctoidRect];
    }
    
}


- (void) targetDestroidAtRect: (CGRect) rect {
    
    rect = CGRectInset(rect, -1, -1);
    
    CGRect fieldRect = CGRectZero;
    fieldRect.size = self.fieldSize;
    
    for (int i = CGRectGetMinX(rect); i < CGRectGetMaxX(rect); i++) {
        for (int j = CGRectGetMinY(rect); j < CGRectGetMaxY(rect); j++) {
            CGPoint pointTarget = CGPointMake(i, j);
            
            if (CGRectContainsPoint(fieldRect, pointTarget)) {
                 [self missAtCordinate:pointTarget andArrayTargets:self.targets];
            }
        }
    }
}

- (NSArray*) lessHealthTargets {
    if (self.targets.count <= 1) {
        return self.targets;
    }
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.targets];
    
    [array sortUsingComparator:^NSComparisonResult(Target * obj1, Target * obj2) {
        
        if ([obj1.health count] < [obj1.health count]) {
            return NSOrderedAscending;
        } else if ([obj1.health count] > [obj1.health count]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    NSMutableArray * resultArray = [NSMutableArray array];
    
    NSInteger minHealth = NSIntegerMax;
    
    for (Target * target in array) {
        if ([target.health count] <= minHealth) {
            minHealth = [target.health count];
            
            [resultArray addObject:target];
        } else {
            break;
        }
    }
    
    return resultArray;
}

- (NSArray*) bestHitChanceCoordinatesFromTargets: (NSArray*) targets {
    
    if ([targets count] == 0) {
        return nil;
    } else if ([targets count] == 1) {
        Target * target = [targets firstObject];
        return [target.health allObjects];
    } else {
        
    }
    
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    for (Target* target in targets) {
        NSArray * coords = [target.health allObjects];
        
        for (NSString * key in coords) {
            NSNumber * number = [dictionary objectForKey:key];
            if (!number) {
                number = [NSNumber numberWithInt:1];
            } else {
                NSInteger curent = [number integerValue];
                number = [NSNumber numberWithInt:curent + 1];
            }
            [dictionary setObject:number forKey:key];
        }
    }
    
    
    if ([dictionary count] == 0) {
        return nil;
    } else if ([dictionary count] == 1) {
        return [dictionary allKeys];
    }
    
    
    NSArray * sortedCoords = [dictionary keysSortedByValueUsingComparator:^NSComparisonResult(NSNumber * obj1, NSNumber * obj2) {
        
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray * resultArray = [NSMutableArray array];
    
    NSInteger maxNumber = 0;
    
    for (int i = [sortedCoords count] - 1; i >= 0; i--) {
        
        NSString * key = [sortedCoords objectAtIndex:i];
        NSNumber * number = [dictionary objectForKey:key];
        
        if ([number integerValue] >= maxNumber) {
            maxNumber = [number integerValue];
            [resultArray addObject:key];
        } else {
            break;
        }
    }
    
    return resultArray;
}




























@end

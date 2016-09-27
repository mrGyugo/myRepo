//
//  VSpilotProtocol.h
//  VSRoboWars
//
//  Created by Vladimir Shorokhov on 9/24/16.
//  Copyright © 2016 Vladimir Shorokhov. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
typedef enum {
    
    VSShotResultMiss,
    VSShotResultHit,
    VSShotResultDestroy
    
} VSShotResult;


@protocol VSPilotProtocol <NSObject>

@required

@property (assign, nonatomic, readwrite) CGRect robotRect;
@property (assign, nonatomic, readwrite) CGSize fieldSize;

- (NSString*) robotName;

- (CGPoint) fire;

- (void) shotFrom:(id<VSPilotProtocol>) robot withCoordinate:(CGPoint) coordinate andResult:(VSShotResult) result;

- (void) restart;

@optional

- (NSString*) victoryPhrase;
- (NSString*) defeatPhrase;

@end

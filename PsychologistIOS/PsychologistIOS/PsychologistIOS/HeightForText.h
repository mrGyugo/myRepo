//
//  HeightForText.h
//  NetWork
//
//  Created by Viktor on 05.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HeightForText : NSObject

- (CGFloat)getHeightForText:(NSString*)text
                   textWith:(CGFloat)textWith
                   withFont: (UIFont *) font;

- (CGFloat) getHeightForImageViewWithTargetWidth: (CGFloat) targetWidth
                                       imageWith:(CGFloat) imageWith
                                     imageHeight:(CGFloat ) imageHeight;

@end

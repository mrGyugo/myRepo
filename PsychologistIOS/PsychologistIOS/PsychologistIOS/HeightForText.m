//
//  HeightForText.m
//  NetWork
//
//  Created by Viktor on 05.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "HeightForText.h"

@implementation HeightForText

- (CGFloat) getHeightForImageViewWithTargetWidth: (CGFloat) targetWidth
                                       imageWith:(CGFloat) imageWith
                                     imageHeight:(CGFloat ) imageHeight {
    
    CGFloat scaleFactor = targetWidth / imageWith;
    CGFloat targetHeight = imageHeight * scaleFactor;
    return targetHeight;
    
}

- (CGFloat)getHeightForText:(NSString*)text textWith:(CGFloat)textWith withFont: (UIFont *) font
{
    
    CGSize constrainedSize = CGSizeMake(textWith, 9999);
    
    NSDictionary* attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font,
                                          NSFontAttributeName,
                                          nil];
    
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc] initWithString:text attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    if (requiredHeight.size.width > textWith) {
        requiredHeight = CGRectMake(0, 0, textWith, requiredHeight.size.height);
    }
    
    return requiredHeight.size.height;
}

@end

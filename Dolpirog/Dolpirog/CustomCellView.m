//
//  CustomCellView.m
//  FlowersOnline
//
//  Created by Viktor on 30.04.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CustomCellView.h"
#import "Macros.h"
#import "UIColor+HexColor.h"

@implementation CustomCellView

- (UIView*) customCellWithTint: (NSString*) tint
                     andImage: (NSString*) image
                      andView: (UIView*) view
{
    UIView * viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 40)];
    viewCell.backgroundColor = [UIColor clearColor];
    
    UILabel * labelTint = [[UILabel alloc] initWithFrame:CGRectMake(70, 2, viewCell.frame.size.width - 60, 40)];
    labelTint.text = tint;
    labelTint.textColor = [UIColor whiteColor];
    labelTint.font = [UIFont fontWithName:FONTBOND size:14];
    [viewCell addSubview:labelTint];
    
    UIImageView * imageMenuCell = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
    imageMenuCell.image = [UIImage imageNamed:image];
    [imageMenuCell sizeThatFits:CGSizeMake(20, 20)];
    [viewCell addSubview:imageMenuCell];
    
    return viewCell;
}

- (UIView*) customCellQuitWithView: (UIView*) view
{
    UIView * customCellQuit = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 100)];
    
    UILabel * labelTint = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, customCellQuit.frame.size.width - 60, 20)];
    labelTint.text = @"ВЫЙТИ";
    labelTint.textColor = [UIColor whiteColor];
    labelTint.font = [UIFont fontWithName:FONTBOND size:14];
    [customCellQuit addSubview:labelTint];
    
    UILabel * labelSubTitnt = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, customCellQuit.frame.size.width - 60, 20)];
    labelSubTitnt.text = @"Анатоле Вассерман";
    labelSubTitnt.textColor = [UIColor colorWithHexString:@"9b9b9b"];
    labelSubTitnt.font = [UIFont fontWithName:FONTREGULAR size:12];
    [customCellQuit addSubview:labelSubTitnt];
    
    UIImageView * imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(190, 25, 50, 50)];
    imagePhoto.image = [UIImage imageNamed:@"Avatar.png"];
    [customCellQuit addSubview:imagePhoto];
    
//    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(20, 0, view.frame.size.width - 100, 0.5f)];
//    viewBorder.backgroundColor = [UIColor colorWithHexString:@"404040"];
//    [customCellQuit addSubview:viewBorder];

    return customCellQuit;
}

@end

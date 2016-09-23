//
//  TextMethodClass.m
//  ITDolgopa
//
//  Created by Кирилл Ковыршин on 04.03.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "TextMethodClass.h"

@implementation TextMethodClass
+(NSString *) stringByStrippingHTML: (NSString*) string {
    NSRange r;
    string =
    [string stringByReplacingOccurrencesOfString:@"<br>"
                                      withString:@"\n"];
    string =
    [string stringByReplacingOccurrencesOfString:@"</em>"
                                      withString:@"\n\n"];
    
    string =
    [string stringByReplacingOccurrencesOfString:@"</h2>"
                                      withString:@"\n\n"];
    
    string =
    [string stringByReplacingOccurrencesOfString:@"&nbsp;"
                                      withString:@" "];
    
    string =
    [string stringByReplacingOccurrencesOfString:@"&ndash;"
                                      withString:@"-"];
    string =
    [string stringByReplacingOccurrencesOfString:@"<p></p>"
                                      withString:@"\n"];
    string =
    [string stringByReplacingOccurrencesOfString:@"<p>"
                                      withString:@""];
    string =
    [string stringByReplacingOccurrencesOfString:@"</p>"
                                      withString:@""];
    string =
    [string stringByReplacingOccurrencesOfString:@"&hellip"
                                      withString:@"..."];
    
    
    
    
    string =
    [string stringByReplacingOccurrencesOfString:@"&ldquo;"
                                      withString:@"\""];
    string =
    [string stringByReplacingOccurrencesOfString:@"&rdquo;"
                                      withString:@"\""];
    string =
    [string stringByReplacingOccurrencesOfString:@"&laquo;"
                                      withString:@"\""];
    string =
    [string stringByReplacingOccurrencesOfString:@"&raquo;"
                                      withString:@"\""];
    
    
    
    
    
    while ((r = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    string = [string stringByReplacingCharactersInRange:r withString:@""];
    return string;
}

@end

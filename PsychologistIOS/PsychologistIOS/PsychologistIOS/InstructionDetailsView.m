//
//  InstructionDetailsView.m
//  PsychologistIOS
//
//  Created by Viktor on 13.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "InstructionDetailsView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation InstructionDetailsView
{
    UIScrollView * mainScrollView;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        //Основной скролл вью------------------------
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        
        //Основной текст----------------------------
        UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, self.frame.size.width - 32, self.frame.size.height - 16)];
        labelText.numberOfLines = 0;
        labelText.text = @"Авторизация в приложении организована через ввод СМС кода.\n\nSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.\n\nNeque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?\n\nQuis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur";
        labelText.textColor = [UIColor colorWithHexString:@"2b2b2a"];
        labelText.font = [UIFont fontWithName:FONTLITE size:20];
        if (isiPhone5) {
            labelText.font = [UIFont fontWithName:FONTLITE size:14];
        }
        [self addSubview:labelText];
    }
    return self;
}

@end

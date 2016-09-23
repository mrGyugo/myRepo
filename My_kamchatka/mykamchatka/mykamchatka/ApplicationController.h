//
//  ApplicationController.h
//  mykamchatka
//
//  Created by Viktor on 26.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationController : UIViewController <UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonMenu;


- (void) getAPIWithFio: (NSString*) fio andEmail: (NSString *) email;

@end

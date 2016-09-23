//
//  MenuController.m
//  PsychologistIOS
//
//  Created by Viktor on 31.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "MenuController.h"
#import "UIColor+HexColor.h"
#import "SWRevealViewController.h"
#import "Macros.h"
#import "NotificationController.h"
#import "AuthDbClass.h"
#import "SingleTone.h"

@interface MenuController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;



@end

@implementation MenuController
{
    UILabel * labelName;
    NSArray * menu;
    NSArray * arrayImage;
}

- (void) viewDidLoad
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkName:) name:NOTIFICATION_CHECK_NAME_LABEL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeName:) name:NOTIFICATION_CHANGE_NAME_LABEL object:nil];
    
    self.mainTableView.backgroundColor = nil;
    self.mainTableView.scrollEnabled = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"3d3d3d"];    
    
    menu = [NSArray arrayWithObjects:@"Cell1", @"Cell2", @"Cell3", @"Cell4", @"Cell5",
                                     @"Cell6", @"Cell7", @"Cell8", @"Cell9", @"Cell10",
                                     @"Cell11", @"Cell12", nil];
    
    arrayImage = [NSArray arrayWithObjects:@"VKMenu.png", @"faceMenu.png", @"instMenu.png", @"peresMenu.png", @"skypeMenu.png", nil];
    
    //Вью первой границы-------------------------------
    UIView * viewBorder1 = [[UIView alloc] initWithFrame:CGRectMake(0, 81, self.view.frame.size.width, 0.4)];
    if (isiPhone5) {
        viewBorder1.frame = CGRectMake(0, 75, self.view.frame.size.width, 0.4);
    }
    viewBorder1.backgroundColor = [UIColor colorWithHexString:@"b3b3b3"];
    [self.view addSubview:viewBorder1];

    //Вью второй границы-------------------------------
    UIView * viewBorder2 = [[UIView alloc] initWithFrame:CGRectMake(0, 308, self.view.frame.size.width, 0.4)];
    if (isiPhone5) {
        viewBorder2.frame = CGRectMake(0, 320, self.view.frame.size.width, 0.4);
    }
    viewBorder2.backgroundColor = [UIColor colorWithHexString:@"b3b3b3"];
    [self.view addSubview:viewBorder2];

    //Вью второй границы-------------------------------
    UIView * viewBorder3 = [[UIView alloc] initWithFrame:CGRectMake(0, 396, self.view.frame.size.width, 0.4)];
    viewBorder3.backgroundColor = [UIColor colorWithHexString:@"b3b3b3"];
    [self.view addSubview:viewBorder3];
    
    //Убираем полосы разделяющие ячейки------------------------------
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    
    //Создаем текст имени--------------------------------------------
    labelName = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, 40)];
    if ([[[SingleTone sharedManager] userName] isEqual: [NSNull null]]) {
       labelName.text = [NSString stringWithFormat:@"гость %@", [[SingleTone sharedManager] userID]];
    } else {
        labelName.text = [[SingleTone sharedManager] userName];
    }
    labelName.textColor = [UIColor whiteColor];
    labelName.font = [UIFont fontWithName:FONTREGULAR size:18];
    [self.view addSubview:labelName];
    
    
    
    
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = nil;
    
    if (isiPhone5) {
        if ([cellIdentifier isEqualToString:@"Cell3"]) {
            UILabel * label1 = (UILabel*)[self.view viewWithTag:10];
            CGRect rect1 = label1.frame;
            rect1.origin.y -= 5;
            label1.frame = rect1;
            //----
            UIImageView * image1 = (UIImageView*)[self.view viewWithTag:20];
            CGRect rect10 = image1.frame;
            rect10.origin.y -= 5;
            image1.frame = rect10;
        } else if ([cellIdentifier isEqualToString:@"Cell4"]) {
            UILabel * label2 = (UILabel*)[self.view viewWithTag:11];
            CGRect rect2 = label2.frame;
            rect2.origin.y -= 5;
            label2.frame = rect2;
            //----
            UIImageView * image2 = (UIImageView*)[self.view viewWithTag:21];
            CGRect rect11 = image2.frame;
            rect11.origin.y -= 5;
            image2.frame = rect11;
        } else if ([cellIdentifier isEqualToString:@"Cell5"]) {
            UILabel * label3 = (UILabel*)[self.view viewWithTag:12];
            CGRect rect3 = label3.frame;
            rect3.origin.y -= 5;
            label3.frame = rect3;
            //----
            UIImageView * image2 = (UIImageView*)[self.view viewWithTag:22];
            CGRect rect12 = image2.frame;
            rect12.origin.y -= 5;
            image2.frame = rect12;
        } else if ([cellIdentifier isEqualToString:@"Cell6"]) {
            UILabel * label4 = (UILabel*)[self.view viewWithTag:13];
            CGRect rect4 = label4.frame;
            rect4.origin.y -= 5;
            label4.frame = rect4;
            //----
            UIImageView * image4 = (UIImageView*)[self.view viewWithTag:23];
            CGRect rect14 = image4.frame;
            rect14.origin.y -= 5;
            image4.frame = rect14;
        } else if ([cellIdentifier isEqualToString:@"Cell9"]) {
            UILabel * label5 = (UILabel*)[self.view viewWithTag:15];
            CGRect rect5 = label5.frame;
            rect5.origin.y -= 5;
            label5.frame = rect5;
            //----
            UIImageView * image5 = (UIImageView*)[self.view viewWithTag:25];
            CGRect rect15 = image5.frame;
            rect15.origin.y -= 5;
            image5.frame = rect15;
        } else if ([cellIdentifier isEqualToString:@"Cell10"]) {
            UILabel * label6 = (UILabel*)[self.view viewWithTag:16];
            CGRect rect6 = label6.frame;
            rect6.origin.y -= 5;
            label6.frame = rect6;
            //----
            UIImageView * image6 = (UIImageView*)[self.view viewWithTag:26];
            CGRect rect16 = image6.frame;
            rect16.origin.y -= 5;
            image6.frame = rect16;
        }
    }
    
    if ([cellIdentifier isEqualToString:@"Cell8"]) {
        cell.userInteractionEnabled = NO;
    }
    
    if ([cellIdentifier isEqualToString:@"Cell1"]) {
        cell.userInteractionEnabled = NO;
    }
    
    if ([cellIdentifier isEqualToString:@"Cell11"]) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            //Поделится----------------------------------------
            UILabel * labelShare = [[UILabel alloc] initWithFrame:CGRectMake(20, 16, 200, 16)];
            labelShare.text = @"Поделиться";
            labelShare.textColor = [UIColor whiteColor];
            labelShare.font = [UIFont fontWithName:FONTREGULAR size:15];
            [cell addSubview:labelShare];
        
            //Загружаем кнопочки картинок----------------------
            for (int i = 0; i < 5; i ++) {
                UIButton * buttonMenu = [UIButton buttonWithType:UIButtonTypeCustom];
                buttonMenu.frame = CGRectMake(20 + 40 * i, 46, 32, 32);
                if (isiPhone5) {
                    buttonMenu.frame = CGRectMake(20 + 40 * i, 41, 32, 32);
                }
                buttonMenu.layer.cornerRadius = 16;
                UIImage * buttonImage = [UIImage imageNamed:[arrayImage objectAtIndex:i]];
                [buttonMenu setImage:buttonImage forState:UIControlStateNormal];
                buttonMenu.tag = 20 + i;
                [cell addSubview:buttonMenu];
            }
        
    }
    
    if ([cellIdentifier isEqualToString:@"Cell2"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 11) {
        AuthDbClass * auth = [AuthDbClass new];
        [auth deleteAll];
    }    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7) {
        return 15;
    } else if (indexPath.row == 1) {
        if (isiPhone5) {
            return 50;
        } else {
        return 60;
        }
    } else if (indexPath.row == 10) {
        if (isiPhone5) {
            return 75;
        } else {
        return 90;
        }
    } else if (indexPath.row == 6) {
        return 0;
    } else {
        if (isiPhone5) {
            return 30;
        } else {
        return 40;
    }
    }
}

#pragma mark - Action Methods

- (void) buttonNotificationAction
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) checkName: (NSNotification*) notification
{
    labelName.text = notification.object;
}

- (void) changeName: (NSNotification*) notification
{
    labelName.text = notification.object;
}



@end

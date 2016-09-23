//
//  MenuViewController.m
//  ITDolgopa
//
//  Created by Viktor on 16.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "MenuViewController.h"
#import "UIColor+HexColor.h"
#import "SWRevealViewController.h"
#import "Macros.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation MenuViewController
{
    NSArray * menu;
    NSArray * nameCell;
}

#pragma mark - Initialization

- (void) viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    self.mainTableView.backgroundColor = [UIColor lightGrayColor];
    self.mainTableView.scrollEnabled = NO;
    
    
    menu = [NSArray arrayWithObjects:@"Cell1", @"Cell2", @"Cell3", @"Cell4", @"Cell5", @"Cell6", @"Cell7", @"Cell8", @"Cell9", @"Cell10", @"Cell11",nil];
    
    //Убираем полосы разделяющие ячейки------------------------------
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = [UIColor clearColor];
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
    
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor blackColor];
        cell.userInteractionEnabled = NO;
    } else {
        UIView * viewActiveCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width - 50, cell.frame.size.height)];
        viewActiveCell.backgroundColor = [UIColor colorWithHexString:@"5d5d5d"];
        [cell addSubview:viewActiveCell];
        
        UILabel * labelName = [[UILabel alloc] initWithFrame:CGRectMake(-10, 0, viewActiveCell.frame.size.width, viewActiveCell.frame.size.height)];
        if (indexPath.row == 0) {
            labelName.text = @"ГЛАВНАЯ";
        }
        if (indexPath.row == 2) {
            labelName.text = @"ПРАВИЛА";
        }
        if (indexPath.row == 4) {
            labelName.text = @"ТРЕБОВАНИЯ";
        }
        if (indexPath.row == 6) {
            labelName.text = @"ЖЮРИ";
        }
        if (indexPath.row == 8) {
            labelName.text = @"ГАЛЕРЕЯ";
        }
        if (indexPath.row == 10) {
            labelName.text = @"ЗАЯВКА";
        }
        labelName.textColor = [UIColor whiteColor];
        labelName.textAlignment = NSTextAlignmentCenter;
        labelName.font = [UIFont fontWithName:FONTREGULAR size:16];
        [viewActiveCell addSubview:labelName];
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 != 0) {
       
        return 5;
        
    } else {
        if (isiPhone5) {
            return 50;
        } else {
    return 70;
}
}
}
@end

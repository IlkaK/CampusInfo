//
//  MenuOverviewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.08.13.
//
//

#import <UIKit/UIKit.h>
#import <ContactsViewController.h>
#import <SettingsViewController.h>

@class ContactsViewController;
@class SettingsViewController;

@interface MenuOverviewController : UIViewController<UITableViewDelegate>
{
    
    IBOutlet UITableView            *_menuTableView;
    IBOutlet UITableViewCell        *_menuTimeTableCell;
    IBOutlet UITableViewCell        *_menuMensaTableCell;
    IBOutlet UITableViewCell        *_menuNewsTableCell;
    
    IBOutlet ContactsViewController *_contactsVC;
    IBOutlet SettingsViewController *_settingsVC;
}

@property (nonatomic, retain) IBOutlet UITableView               *_menuTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_menuTimeTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_menuMensaTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_menuNewsTableCell;

@property (nonatomic, retain) IBOutlet ContactsViewController    *_contactsVC;
@property (nonatomic, retain) IBOutlet SettingsViewController    *_settingsVC;

@end

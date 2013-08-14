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
#import <NewsViewController.h>
#import <EventsViewController.h>
#import <PublicTransportViewController.h>

@class ContactsViewController;
@class SettingsViewController;
@class NewsViewController;
@class EventsViewController;
@class PublicTransportViewController;

@interface MenuOverviewController : UIViewController<UITableViewDelegate>
{
    
    IBOutlet UITableView            *_menuTableView;
    IBOutlet UITableViewCell        *_menuTimeTableCell;
    IBOutlet UITableViewCell        *_menuMensaTableCell;
    IBOutlet UITableViewCell        *_menuNewsTableCell;

    UIColor                         *_cellBackgroundColor;
    UIColor                         *_fontColor;
    
    IBOutlet ContactsViewController *_contactsVC;
    IBOutlet SettingsViewController *_settingsVC;
    IBOutlet NewsViewController     *_newsVC;
    IBOutlet PublicTransportViewController *_publicTransportVC;
    IBOutlet EventsViewController   *_eventsVC;
}

@property (nonatomic, retain) IBOutlet UITableView               *_menuTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_menuTimeTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_menuMensaTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_menuNewsTableCell;

@property (nonatomic, retain) UIColor                            *_cellBackgroundColor;
@property (nonatomic, retain) UIColor                            *_fontColor;

@property (nonatomic, retain) IBOutlet ContactsViewController    *_contactsVC;
@property (nonatomic, retain) IBOutlet SettingsViewController    *_settingsVC;
@property (nonatomic, retain) IBOutlet NewsViewController        *_newsVC;
@property (nonatomic, retain) IBOutlet EventsViewController      *_eventsVC;
@property (nonatomic, retain) IBOutlet PublicTransportViewController      *_publicTransportVC;

@end

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
#import <MapsViewController.h>
#import <SocialMediaViewController.h>
#import <ColorSelection.h>

@class ContactsViewController;
@class SettingsViewController;
@class NewsViewController;
@class EventsViewController;
@class PublicTransportViewController;
@class MapsViewController;
@class SocialMediaViewController;

@interface MenuOverviewController : UIViewController<UITableViewDelegate>
{
    
    IBOutlet UITableView                    *_menuTableView;    
    IBOutlet UITableViewCell                *_menuOverviewTableCell;
    
    UIColor                                 *_backgroundColor;
    ColorSelection                          *_zhawColor;
    
    IBOutlet ContactsViewController         *_contactsVC;
    IBOutlet SettingsViewController         *_settingsVC;
    IBOutlet NewsViewController             *_newsVC;
    IBOutlet PublicTransportViewController  *_publicTransportVC;
    IBOutlet EventsViewController           *_eventsVC;
    IBOutlet MapsViewController             *_mapsVC;
    IBOutlet SocialMediaViewController      *_socialMediaVC;

}

@property (nonatomic, retain) IBOutlet UITableView                          *_menuTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell                      *_menuOverviewTableCell;

@property (nonatomic, retain) UIColor                                       *_backgroundColor;
@property (nonatomic, retain) ColorSelection                                *_zhawColor;

@property (nonatomic, retain) IBOutlet ContactsViewController               *_contactsVC;
@property (nonatomic, retain) IBOutlet SettingsViewController               *_settingsVC;
@property (nonatomic, retain) IBOutlet NewsViewController                   *_newsVC;
@property (nonatomic, retain) IBOutlet EventsViewController                 *_eventsVC;
@property (nonatomic, retain) IBOutlet PublicTransportViewController        *_publicTransportVC;
@property (nonatomic, retain) IBOutlet MapsViewController                   *_mapsVC;
@property (nonatomic, retain) IBOutlet SocialMediaViewController            *_socialMediaVC;


@end

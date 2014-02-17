/*
 MenuOverviewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MenuOverviewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of MenuOverviewController.xib, which shows all menu items. </li>
 *      <li> Menu items are shown in a table. </li>
 *      <li> Delegate is passed to clicked item in menu. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class does not receive any data, but the delegate, when the back button is clicked in one of the menu items. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> This class does not pass any data, but the delegate. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "ContactsViewController.h"
#import "SettingsViewController.h"
#import "NewsViewController.h"
#import "EventsViewController.h"
#import "PublicTransportViewController.h"
#import "MapsViewController.h"
#import "SocialMediaViewController.h"
#import "ColorSelection.h"

@class ContactsViewController;
@class SettingsViewController;
@class NewsViewController;
@class EventsViewController;
@class PublicTransportViewController;
@class MapsViewController;
@class SocialMediaViewController;
@class TryNewMenuViewController;

@interface MenuOverviewController : UIViewController<UITableViewDelegate>
{
    /*! @var _menuCollectionView CollectionView to display the menu items in ordered form */
    IBOutlet UICollectionView               *_menuCollectionView;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                          *_zhawColor;
    
    /*! @var _contactsVC Handles delegate from and to ContactsViewController, which is triggered when the contacts button is clicked */
    IBOutlet ContactsViewController         *_contactsVC;
    /*! @var _settingsVC Handles delegate from and to SettingsViewController, which is triggered when the settings button is clicked */
    IBOutlet SettingsViewController         *_settingsVC;
    /*! @var _newsVC Handles delegate from and to NewsViewController, which is triggered when the news button is clicked */
    IBOutlet NewsViewController             *_newsVC;
    /*! @var _publicTransportVC Handles delegate from and to PublicTransportViewController, which is triggered when the public transportation button is clicked */
    IBOutlet PublicTransportViewController  *_publicTransportVC;
    /*! @var _eventsVC Handles delegate from and to EventsViewController, which is triggered when the events button is clicked */
    IBOutlet EventsViewController           *_eventsVC;
    /*! @var _mapsVC Handles delegate from and to MapsViewController, which is triggered when the maps button is clicked */
    IBOutlet MapsViewController             *_mapsVC;
    /*! @var _socialMediaVC Handles delegate from and to SocialMediaViewController, which is triggered when the social media button is clicked */
    IBOutlet SocialMediaViewController      *_socialMediaVC;

}

@property (nonatomic, retain) IBOutlet UICollectionView                     *_menuCollectionView;

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

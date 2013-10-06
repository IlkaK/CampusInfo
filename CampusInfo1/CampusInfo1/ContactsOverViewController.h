/*
 ContactsOverViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ContactsOverViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of ContactsOverViewController.xib, which displays a table with which entries the contacts views can be called.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from MenuOverviewController and passes it back, if back button is clicked. </li>
 *      <li> It receives data from NewsChannelDto, which establishes a connection to server. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes delegate to ContactsViewController, EmergencyViewController and ServiceDeskViewController and receives it back from them. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "ContactsViewController.h"
#import "EmergencyViewController.h"
#import "ServiceDeskViewController.h"
#import "ColorSelection.h"

@interface ContactsOverViewController : UIViewController<UITableViewDelegate>
{
    /*! @var _contactsVC Handles delegate from and to ContactsViewController, is triggered when the table cell is hit. */
    IBOutlet ContactsViewController     *_contactsVC;
    /*! @var _emergencyVC Handles delegate from and to EmergencyViewController, is triggered when the table cell is hit. */
    IBOutlet EmergencyViewController    *_emergencyVC;
    /*! @var _serviceDeskVC Handles delegate from and to ServiceDeskViewController, is triggered when the table cell is hit. */
    IBOutlet ServiceDeskViewController  *_serviceDeskVC;
    
    /*! @var _menuTableView Table to display the contact view items */
    IBOutlet UITableView                *_menuTableView;
    /*! @var _menuTableCell Handles cell, which displays the solo contact view item */
    IBOutlet UITableViewCell            *_menuTableCell;
    
    /*! @var _titleNavigationBar Used as background for title */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title */
    IBOutlet UILabel                    *_titleNavigationLabel;

    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
}

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet ContactsViewController       *_contactsVC;
@property (nonatomic, retain) IBOutlet EmergencyViewController      *_emergencyVC;
@property (nonatomic, retain) IBOutlet ServiceDeskViewController    *_serviceDeskVC;

@property (nonatomic, retain) IBOutlet UITableView                  *_menuTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_menuTableCell;

@property (nonatomic, retain) ColorSelection                        *_zhawColor;

@end

/*
 ContactsViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ContactsViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of ContactsViewController.xib, which displays a table with all secretary contact information.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from ContactsOverViewController and passes it back, if back button is clicked. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> If email is clicked, email app is startet and email is started.  </li>
 *      <li> If phone number is clicked, a call is started.  </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "ColorSelection.h"

@interface ContactsViewController : UIViewController<UITableViewDelegate>
{
    /*! @var _contactsTable Table to display the secretary contact information */
    IBOutlet UITableView        *_contactsTable;
    /*! @var _contactsPlaceTableCell Handles cell, which displays the secretary phone number information */
    IBOutlet UITableViewCell    *_contactsPhoneTableCell;
    /*! @var _contactsPlaceTableCell Handles cell, which displays the secretary place information */
    IBOutlet UITableViewCell    *_contactsPlaceTableCell;
    
    /*! @var _currentEmail Holds the current clicked email address */
    NSString                    *_currentEmail;
    /*! @var _currentPhoneNumber Holds the current clicked phone number */
    NSString                    *_currentPhoneNumber;
    
    /*! @var _titleNavigationBar Used as background for title */
    IBOutlet UINavigationBar    *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem   *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title */
    IBOutlet UILabel            *_titleNavigationLabel;

    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection              *_zhawColor;
}

@property (nonatomic, retain) IBOutlet UITableView          *_contactsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsPhoneTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsPlaceTableCell;

@property (nonatomic, retain) NSString                      *_currentEmail;
@property (nonatomic, retain) NSString                      *_currentPhoneNumber;

@property (nonatomic, retain) IBOutlet UINavigationBar      *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem     *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel              *_titleNavigationLabel;

@property (nonatomic, retain) ColorSelection                *_zhawColor;

@end

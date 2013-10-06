/*
 EmergencyViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header EmergencyViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of EmergencyViewController.xib, which displays a table with all emergency contact information.  </li>
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

@interface EmergencyViewController : UIViewController<UITableViewDelegate>
{
    /*! @var _emergencyTable Table to display the emergency contact information */
    IBOutlet UITableView        *_emergencyTable;
    /*! @var _emergencyDetailTableCell Handles cell, which displays the emergency detail information */
    IBOutlet UITableViewCell    *_emergencyDetailTableCell;
    /*! @var _emergencyInformTableCell Handles cell, which displays the emergency information */
    IBOutlet UITableViewCell    *_emergencyInformTableCell;
    
    /*! @var _emergencyCallNumber Holds the current clicked phone number */
    NSString                    *_emergencyCallNumber;
    
    /*! @var _titleNavigationBar Used as background for title */
    IBOutlet UINavigationBar    *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem   *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title */
    IBOutlet UILabel            *_titleNavigationLabel;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection              *_zhawColor;
}

@property (nonatomic, retain) IBOutlet UITableView          *_emergencyTable;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_emergencyDetailTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_emergencyInformTableCell;

@property (nonatomic, retain) NSString                      *_emergencyCallNumber;

@property (nonatomic, retain) IBOutlet UINavigationBar      *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem     *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel              *_titleNavigationLabel;

@property (nonatomic, retain) ColorSelection                *_zhawColor;

@end

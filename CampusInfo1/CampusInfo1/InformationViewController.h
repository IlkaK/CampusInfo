/*
 InformationViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header InformationViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of InformationViewController.xib, which displays information about the app.  </li>
 *      <li> Shows the service des contact information.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from ContactsOverVieController and passes it back, if back button is clicked. </li>
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

@interface InformationViewController : UIViewController
{
    /*! @var _titleNavigationBar Shows the title */
    IBOutlet UINavigationBar    *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem   *_titleNavigationItem;
    IBOutlet UILabel            *_titleLabel;
    IBOutlet UILabel            *_descriptionLabel;
    
    /*! @var _informationResponsibleTableCell Handles cell, which displays the responsible information */
    IBOutlet UITableViewCell    *_informationResponsibleTableCell;
    /*! @var _informationContactTableCell Handles cell, which displays the contact information */
    IBOutlet UITableViewCell *_informationContactTableCell;
    
    /*! @var _currentEmail Holds the current clicked email address */
    NSString                        *_currentEmail;
    /*! @var _currentPhoneNumber Holds the current clicked phone number */
    NSString                        *_currentPhoneNumber;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                  *_zhawColor;
}

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;
@property (nonatomic, retain) IBOutlet UILabel                      *_descriptionLabel;


@property (nonatomic, retain) IBOutlet UITableViewCell              *_informationResponsibleTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_informationContactTableCell;

@property (nonatomic, retain) NSString                              *_currentEmail;
@property (nonatomic, retain) NSString                              *_currentPhoneNumber;

@property (nonatomic, retain) ColorSelection                        *_zhawColor;


@end

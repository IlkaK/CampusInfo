/*
 SocialMediaViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SocialMediaViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of SocialMediaViewController.xib, which shows social media links </li>
 *      <li> Listing social media links and browsing there when activated.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class only receives the delegate from MenuOverviewController and does not get any other data. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> This class only sends back the delegate to MenuOverviewController.</li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "ColorSelection.h"

@interface SocialMediaViewController : UIViewController<UITableViewDelegate>
{

    /*! @var _titleNavigationBar Used as background for the title in the view */
    IBOutlet UINavigationBar        *_titleNavigationBar;
    /*! @var _titleNavigationItem Used to show the back button to return to main menu in title */
    IBOutlet UINavigationItem       *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title of the view */
    IBOutlet UILabel                *_titleNavigationLabel;
    
    /*! @var _socialMediaTableCell Table cell to show social media link with description */
    IBOutlet UITableViewCell        *_socialMediaTableCell;
    
    /*! @var _zhawColors Holds all color schemes needed */
    ColorSelection                  *_zhawColor;
}

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_socialMediaTableCell;

@property (nonatomic, retain) ColorSelection                        *_zhawColor;

@end

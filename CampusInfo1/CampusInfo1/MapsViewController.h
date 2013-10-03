/*
 MapsViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MapsViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of MapsViewController.xib, which shows the overview of maps which can be chosen. </li>
 *      <li> Gets the delegate from menu overview and passes it on to the seperate maps shown in TechnikumViewController. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class is called by MenuOverviewController or via back button from TechnikumViewController and only receives the delegate from there. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the delegate back to MenuOverviewController or to TechnikumViewController. </li>
 *      <li> Depending on the chosen table cell, it sets the map file, file format and description for TechnikumViewController.  </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "TechnikumViewController.h"
#import "ColorSelection.h"

@class TechnikumViewController;

@interface MapsViewController : UIViewController<UITableViewDelegate>
{
    /*! @var _titleNavigationBar Used as background for the title in the view */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationItem Used to show the back button to return to MenuOverviewController */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title of the view */
    IBOutlet UILabel                    *_titleNavigationLabel;

    /*! @var _technikumVC Handles delegate from and to TechnikumViewController, which is triggered when one of the maps is clicked. */
    IBOutlet TechnikumViewController    *_technikumVC;
    
    /*! @var _menuTableView Shows the maps which can be clicked */
    IBOutlet UITableView                *_menuTableView;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
}


@property (nonatomic, retain) IBOutlet UITableView                  *_menuTableView;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet TechnikumViewController      *_technikumVC;

@property (nonatomic, retain) IBOutlet ColorSelection               *_zhawColor;


@end

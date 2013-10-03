/*
 TechnikumViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header TechnikumViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of TechnikumViewController.xib, which shows the choosen map within a web view. </li>
 *      <li> Gets the delegate from MapsViewController. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class is called by MapsViewController and receives the delegate from there. </li>
 *      <li> MapsViewController also sets its file, file format and description. </li> *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It only passes the delegate back to MapsViewController. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "ColorSelection.h"

@interface TechnikumViewController : UIViewController
{
    /*! @var _titleNavigationBar Used as background for the title in the view */
    IBOutlet UINavigationBar    *_titleNavigationBar;
    /*! @var _titleNavigationItem Used to show the back button to return to MapsOverviewController */
    IBOutlet UINavigationItem   *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title of the view */
    IBOutlet UILabel            *_titleNavigationLabel;

    /*! @var _descriptionNavigationBar Used as background for the description in the view */
    IBOutlet UINavigationBar    *_descriptionNavigationBar;
    /*! @var _descriptionNavigationItem Works as background for the description */
    IBOutlet UINavigationItem   *_descriptionNavigationItem;
    /*! @var _descriptionLabel Shows the description text */
    IBOutlet UILabel            *_descriptionLabel;
    
    /*! @var _technikumWebView Shows the map, accordingly to _fileName and _fileFormat */
    IBOutlet UIWebView          *_technikumWebView;

    /*! @var _description Is set by MapsViewController and holds the description of the map */
    NSString                    *_description;
    /*! @var _fileName Is set by MapsViewController and holds the file name of the map */
    NSString                    *_fileName;
    /*! @var _fileFormat Is set by MapsViewController and holds the file format of the map */
    NSString                    *_fileFormat;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection              *_zhawColor;
}


@property (nonatomic, retain) IBOutlet UINavigationBar                  *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem                 *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                          *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet UINavigationBar                  *_descriptionNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem                 *_descriptionNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                          *_descriptionLabel;

@property (nonatomic, retain) IBOutlet UIWebView                        *_technikumWebView;

@property (nonatomic, retain) NSString                                  *_description;
@property (nonatomic, retain) NSString                                  *_fileName;
@property (nonatomic, retain) NSString                                  *_fileFormat;

@property (nonatomic, retain) ColorSelection                            *_zhawColor;

@end

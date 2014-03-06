/*
 PublicStopViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header PublicStopViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of PublicStopViewController.xib, where stations can be searched using autocomplete functionality. </li>
 *      <li> While typing stations, tables shows suggestions for autocomplete. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from PublicTransportViewController and passes it back, if back button is clicked. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the found station back to PublicTransportViewController. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */


#import <UIKit/UIKit.h>
#import "StationArrayDto.h"
#import "StationDto.h"
#import "DBCachingForAutocomplete.h"
#import "Autocomplete.h"
#import "ColorSelection.h"

@interface PublicStopViewController : UIViewController<UITextFieldDelegate>
{
    /*! @var _stationArray Holds the array with all found station suggestions */
    StationArrayDto                     *_stationArray;
    /*! @var _actualStationType Actual chosen station type */
    NSString                            *_actualStationType;
    /*! @var _actualStationName Actual chosen station */
    NSString                            *_actualStationName;
    
    /*! @var _titleNavigationBar Used as background for title and acronym */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    /*! @var _titleLabel Shows the title */
    IBOutlet UILabel                    *_titleLabel;
    /*! @var _descriptionLabel Shows the description */
    IBOutlet UILabel                    *_descriptionLabel;
    
    
    /*! @var _publicStopTableView Shows all suggestions for given text in _publicStopTextField */
    IBOutlet UITableView                *_publicStopTableView;
    /*! @var _publicStopTextField Shows and stores the searched station */
    IBOutlet UITextField                *_publicStopTextField;
    /*! @var _publicStopTextFieldString Holds the station in the text field _publicStopTextField */
    NSString                            *_publicStopTextFieldString;
    
    /*! @var _dbCachingForAutocomplete Handles the interaction of the database to store and get student acronyms */
    DBCachingForAutocomplete            *_dbCachingForAutocomplete;
    /*!  @var _suggestions Holds all actual suggestions for acronyms, which are displayed in _publicStopTableView */
    NSMutableArray                      *_suggestions;
    /*! @var _autocomplete Handling the autocomplete functionality */
    Autocomplete                        *_autocomplete;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
    
    IBOutlet UIButton                   *_lastStationButton1;
    IBOutlet UIButton                   *_lastStationButton2;
    
    NSString                            *_lastStation1;
    NSString                            *_lastStation2;

    
}

@property (nonatomic, retain) StationArrayDto                       *_stationArray;
@property (nonatomic, retain) NSString                              *_actualStationType;
@property (nonatomic, retain) NSString                              *_actualStationName;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;
@property (nonatomic, retain) IBOutlet UILabel                      *_descriptionLabel;

@property (nonatomic, retain) IBOutlet UITableView                  *_publicStopTableView;

@property (nonatomic, retain) IBOutlet UITextField                  *_publicStopTextField;
@property (nonatomic, retain) NSString                              *_publicStopTextFieldString;

@property (nonatomic, retain) DBCachingForAutocomplete              *_dbCachingForAutocomplete;
@property (strong, nonatomic) NSMutableArray                        *_suggestions;
@property (strong, nonatomic) Autocomplete                          *_autocomplete;

@property (strong, nonatomic) ColorSelection                        *_zhawColor;

@property (nonatomic, retain) IBOutlet UIButton                     *_lastStationButton1;
@property (nonatomic, retain) IBOutlet UIButton                     *_lastStationButton2;
@property (nonatomic, retain) NSString                              *_lastStation1;
@property (nonatomic, retain) NSString                              *_lastStation2;


/*!
 @function publicStopTextFieldChanged
 Triggered, when the text in _publicStopTextField is changed by the user. Then the table for suggestions needs to be updated accordingly.
 @param sender
 */
- (IBAction)publicStopTextFieldChanged:(id)sender;
- (IBAction)changeToLastStation1:(id)sender;
- (IBAction)changeToLastStation2:(id)sender;

@end

/*
 MenuPlanArrayDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MenuPlanArrayDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds menu plan array in MensaMenuDto model. </li>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain mensa menu data from there. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives calendar week and year to build the url which is send to the server. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> Using TimeTableAsyncRequestDelegate it gets the date from server request. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <Foundation/Foundation.h>
#import "MenuDto.h"
#import "TimeTableAsyncRequest.h"

@interface MenuPlanArrayDto : NSObject<TimeTableAsyncRequestDelegate>
{
    /*! @var _menuPlans Stores an array of menu plans */
    NSMutableArray              *_menuPlans;
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */        
    DateFormation               *_dateFormatter;
    
    /*! @var _generalDictionary Stores the dictionary of data which is returned by the server */
    NSDictionary                *_generalDictionary;
    /*! @var _asyncTimeTableRequest Handles connection to server */
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    /*! @var _dataFromUrl Holding data gained from url */
    NSData                      *_dataFromUrl;
    /*! @var _errorMessage Stores the error message, if the connection to server had an error. */ 
    NSString                    *_errorMessage;
    /*! @var _connectionTrials Stores how often system tried to connect to server. */
    int                         _connectionTrials;
    
    /*! @var _actualYear Stores the actual year of the mensa menu */
    int                         _actualYear;
    /*! @var _actualCalendarWeek Stores the actual calendar week of the mensa menu */
    int                         _actualCalendarWeek;
}

@property (nonatomic, retain) NSMutableArray                    *_menuPlans;
@property (nonatomic, retain) DateFormation                     *_dateFormatter;

@property (strong, nonatomic) NSDictionary                      *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest    *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                            *_dataFromUrl;
@property (nonatomic, retain) NSString                          *_errorMessage;
@property (nonatomic, assign) int                               _connectionTrials;

@property (nonatomic, assign) int                               _actualYear;
@property (nonatomic, assign) int                               _actualCalendarWeek;

/*!
 @function init
 Initializes MenuPlanArrayDto.
 @param newMenuPlans
 */
-(id)   init : (NSMutableArray *) newMenuPlans;

/*!
 @function getData
 Gets mensa menu plan array for given year, calendar week, actual date and gastro id.
 @param calendarWeek
 @param year
 @param actualDate
 @param gastroId
 */
-(void) getData:(int)calendarWeek
       withYear:(int)year
 withActualDate:(NSDate *)actualDate
   withGastroId:(int)gastroId;

/*!
 @function getActualMenu
 Gets the mensa menu plan for given date and gastro id.
 @param actualDate
 @param gastroId
 */
-(MenuDto *)getActualMenu:(NSDate *)actualDate
             withGastroId:(int)gastroId;

@end

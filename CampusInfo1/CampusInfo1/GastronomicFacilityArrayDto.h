/*
 GastronomicFacilityArrayDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header GastronomicFacilityArrayDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds gastronomic facitlity array in MensaOverviewDto model. </li>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain gastronomic facility data from there. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It does not need extra data to build the url which is send to the server. </li>
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
#import "TimeTableAsyncRequest.h"
#import "GastronomicFacilityDto.h"
#import "DateFormation.h"

@interface GastronomicFacilityArrayDto : NSObject<TimeTableAsyncRequestDelegate>
{
    /*! @var _gastronomicFacilities Stores an array of gastronomic facilities */
    NSMutableArray              *_gastronomicFacilities;
    
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
    /*! @var _url Stores the url which is send to server. */
    NSURL                       *_url;
    
    /*! @var _threadDone Stores if the thread is finished. */
    BOOL                        _threadDone;
    
    /*! @var _noConnection Stores if a connection to the server could be established. */
    BOOL                        _noConnection;
}

@property (nonatomic, retain) NSMutableArray                    *_gastronomicFacilities;
@property (nonatomic, retain) DateFormation                     *_dateFormatter;

@property (strong, nonatomic) NSDictionary                      *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest    *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                            *_dataFromUrl;
@property (nonatomic, retain) NSString                          *_errorMessage;
@property (nonatomic, assign) int                               _connectionTrials;
@property (nonatomic, retain) NSURL                             *_url;

@property (nonatomic, assign) BOOL                              _threadDone;
@property (nonatomic, assign) BOOL                              _noConnection;

/*!
 @function init
 Initializes GastronomicFacilityArrayDto.
 @param newGastronomicFacilities
 */
-(id)   init : (NSMutableArray *) newGastronomicFacilities;

/*!
 @function getData
 Gets gastronomic facitlities.
 */
-(void) getData;


@end

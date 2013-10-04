/*
 StationArrayDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header StationArrayDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds station array in PublicTransportDto model. </li>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain time table data from there. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives station name to build the url which is send to the server. </li>
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


@interface StationArrayDto : NSObject<TimeTableAsyncRequestDelegate>
{
    /*! @var _stations Stores an array of station for public transportation */
    NSMutableArray              *_stations;
    /*! @var _actualStation Stores the chosen station which is given via function getData */
    NSString                    *_actualStation;
    
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
}

@property (nonatomic, retain) NSMutableArray                    *_stations;
@property (nonatomic, retain) NSString                          *_actualStation;

@property (strong, nonatomic) NSDictionary                      *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest    *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                            *_dataFromUrl;
@property (nonatomic, retain) NSString                          *_errorMessage;
@property (nonatomic, assign) int                               _connectionTrials;
@property (nonatomic, retain) NSURL                             *_url;

/*!
 @function init
 Initializes StationArrayDto.
 @param newStations
 */
-(id)   init : (NSMutableArray *) newStations;

/*!
 @function getData
 Gets station array for given actual station.
 @param newActualStation
 */
-(void) getData:(NSString *)newActualStation;


@end

/*
 ConnectionArrayDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ConnectionArrayDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds connections array in PublicTransportConnectionDto model. </li>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain time table data from there. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives start and stop station to build the url which is send to the server. </li>
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

@interface ConnectionArrayDto : NSObject<TimeTableAsyncRequestDelegate>
{
    /*! @var _connections Stores an array of connections for public transportation connection */
    NSMutableArray              *_connections;
    /*! @var _startStation Stores the start station of the connection */
    NSString                    *_startStation;
    /*! @var _stopStation Stores the stop station of the connection */
    NSString                    *_stopStation;
    /*! @var _connectionStartStation Stores the start station of the connection returned by the server */
    NSString                    *_connectionStartStation;
    /*! @var _connectionStopStation Stores the stop station of the connection returned by the server */
    NSString                    *_connectionStopStation;
    
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

@property (nonatomic, retain) NSMutableArray                    *_connections;

@property (strong, nonatomic) NSDictionary                      *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest    *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                            *_dataFromUrl;
@property (nonatomic, retain) NSString                          *_errorMessage;
@property (nonatomic, assign) int                               _connectionTrials;
@property (nonatomic, retain) NSURL                             *_url;

@property (nonatomic, retain) NSString                          *_startStation;
@property (nonatomic, retain) NSString                          *_stopStation;
@property (nonatomic, retain) NSString                          *_connectionStartStation;
@property (nonatomic, retain) NSString                          *_connectionStopStation;

/*!
 @function init
 Initializes ConnectionArrayDto.
 @param newConnections
 */
-(id)   init : (NSMutableArray *) newConnections;

/*!
 @function getData
 Gets connection array for given start and stop station.
 @param newStartStation
 @param newStopStation
 @param newStations
 */
-(void) getData: (NSString *)newStartStation
withStopStation: (NSString *)newStopStation
withNewStations: (BOOL)newStations;


@end

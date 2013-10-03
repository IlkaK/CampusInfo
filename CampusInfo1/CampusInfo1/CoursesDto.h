/*
 CoursesDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header CoursesDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain all acronyms of courses. </li>
 *      <li> Acronyms are stored in database, for that class DBCachingForAutocomplete is used. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives no data. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> If called it returns itself with an array of all courses acronyms, gathered via server connection or from database. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <Foundation/Foundation.h>
#import "TimeTableAsyncRequest.h"
#import "DBCachingForAutocomplete.h"

@interface CoursesDto : NSObject<TimeTableAsyncRequestDelegate>
{
    /*! @var _dbCachingForAutocomplete Handles the interaction of the database to store and get course acronyms */    
    DBCachingForAutocomplete    *_dbCachingForAutocomplete;
    
    /*! @var _courseArray Holds all course acronyms gathered via server connection */    
    NSMutableArray              *_courseArray;
    /*! @var _courseArrayFromDB Holds all course acronyms gathered via database */
    NSMutableArray              *_courseArrayFromDB;
    
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
}

@property (nonatomic, retain) DBCachingForAutocomplete      *_dbCachingForAutocomplete;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest *_asyncTimeTableRequest;

@property (strong, nonatomic) NSMutableArray                *_courseArray;
@property (strong, nonatomic) NSMutableArray                *_courseArrayFromDB;

@property (strong, nonatomic) NSDictionary                   *_generalDictionary;

@property (nonatomic, retain) NSData                         *_dataFromUrl;
@property (nonatomic, retain) NSString                       *_errorMessage;
@property (nonatomic, assign) int                             _connectionTrials;

/*!
 @function getData
 Initializes CoursesDto and gets course acronym array.
 */
-(void) getData;

@end

/*
 StudentsDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header StudentsDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain all acronyms of students. </li>
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
 *      <li> If called it returns itself with an array of all student acronyms, gathered via server connection or from database. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <Foundation/Foundation.h>
#import "TimeTableAsyncRequest.h"
#import "DBCachingForAutocomplete.h"

@interface StudentsDto : NSObject<TimeTableAsyncRequestDelegate>
{
    /*! @var _dbCachingForAutocomplete Handles the interaction of the database to store and get student acronyms */
    DBCachingForAutocomplete    *_dbCachingForAutocomplete;
    
    /*! @var _studentArray Holds all student acronyms gathered via server connection */
    NSMutableArray              *_studentArray;
    /*! @var _studentArrayFromDB Holds all student acronyms gathered via database */
    NSMutableArray              *_studentArrayFromDB;
    
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

@property (strong, nonatomic) NSMutableArray                *_studentArray;
@property (strong, nonatomic) NSMutableArray                *_studentArrayFromDB;

@property (strong, nonatomic) NSDictionary                   *_generalDictionary;

@property (nonatomic, retain) NSData                         *_dataFromUrl;
@property (nonatomic, retain) NSString                       *_errorMessage;
@property (nonatomic, assign) int                             _connectionTrials;

/*!
 @function getData
 Initializes StudentsDto and gets student acronym array.
 */
-(void) getData;

@end

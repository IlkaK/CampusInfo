/*
 ScheduleDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ScheduleDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for Schedule in TimeTableDto model. </li>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain time table data from there. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives acronym, acronym type and date to build the url which is send to the server. </li>
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
#import "DateFormation.h"

@class PersonDto;
@class RoomDto;
@class SchoolClassDto;
@class ScheduleCourseDto;


@interface ScheduleDto : NSObject <TimeTableAsyncRequestDelegate>
{
    /*! @var _days Stores an array of days for the Schedule */
    NSMutableArray        *_days;
    /*! @var _type Stores the type of the Schedule / acronym */
    NSString              *_type;
    /*! @var _acronym Stores the acronym of the Schedule */
    NSString              *_acronym;
    /*! @var _scheduleDate Stores the (start) date of the Schedule */    
    NSDate                *_scheduleDate;
    
    /*! @var _connectionEstablished Stores if connection to server could be established */
    NSString              *_connectionEstablished;
    
    /*! @var _student Stores the student, if he is the owner of the time table */
    PersonDto             *_student;
    /*! @var _lecturer Stores the lecturer, if he is the owner of the time table */
    PersonDto             *_lecturer;
    /*! @var _room Stores the room, if it is the owner of the time table */
    RoomDto               *_room;
    /*! @var _scheduleCourse Stores the course/lecture, if it is the owner of the time table */
    ScheduleCourseDto     *_scheduleCourse;
    /*! @var _schoolClass Stores the class, if it is the owner of the time table */
    SchoolClassDto        *_schoolClass;
    
    /*! @var _asyncTimeTableRequest Handles connection to server */
    TimeTableAsyncRequest *_asyncTimeTableRequest;
    /*! @var _dataFromUrl Holding data gained from url */
    NSData                *_dataFromUrl;
    /*! @var _errorMessage Stores the error message, if the connection to server had an error. */    
    NSString              *_errorMessage;
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    
    DateFormation         *_dateFormatter;
}

@property (nonatomic, retain) NSMutableArray                 *_days;
@property (nonatomic, retain) NSString                       *_type;
@property (nonatomic, retain) NSString                       *_acronym;
@property (nonatomic, retain) NSDate                         *_scheduleDate;
@property (nonatomic, retain) NSString                       *_connectionEstablished;


@property (nonatomic, retain) PersonDto                      *_student;
@property (nonatomic, retain) PersonDto                      *_lecturer;
@property (nonatomic, retain) RoomDto                        *_room;
@property (nonatomic, retain) ScheduleCourseDto              *_scheduleCourse;
@property (nonatomic, retain) SchoolClassDto                 *_schoolClass;


@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                         *_dataFromUrl;

@property (nonatomic, retain) NSString                       *_errorMessage;
@property (nonatomic, retain) DateFormation                  *_dateFormatter;

/*!
 @function initWithAcronym
 Needs to be called initally, when instance of ScheduleDto is created.
 It establishes a connection to the server and gets the schedule data from there.
 @param newAcronymString
 @param newAcronymType
 @param newScheduleDate
 */
-(id) initWithAcronym
   :(NSString *)newAcronymString
   :(NSString *)newAcronymType
   :(NSDate   *)newScheduleDate;

/*!
 @function loadScheduleWithAcronym
 Is called if schedule is already initialized but a new schedule for a different acronym or date needs to be loaded.
 @param newAcronymString
 @param newAcronymType
 @param newScheduleDate
 */
-(void)loadScheduleWithAcronym
    :(NSString *)newAcronymString
    :(NSString *)newAcronymType
    :(NSDate   *)newScheduleDate;

/*!
 @function initWithExampleDays
 Is called if schedule is initialized and used with test data without connecting to server.
 @param newExampleDays
 @param newExampleType
 */
-(id) initWithExampleDays
    :(NSMutableArray *)newExampleDays
    :(NSString *)newExampleType;

@end

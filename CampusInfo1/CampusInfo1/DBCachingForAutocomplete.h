/*
 DBCachingForAutocomplete.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header DBCachingForAutocomplete.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Handling data which is stored to database or got from there. </li>
 *      <li> Stored data is: </li>
 *      <ul>
 *          <li> lecturer acronyms </li>
 *          <li> room acronyms </li>
 *          <li> class acronyms </li>
 *          <li> course acronyms </li>
 *          <li> student acronyms </li>
 *          <li> the three last used start stations </li> 
 *          <li> all station suggestions  </li> 
 *      </ul>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> To store the data in the according databases it receives the following arrays: </li>
 *      <ul>
 *          <li> lecturer acronyms </li>
 *          <li> room acronyms </li>
 *          <li> class acronyms </li>
 *          <li> course acronyms </li>
 *          <li> student acronyms </li>
 *      </ul>
 *   </ul>
 *      <li> To add item by item the following data is added item by item: </li>
 *      <ul>
 *          <li> the last used start station </li>
 *          <li> the last used stop station </li>
 *      </ul>
 *      <li> The database with station suggestions is already imported and is not changed here. </li>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> Depending on the caller class the demanded arrays are returned. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <Foundation/Foundation.h>

#import "sqlite3.h"

@interface DBCachingForAutocomplete : NSObject
{
    /*! @var _timeTableDBPath Holds the path used for identifying where the acronym and start and stop station database is stored. */
    NSString        *_timeTableDBPath;
    /*! @var _connectionDBPath Holds the path used for identifying where the station database is stored. */
    NSString        *_connectionDBPath;
}

@property (nonatomic, retain) NSString *_timeTableDBPath;
@property (nonatomic, retain) NSString *_connectionDBPath;

/*!
 @function init
 Initialization of the class.
 Create tables, if they did not exist yet and sets the path strings.
 */
-(id) init;

/*!
 @function storeLecturers
 Stores the given array for lecturer acronyms.
 @param lecturerArray
 */
-(void) storeLecturers:(NSMutableArray *)lecturerArray;

/*!
 @function getLecturers
 Returns an array of lecturer acronyms.
 */
-(NSMutableArray *)getLecturers;

/*!
 @function storeRooms
 Stores the given array for room acronyms.
 @param roomArray
 */
-(void) storeRooms:(NSMutableArray *)roomArray;

/*!
 @function getRooms
 Returns an array of room acronyms.
 */
-(NSMutableArray *) getRooms;

/*!
 @function storeClasses
 Stores the given array for class acronyms.
 @param classArray
 */
-(void) storeClasses:(NSMutableArray *)classArray;

/*!
 @function getClasses
 Returns an array of class acronyms.
 */
-(NSMutableArray *) getClasses;

/*!
 @function storeCourses
 Stores the given array for course acronyms.
 @param coursesArray
 */
-(void) storeCourses:(NSMutableArray *)coursesArray;

/*!
 @function getCourses
 Returns an array of course acronyms.
 */
-(NSMutableArray *) getCourses;

/*!
 @function storeStudents
 Stores the given array for student acronyms.
 @param studentsArray
 */
-(void) storeStudents:(NSMutableArray *)studentsArray;

/*!
 @function getStudents
 Returns an array of student acronyms.
 */
-(NSMutableArray *) getStudents;

/*!
 @function addStartStation
 Adds a new start station to the array.
 @param startStation
 */
-(void) addStartStation:(NSString *)startStation;

/*!
 @function getStartStations
 Returns an array of the three last used start stations.
 */
-(NSMutableArray *) getStartStations;

/*!
 @function deleteStartStation
 Deletes all start stations from database.
 */
-(void) deleteStartStation;

/*!
 @function addStopStation
 Adds a new stop station to the array.
 @param stopStation
 */
-(void) addStopStation:(NSString *)stopStation;

/*!
 @function getStopStations
 Returns an array of the three last used stop stations.
 */
-(NSMutableArray *) getStopStations;

/*!
 @function deleteStopStation
 Deletes all stop stations from database.
 */
-(void) deleteStopStation;

/*!
 @function getDBStations
 Returns an array of all possible stations.
 */
-(NSMutableArray *)getDBStations;

@end

/*
 ScheduleEventRealizationDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ScheduleEventRealizationDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for ScheduleEventRealization in TimeTableDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives room, lecturers and schoolClasses to be initally set or a dictionary to browse the data itself. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It returns itself when called. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */
#import <Foundation/Foundation.h>

@class RoomDto;

@interface ScheduleEventRealizationDto : NSObject
{
    /*! @var _room Stores the room of the ScheduleEventRealization */
    RoomDto        *_room;
    /*! @var _lecturers Stores an array of lecturers of the ScheduleEventRealization */
    NSMutableArray *_lecturers;
    /*! @var _schoolClasses Stores an array of schoolClasses of the ScheduleEventRealization */
    NSMutableArray *_schoolClasses;
}

@property (nonatomic, retain) RoomDto        *_room;
@property (nonatomic, retain)   NSMutableArray *_lecturers;
@property (nonatomic, retain)   NSMutableArray *_schoolClasses;

/*!
 @function init
 Needs to be called initally, when instance of ScheduleEventRealizationDto is created.
 @param newRoom
 @param newLecturers
 @param newSchoolClass
 */
-(id) init : (RoomDto        *) newRoom
           : (NSMutableArray *) newLecturers
           : (NSMutableArray *) newSchoolClass;

/*!
 @function getEventRealization
 Is called when a new ScheduleEventRealizationDto instance should be created based on the dictionary information.
 @param realizationDictionary
 */
- (ScheduleEventRealizationDto *) getEventRealization:(NSDictionary *)realizationDictionary;

@end

/*
 CalendarWeekDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header CalendarWeekDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the calendar week data in MensaMenuDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives week and year to be initally set or a dictionary to browse the data itself. </li>
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

@interface CalendarWeekDto : NSObject
{
    /*! @var _week Holds the week number of the calendar week */
    int _week;
    /*! @var _week Holds the yearr of the calendar week */
    int _year;
}

@property (nonatomic, assign) int _week;
@property (nonatomic, assign) int _year;

/*!
 @function init
 Initializes CalendarWeekDto.
 @param newWeek
 @param newYear
 */
-(id)   init : (int) newWeek
     withYear: (int) newYear;

/*!
 @function getCalendarWeek
 Is called when a new CalendarWeekDto instance should be created based on the dictionary information.
 @param calendarWeekDictionary
 */
- (CalendarWeekDto *)getCalendarWeek:(NSDictionary *)calendarWeekDictionary;

@end
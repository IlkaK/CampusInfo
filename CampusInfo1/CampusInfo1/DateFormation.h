/*
 DateFormation.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header DateFormation.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Provides date formatter constants. </li>
 *      <li> Provides methods to format strings to dates. </li>
 *  </ul>
 * </li>
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives strings to format into dates. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It sends back the formatted dates. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */


#import <Foundation/Foundation.h>

@interface DateFormation : NSObject
{
    /*! @var _dayFormatter Holds the date formatter to format days */
    NSDateFormatter *_dayFormatter;
    /*! @var _englishDayFormatter Holds the date formatter to format days in english format */
    NSDateFormatter *_englishDayFormatter;
    /*! @var _weekDayFormatter Holds the date formatter to format week days */
    NSDateFormatter *_weekDayFormatter;
    /*! @var _timeFormatter Holds the date formatter to format time */
    NSDateFormatter *_timeFormatter;
    /*! @var _minutesAndSecondsFormatter Holds the date formatter to format time with minutes and seconds */
    NSDateFormatter *_minutesAndSecondsFormatter;
    /*! @var _englishTimeAndDayFormatter Holds the date formatter to format dates in english date and time formats */
    NSDateFormatter *_englishTimeAndDayFormatter;
}

@property (nonatomic, retain) NSDateFormatter *_dayFormatter;
@property (nonatomic, retain) NSDateFormatter *_weekDayFormatter;
@property (nonatomic, retain) NSDateFormatter *_timeFormatter;
@property (nonatomic, retain) NSDateFormatter *_minutesAndSecondsFormatter;
@property (nonatomic, retain) NSDateFormatter *_englishDayFormatter;
@property (nonatomic, retain) NSDateFormatter *_englishTimeAndDayFormatter;

/*!
 @function init
 Initialization of the date formatters.
 */
- (id) init;

/*!
 @function parseDate
 Parses the given string into date.
 @param dateString
 */
- (NSDate *) parseDate:(NSString *)dateString;

/*!
 @function parseTime
 Parses the given string into time.
 @param dateString
 */
- (NSDate *) parseTime:(NSString *)dateString;

/*!
 @function parseMinutesAndSeconds
 Parses the given string into minutes and seconds (former format 00:00:00).
 @param dateString
 */
- (NSDate *) parseMinutesAndSeconds:(NSString *)dateString;

/*!
 @function parseDateFromXMLString
 Parses the given xml string into date.
 @param dateString
 */
- (NSDate *) parseDateFromXMLString:(NSString *)dateString;

@end

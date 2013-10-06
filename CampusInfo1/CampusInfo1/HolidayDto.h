/*
 HolidayDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header HolidayDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the holiday data in MensaOverviewDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives holiday id, name, version, start and end date to be initally set or a dictionary to browse the data itself. </li>
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
#import "DateFormation.h"

@interface HolidayDto : NSObject
{
    /*! @var _holidayId Stores the id of the holiday */
    int               _holidayId;
    /*! @var _name Holds the name of the holiday */
    NSString         *_name;
    /*! @var _version Holds the version of the holiday */
    NSString         *_version;
    /*! @var _startsAt Holds the start date of the holiday */
    NSDate           *_startsAt;
    /*! @var _endsAt Holds the end date of the holiday */
    NSDate           *_endsAt;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation    *_dateFormatter;
}

@property (nonatomic, assign) int               _holidayId;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSString          *_version;
@property (nonatomic, retain) NSDate            *_startsAt;
@property (nonatomic, retain) NSDate            *_endsAt;
@property (nonatomic, retain) DateFormation     *_dateFormatter;

/*!
 @function init
 Initializes HolidayDto.
 @param newHolidayId
 @param newName
 @param newVersion
 @param newStartsAt
 @param newEndsAt
 */
-(id)                   init: (int) newHolidayId
                    withName: (NSString *)newName
                 withVersion: (NSString *)newVersion
                withStartsAt: (NSDate *)newStartsAt
                  withEndsAt: (NSDate *)newEndsAt;

/*!
 @function getHoliday
 Is called when a new HolidayDto instance should be created based on the dictionary information.
 @param holidayDictionary
 */
- (HolidayDto *)getHoliday:(NSDictionary *)holidayDictionary;

@end
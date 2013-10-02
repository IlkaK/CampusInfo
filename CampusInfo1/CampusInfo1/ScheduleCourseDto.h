/*
 ScheduleCourseDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ScheduleCourseDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for ScheduleCourse in TimeTableDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives name and description to be initally set or a dictionary to browse the data itself. </li>
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

@interface ScheduleCourseDto : NSObject 
{
    /*! @var _name Stores the name of the scheduleCourse */
    NSString  *_name;
    /*! @var _description Stores the description of the scheduleCourse */
    NSString  *_description;
}

@property (nonatomic, retain) NSString  *_name;
@property (nonatomic, retain) NSString  *_description;

/*!
 @function init
 Needs to be called initally, when instance of ScheduleCourseDto is created.
 @param newName
 @param newDescription
 */
-(id) init 
: (NSString *) newName
: (NSString *) newDescription;

/*!
 @function getScheduleCourseWithDictionary
 Is called when a new ScheduleCourseDto instance should be created based on the dictionary information.
 @param dictionary
 @param key
 */
- (ScheduleCourseDto *) getScheduleCourseWithDictionary:(NSDictionary *)dictionary withKey:(id) key;


@end

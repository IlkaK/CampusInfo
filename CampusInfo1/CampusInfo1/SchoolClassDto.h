/*
 SchoolClassDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SchoolClassDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for SchoolClass in TimeTableDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives a name to be initally set or a dictionary to browse the name itself. </li>
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


@interface SchoolClassDto : NSObject
{
    /*! @var _name Stores the name of the school class */
    NSString  *_name; 
}

@property (nonatomic, retain) NSString  *_name;

/*!
 @function init
 Needs to be called initally, when instance of SchoolClassDto is created.
 @param newName
 */
- (id) init : (NSString  *) newName;

/*!
 @function getClassWithDictionary
 Is called when a new SchoolClassDto instance should be created based on the scheduleDictionary information.
 @param scheduleDictionary
 @param scheduleKey
 */
- (SchoolClassDto *) getClassWithDictionary:(NSDictionary *)scheduleDictionary withKey:(id) scheduleKey;

@end

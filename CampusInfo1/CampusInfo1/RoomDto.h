/*
 RoomDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header RoomDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for Room in TimeTableDto model. </li>
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


@interface RoomDto : NSObject
{
    /*! @var _name Stores the name of the room */
    NSString  *_name; 
}

@property (nonatomic, retain) NSString  *_name;

/*!
 @function init
 Needs to be called initally, when instance of RoomDto is created.
 @param newName
 */
- (id) init : (NSString  *) newName;

/*!
 @function getRoomWithDictionary
 Is called when a new RoomDto instance should be created based on the dictionary information.
 @param dictionary
 @param key
 */
- (RoomDto *) getRoomWithDictionary:(NSDictionary *)dictionary withScheduleKey:(id) key;

@end

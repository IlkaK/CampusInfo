/*
 RoomDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header RoomDto.m
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


#import "RoomDto.h"


@implementation RoomDto
@synthesize _name;

/*!
 @function init
 Needs to be called initally, when instance of RoomDto is created.
 @param newName
 */
-(id) init : (NSString  *) newName
{
    self = [super init];
    if (self) {
        self._name = newName;
    }
    return self;
}


/*!
 @function getRoomWithDictionary
 Is called when a new RoomDto instance should be created based on the dictionary information.
 @param dictionary
 @param key
 */
- (RoomDto *) getRoomWithDictionary:(NSDictionary *)dictionary withScheduleKey:(id) key
{
    RoomDto       *_localRoom      = nil;
    NSString      *_localName      = nil;
    NSDictionary  *_roomDictionary = [dictionary objectForKey:key];
    
    if (_roomDictionary != (id)[NSNull null])
    {
        for (id roomKey in _roomDictionary)
        {
            if ([roomKey isEqualToString:@"name"]) {
                _localName = [_roomDictionary objectForKey:roomKey];
            }
        }
        _localRoom    = [[RoomDto alloc]init:_localName];
    }
    return _localRoom;
}


@end

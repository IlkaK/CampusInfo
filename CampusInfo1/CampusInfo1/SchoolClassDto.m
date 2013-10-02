/*
 SchoolClassDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SchoolClassDto.m
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


#import "SchoolClassDto.h"


@implementation SchoolClassDto 
@synthesize _name;


/*!
 @function init
 Needs to be called initally, when instance of SchoolClassDto is created.
 @param newName
 */
-(id) init  : (NSString  *) newName
{
     self = [super init];
     if (self) {
         self._name = newName;
     }
     return self;
}

/*!
 @function getClassWithDictionary
 Is called when a new SchoolClassDto instance should be created based on the scheduleDictionary information.
 @param scheduleDictionary
 @param scheduleKey
 */
- (SchoolClassDto *) getClassWithDictionary:(NSDictionary *)scheduleDictionary withKey:(id) scheduleKey
{
    SchoolClassDto *_localClass      = nil;
    NSString       *_className       = nil;
    NSDictionary   *_classDictionary = nil;
    
    if (scheduleKey == nil)
    {
        _classDictionary = scheduleDictionary;
    }
    else
    {
        _classDictionary = [scheduleDictionary objectForKey:scheduleKey];
    }
    
    if (_classDictionary != (id)[NSNull null])
    {
        for (id classKey in _classDictionary)
        {
            if ([classKey isEqualToString:@"name"]) {
                _className = [_classDictionary objectForKey:classKey];
            }
        }
        _localClass = [[SchoolClassDto alloc]init:_className];
    }
    return _localClass;
}

@end

/*
 ScheduleCourseDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ScheduleCourseDto.m
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


#import "ScheduleCourseDto.h"

@implementation ScheduleCourseDto

@synthesize _name, _description;

/*!
 @function init
 Needs to be called initally, when instance of ScheduleCourseDto is created.
 @param newName
 @param newDescription
 */
-(id) init 
: (NSString *) newName
: (NSString *) newDescription
{
    self = [super init];
    if (self) {
        self._name        = newName;
        self._description = newDescription;
    }
    return self;
}

/*!
 @function getScheduleCourseWithDictionary
 Is called when a new ScheduleCourseDto instance should be created based on the dictionary information.
 @param dictionary
 @param key
 */
- (ScheduleCourseDto *) getScheduleCourseWithDictionary:(NSDictionary *)dictionary withKey:(id) key
{
    ScheduleCourseDto *_localCourse       = nil;
    NSString          *_courseName        = nil;
    NSString          *_courseDescription = nil;
    NSDictionary      *_courseDictionary  = [dictionary objectForKey:key];
    
    if (_courseDictionary != (id)[NSNull null])
    {
        for (id courseKey in _courseDictionary)
        {
            if ([courseKey isEqualToString:@"name"])
            {
                _courseName        = [_courseDictionary objectForKey:courseKey];
            }
            if ([courseKey isEqualToString:@"description"])
            {
                _courseDescription = [_courseDictionary objectForKey:courseKey];
            }
            
        }
        _localCourse    = [[ScheduleCourseDto alloc]init:_courseName:_courseDescription];
    }
    return _localCourse;
}



@end

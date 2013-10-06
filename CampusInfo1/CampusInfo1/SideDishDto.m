/*
 SideDishDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SideDishDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the side dish data in MensaMenuDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives side dish id, name and version to be initally set or a dictionary to browse the data itself. </li>
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

#import "SideDishDto.h"

@implementation SideDishDto
@synthesize _name;
@synthesize _sideDishId;
@synthesize _version;

/*!
 @function init
 Initializes SideDishDto.
 @param newSideDishId
 @param newVersion
 */
-(id)   init : (int) newSideDishId
     withName: (NSString *)newName
  withVersion: (NSString *)newVersion
{
    self = [super init];
    if (self)
    {
        self._sideDishId   = newSideDishId;
        self._name         = newName;
        self._version      = newVersion;
    }
    return self;
}

/*!
 @function getSideDish
 Is called when a new SideDishDto instance should be created based on the dictionary information.
 @param sideDishDictionary
 */
- (SideDishDto *)getSideDish:(NSDictionary *)sideDishDictionary
{
    SideDishDto *_localSideDish = [[SideDishDto alloc]init:0 withName:nil withVersion:nil];
    int         _localSideDishId;
    NSString    *_localSideDishName;
    NSString    *_localSideDishVersion;
    
    for (id sideDishKey in sideDishDictionary)
    {
        //NSLog(@"sideDishKey key: %@ value: %@", sideDishKey, [_sideDishDictionary objectForKey:sideDishKey]);
        if ([sideDishKey isEqualToString:@"id"])
        {
            _localSideDishId = [[sideDishDictionary objectForKey:sideDishKey] intValue];
            //NSLog(@"_localSideDishId: %i", _localSideDishId);
        }
        if ([sideDishKey isEqualToString:@"name"])
        {
            _localSideDishName = [sideDishDictionary objectForKey:sideDishKey];
            //NSLog(@"_localSideDishName: %@", _localSideDishName);
        }
        if ([sideDishKey isEqualToString:@"version"])
        {
            _localSideDishVersion = [sideDishDictionary objectForKey:sideDishKey];
            //NSLog(@"_localSideDishVersion: %@", _localSideDishVersion);
        }
    }
    _localSideDish = [_localSideDish init:_localSideDishId
                                 withName:_localSideDishName
                              withVersion:_localSideDishVersion];
    return _localSideDish;
}

@end

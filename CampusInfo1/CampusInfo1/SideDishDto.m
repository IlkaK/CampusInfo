//
//  SideDishDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 23.07.13.
//
//

#import "SideDishDto.h"

@implementation SideDishDto
@synthesize _name;
@synthesize _sideDishId;
@synthesize _version;


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

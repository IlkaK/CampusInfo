//
//  SchoolClassDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SchoolClassDto.h"


@implementation SchoolClassDto 
@synthesize _name;

-(id) init  : (NSString  *) newName
{
     self = [super init];
     if (self) {
         self._name = newName;
     }
     return self;
}

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

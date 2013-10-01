//
//  RoomDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomDto.h"


@implementation RoomDto
@synthesize _name;

-(id) init : (NSString  *) newName
{
    self = [super init];
    if (self) {
        self._name = newName;
    }
    return self;
}


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

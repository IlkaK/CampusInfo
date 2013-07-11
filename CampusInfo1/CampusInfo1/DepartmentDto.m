//
//  DepartmentDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DepartmentDto.h"


@implementation DepartmentDto
@synthesize _name;

-(id) init : (NSString  *) newName
{
    self = [super init];
    if (self)
    {
        self._name = newName;
    }
    return self;
}


- (DepartmentDto *)getDepartmentWithDictionary:(NSDictionary *)dictionary withPersonKey:(id)key
{
    DepartmentDto *_localDepartment      = nil;
    NSString      *_localName            = nil;
    NSDictionary  *_departmentDictionary = [dictionary objectForKey:key];
    
    for (id departmentKey in _departmentDictionary)
    {
        if ([departmentKey isEqualToString:@"name"])
        {
            _localName = [_departmentDictionary objectForKey:departmentKey];
            //NSLog(@"department name: %@",_name);
        }
    } // end loop over keys
    _localDepartment    = [[DepartmentDto alloc]init:_localName];
    return _localDepartment;
}

@end

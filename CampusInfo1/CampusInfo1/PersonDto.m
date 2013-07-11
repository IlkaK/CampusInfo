//
//  PersonDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PersonDto.h"
#import "DepartmentDto.h"


@implementation PersonDto

@synthesize _shortName, _firstName, _lastName, _type, _department;

-(id) init 
: (NSString      *) newShortName
: (NSString      *) newFirstName
: (NSString      *) newLastName
: (NSString      *) newType
: (DepartmentDto *) newDepartment
{
    self = [super init];
    if (self) {
        self._shortName  = newShortName;
        self._firstName  = newFirstName;
        self._lastName   = newLastName;
        self._type       = newType;
        self._department = newDepartment;

    }
    return self;
}


- (PersonDto *) getPersonWithDictionary:(NSDictionary *)dictionary withKey:(id) key
{
    PersonDto     *_localPerson      = nil;
    NSString      *_localFirstName        = nil;
    NSString      *_localLastName         = nil;
    NSString      *_localShortName        = nil;
    NSString      *_localPersonType       = nil;
    DepartmentDto *_localDepartment       = [[DepartmentDto alloc]init:nil];;
    NSDictionary  *_personDictionary = nil;
    
    if (key == nil)
    {
        _personDictionary = dictionary;
        //NSLog(@"key is NIL");
    }
    else
    {
        _personDictionary = [dictionary objectForKey:key];
        //NSLog(@"key is NOT nil");
    }
    
    if (_personDictionary != (id)[NSNull null])
    {
        for (id personKey in _personDictionary) {
            
            //NSLog(@"personKey: %@", personKey);
            if ([personKey isEqualToString:@"firstName"]) {
                _localFirstName = [_personDictionary objectForKey:personKey];
                //NSLog(@"_firstName: %@",_firstName);
            }
            
            if ([personKey isEqualToString:@"lastName"]) {
                _localLastName = [_personDictionary objectForKey:personKey];
                //NSLog(@"_lastName: %@",_lastName);
            }
            if ([personKey isEqualToString:@"shortName"]) {
                _localShortName = [_personDictionary objectForKey:personKey];
                //NSLog(@"_shortName: %@",_shortName);
            }
            
            if ([personKey isEqualToString:@"type"]) {
                _localPersonType = [_personDictionary objectForKey:personKey];
                //NSLog(@"_shortName: %@",_personType);
            }
            
            if ([personKey isEqualToString:@"department"]) {
                if ([_personDictionary objectForKey:personKey] != (id)[NSNull null])
                {
                    _localDepartment = [_localDepartment getDepartmentWithDictionary:_personDictionary withPersonKey:personKey];
                    //NSLog(@"_department._name: %@",_localDepartment._name);
                }
            }
            
        } // end loop over keys
    }
    _localPerson    = [[PersonDto alloc]init:_localShortName:_localFirstName:_localLastName: _localPersonType :_localDepartment];
    //NSLog(@"localPerson: %@", _localPerson._shortName);
    return _localPerson;
}



@end


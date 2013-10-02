/*
 PersonDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header PersonDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for Person in TimeTableDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives shortName, firstName, lastName, type and department to be initally set or a dictionary to browse the data itself. </li>
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
#import "PersonDto.h"
#import "DepartmentDto.h"


@implementation PersonDto

@synthesize _shortName, _firstName, _lastName, _type, _department;

/*!
 @function init
 Needs to be called initally, when instance of PersonDto is created.
 @param newShortName
 @param newFirstName
 @param newLastName
 @param newType
 @param newDepartment
 */
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

/*!
 @function getPersonWithDictionary
 Is called when a new PersonDto instance should be created based on the dictionary information.
 @param dictionary
 @param key
 */
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
        } 
    }
    _localPerson    = [[PersonDto alloc]init:_localShortName:_localFirstName:_localLastName: _localPersonType :_localDepartment];
    //NSLog(@"localPerson: %@", _localPerson._shortName);
    return _localPerson;
}



@end


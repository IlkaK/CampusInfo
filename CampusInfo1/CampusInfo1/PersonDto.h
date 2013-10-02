/*
 PersonDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header PersonDto.h
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

#import <Foundation/Foundation.h>

@class DepartmentDto;

@interface PersonDto : NSObject
{
    /*! @var _shortName Stores the short name (acronym) of the person */
    NSString      *_shortName;
    /*! @var _firstName Stores the first name of the person */
    NSString      *_firstName;
    /*! @var _lastName Stores the last name of the person */
    NSString      *_lastName;
    /*! @var _type Stores the type of the person */
    NSString      *_type;
    /*! @var _type Stores the department of the person */
    DepartmentDto *_department; 
}

@property (nonatomic, retain) NSString      *_shortName;
@property (nonatomic, retain) NSString      *_firstName;
@property (nonatomic, retain) NSString      *_lastName;
@property (nonatomic, retain) NSString      *_type;
@property (nonatomic, retain) DepartmentDto *_department;

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
: (NSString       *) newShortName
: (NSString       *) newFirstName
: (NSString       *) newLastName
: (NSString       *) newType
: (DepartmentDto  *) newDepartment;

/*!
 @function getPersonWithDictionary
 Is called when a new PersonDto instance should be created based on the dictionary information.
 @param dictionary
 @param key
 */
- (PersonDto *) getPersonWithDictionary:(NSDictionary *)dictionary withKey:(id) key;

@end

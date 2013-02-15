//
//  PersonDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DepartmentDto;

@interface PersonDto : NSObject {
    NSString      *_shortName; 
    NSString      *_firstName;
    NSString      *_lastName;
    NSString      *_type;
    DepartmentDto *_department; 
    
}

@property (nonatomic, retain) NSString      *_shortName;
@property (nonatomic, retain) NSString      *_firstName;
@property (nonatomic, retain) NSString      *_lastName;
@property (nonatomic, retain) NSString      *_type;
@property (nonatomic, retain) DepartmentDto *_department;


-(id) init 
: (NSString       *) newShortName
: (NSString       *) newFirstName
: (NSString       *) newLastName
: (NSString       *) newType
: (DepartmentDto  *) newDepartment;

@end

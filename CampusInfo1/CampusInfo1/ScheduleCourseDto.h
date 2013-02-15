//
//  ScheduleCourseDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleCourseDto : NSObject 
{
    NSString  *_name; 
    NSString  *_description;
}

@property (nonatomic, retain) NSString  *_name;
@property (nonatomic, retain) NSString  *_description;

-(id) init 
: (NSString *) newName
: (NSString *) newDescription;



@end

//
//  DBCachingForAutocomplete.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.07.13.
//
//

#import <Foundation/Foundation.h>

#import "/usr/include/sqlite3.h"

@interface DBCachingForAutocomplete : NSObject
{
    // DB handling
    NSString        *_timeTableDBPath;
}

@property (nonatomic, retain) NSString *_timeTableDBPath;

-(id) init;

-(void) storeLecturers:(NSMutableArray *)lecturerArray;
-(NSMutableArray *)getLecturers;

-(void) storeRooms:(NSMutableArray *)roomArray;
-(NSMutableArray *) getRooms;

-(void) storeClasses:(NSMutableArray *)classArray;
-(NSMutableArray *) getClasses;

-(void) storeCourses:(NSMutableArray *)coursesArray;
-(NSMutableArray *) getCourses;

-(void) storeStudents:(NSMutableArray *)studentsArray;
-(NSMutableArray *) getStudents;

@end

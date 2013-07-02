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
    sqlite3         *_timeTableNamesDB;
    NSString        *_timeTableDBPath;
}

//@property (nonatomic, retain) sqlite3 *_timeTableNamesDB;
@property (nonatomic, retain) NSString *_timeTableDBPath;

-(id) init;

-(void) storeLecturers:(NSMutableArray *)lecturerArray;
-(NSMutableArray *)getLecturers;


@end

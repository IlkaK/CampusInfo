//
//  DBCachingForAutocomplete.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.07.13.
//
//

#import "DBCachingForAutocomplete.h"

@implementation DBCachingForAutocomplete

@synthesize _timeTableDBPath;


-(void) createTableWithName:(NSString *)tableName
                     withDB:(sqlite3  *)sqlite3DB
{
    char         *_errMsg;
    sqlite3_stmt *_sqlite3stmt = nil;
    int operationResult;
    
    //NSString    *_dropStmtString = [NSString stringWithFormat:@"drop table if exists %@;", tableName];
    //const char  *_dropStmtChar   = [_dropStmtString UTF8String];
    
    //if (sqlite3_exec(sqlite3DB, _dropStmtChar , NULL, NULL, &_errMsg) != SQLITE_OK)
    //{
    //    NSLog(@"Failed to drop table %@ with statement: %@", tableName, _dropStmtString);
    //}
    //else
    //{
     //   NSLog(@"Dropped %@ table successfully", tableName);
    //}
    //operationResult = sqlite3_step(_sqlite3stmt);
    //sqlite3_finalize(_sqlite3stmt);
    

    NSString *_stmtString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT)",tableName];
    const char *_stmtChar = [_stmtString UTF8String];
    
    if (sqlite3_exec(sqlite3DB, _stmtChar , NULL, NULL, &_errMsg) != SQLITE_OK)
    {
        NSLog(@"Failed to create table %@ with statement: %@", tableName, _stmtString);
    }
    //else
    //{
    //    NSLog(@"Created %@ table successfully", tableName);
    //}
    operationResult = sqlite3_step(_sqlite3stmt);
    sqlite3_finalize(_sqlite3stmt);
}


-(id) init
{
    // DB for caching autocomplete data
    NSArray  *_dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *_docsDir  = [_dirPaths objectAtIndex:0];

    // Build the path to the database file
    _timeTableDBPath = [[NSString alloc]
                    initWithString: [_docsDir stringByAppendingPathComponent:
                                     @"timetablenames.db"]];

    sqlite3         *_timeTableNamesDB;

    if (sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
    {
        [self createTableWithName:@"LECTURER"   withDB:_timeTableNamesDB];
        [self createTableWithName:@"ROOMS"      withDB:_timeTableNamesDB];
        [self createTableWithName:@"CLASSES"    withDB:_timeTableNamesDB];
        [self createTableWithName:@"COURSES"    withDB:_timeTableNamesDB];
        [self createTableWithName:@"STUDENTS"   withDB:_timeTableNamesDB];
        [self createTableWithName:@"START_STATIONS" withDB:_timeTableNamesDB];
        [self createTableWithName:@"STOP_STATIONS"  withDB:_timeTableNamesDB];
        sqlite3_close(_timeTableNamesDB);
    }
    else
    {
        NSLog(@"Failed to open/create database");
    }
    return self;
}


-(void) storeOnTable:(NSString *)tableName
           withArray:(NSMutableArray *)arrayToStore
{
    sqlite3_stmt    *_statement;
    sqlite3         *_timeTableNamesDB;
    
    if (sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
    {
        int      arrayToStoreI;
        NSString *_nameToStore;
        NSString *_insertSQL;
        NSString *_deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
        
        // delete first
        sqlite3_prepare_v2(_timeTableNamesDB, [_deleteSQL UTF8String], -1, &_statement, NULL);
        if (sqlite3_step(_statement) != SQLITE_DONE)
        {
            NSLog(@"Failed to delete %@ with statement: %d",tableName, sqlite3_step(_statement));
        }
        sqlite3_finalize(_statement);
        
        // then insert again
        for (arrayToStoreI = 0; arrayToStoreI < [arrayToStore count]; arrayToStoreI++)
        {
            _nameToStore = [arrayToStore objectAtIndex:arrayToStoreI];
            _insertSQL = [NSString stringWithFormat:@"INSERT INTO %@ (name, shortname) VALUES (\"%@\")",tableName, _nameToStore];
            
            sqlite3_prepare_v2(_timeTableNamesDB, [_insertSQL UTF8String],-1, &_statement, nil);
            
            if (sqlite3_step(_statement) != SQLITE_DONE)
            {
                NSLog(@"Failed to add to %@: %@ with statement: %d", tableName, _nameToStore, sqlite3_step(_statement));
            }
            sqlite3_finalize(_statement);            
        }
        sqlite3_close(_timeTableNamesDB);
    }
}


-(void) addToTable:(NSString *)tableName
        withString:(NSString *)stringToStore
{
    sqlite3_stmt    *_statement;
    sqlite3         *_timeTableNamesDB;
    
    if (sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
    {
        NSString *_insertSQL = [NSString stringWithFormat:@"INSERT INTO %@ (name, shortname) VALUES (\"%@\")",tableName, stringToStore];
            
        sqlite3_prepare_v2(_timeTableNamesDB, [_insertSQL UTF8String],-1, &_statement, nil);
            
        if (sqlite3_step(_statement) != SQLITE_DONE)
        {
            NSLog(@"Failed to add to %@: %@ with statement: %d", tableName, stringToStore, sqlite3_step(_statement));
        }
        sqlite3_finalize(_statement);
        sqlite3_close(_timeTableNamesDB);
    }
}


-(NSMutableArray *)getNamesFromTable:(NSString *)tableName
{
    NSMutableArray  *_nameArray = [[NSMutableArray alloc] init];
    sqlite3         *_timeTableNamesDB;
    
    if(sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
    {
        NSString    *_sqlStmtString = [NSString stringWithFormat:@"select * from %@;", tableName];
        const char  *_sqlStmtChar   = [_sqlStmtString UTF8String];
        
        sqlite3_stmt    *_compiledStatement;
        NSString        *_namesFromTable;
        
        if(sqlite3_prepare_v2(_timeTableNamesDB, _sqlStmtChar, -1, &_compiledStatement, NULL) == SQLITE_OK)
        {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(_compiledStatement) == SQLITE_ROW)
            {
                _namesFromTable = [NSString stringWithUTF8String:(char *)sqlite3_column_text(_compiledStatement, 1)];
                [_nameArray addObject:_namesFromTable];
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(_compiledStatement);
        sqlite3_close(_timeTableNamesDB);
    }
    //NSLog(@"_nameArray count: %i", [_nameArray count]);
    return _nameArray;
}


-(void) storeLecturers:(NSMutableArray *)lecturerArray
{
    [self storeOnTable:@"LECTURER" withArray:lecturerArray];
}

-(NSMutableArray *)getLecturers
{
    return [self getNamesFromTable:@"LECTURER"];
}


-(void) storeRooms:(NSMutableArray *)roomArray
{
    //NSLog(@"storeRooms START");
    [self storeOnTable:@"ROOMS" withArray:roomArray];
    //NSLog(@"storeRooms FINISHED");
}

-(NSMutableArray *) getRooms
{
    //NSLog(@"getRooms");
    return [self getNamesFromTable:@"ROOMS"];
}


-(void) storeClasses:(NSMutableArray *)classArray
{
    [self storeOnTable:@"CLASSES" withArray:classArray];
}

-(NSMutableArray *)getClasses
{
    return [self getNamesFromTable:@"CLASSES"];
}


-(void) storeCourses:(NSMutableArray *)coursesArray
{
    [self storeOnTable:@"COURSES" withArray:coursesArray];
}

-(NSMutableArray *)getCourses
{
    return [self getNamesFromTable:@"COURSES"];
}

-(void) storeStudents:(NSMutableArray *)studentsArray
{
    [self storeOnTable:@"STUDENTS" withArray:studentsArray];
}

-(NSMutableArray *)getStudents
{
    return [self getNamesFromTable:@"STUDENTS"];
}


// public transportation
-(NSMutableArray *)getStartStations
{
    return [self getNamesFromTable:@"START_STATIONS"];
}

-(void) addStartStation:(NSString *)startStation
{
    [self addToTable:@"START_STATIONS" withString:startStation];
}


-(NSMutableArray *)getStopStations
{
    return [self getNamesFromTable:@"STOP_STATIONS"];
}

-(void) addStopStation:(NSString *)stopStation
{
    [self addToTable:@"STOP_STATIONS" withString:stopStation];
}


@end

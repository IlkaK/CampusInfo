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

-(id) init 
{

    // DB for caching autocomplete data
    NSArray *_dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *_docsDir = [_dirPaths objectAtIndex:0];


    // Build the path to the database file
    _timeTableDBPath = [[NSString alloc]
                    initWithString: [_docsDir stringByAppendingPathComponent:
                                     @"timetablenames.db"]];

    sqlite3         *_timeTableNamesDB;

    //NSFileManager *filemgr = [NSFileManager defaultManager];

    //if ([filemgr fileExistsAtPath: _timeTableDBPath ] == NO)
    //{
        if (sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
        {
            char *errMsg;
        
            if (sqlite3_exec(_timeTableNamesDB, "CREATE TABLE IF NOT EXISTS LECTURER (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, SHORTNAME TEXT)", NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table LECTURER");
            }
            else
            {
                NSLog(@"Created Lecturer table successfully");
            }
            
            if (sqlite3_exec(_timeTableNamesDB, "CREATE TABLE IF NOT EXISTS ROOMS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT)", NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table ROOMS");
            }
            else
            {
                NSLog(@"Created Rooms table successfully");
            }
            sqlite3_close(_timeTableNamesDB);
        }
        else
        {
            NSLog(@"Failed to open/create database");
        }
    return self;
}


-(void) storeLecturers:(NSMutableArray *)lecturerArray
{
    sqlite3_stmt    *_statement;
    sqlite3         *_timeTableNamesDB;

    //sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB);
    
    if (sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
    {
        int lecturerArrayI;
        NSString *_lecturerShortName;
        NSString *_insertSQL;
        NSString *_deleteSQL = [NSString stringWithFormat:@"DELETE FROM LECTURER"];
    
        //NSLog(@"first item: %@", [_lecturerArray objectAtIndex:0]);
        //NSLog(@"last item: %@", [_lecturerArray objectAtIndex:[_lecturerArray count]-1]);
    
        sqlite3_prepare_v2(_timeTableNamesDB, [_deleteSQL UTF8String], -1, &_statement, NULL);
        if (sqlite3_step(_statement) != SQLITE_DONE)
        {
            NSLog(@"Failed to delete lecturer with statement: %d", sqlite3_step(_statement));
        }
    
        sqlite3_finalize(_statement);
    
        for (lecturerArrayI = 0; lecturerArrayI < [lecturerArray count]; lecturerArrayI++)
        {
            _lecturerShortName = [lecturerArray objectAtIndex:lecturerArrayI];
            _insertSQL = [NSString stringWithFormat:
                      @"INSERT INTO LECTURER (name, shortname) VALUES (\"%@\", \"%@\")",
                      _lecturerShortName, _lecturerShortName];
            
            //NSLog(@"insert statement: %@ ", _insertSQL);
            
            sqlite3_prepare_v2(_timeTableNamesDB, [_insertSQL UTF8String],-1, &_statement, nil);
                        
            if (sqlite3_step(_statement) != SQLITE_DONE)
            {
                NSLog(@"Failed to add lecturer: %@ with statement: %d", _lecturerShortName, sqlite3_step(_statement));
            }
            sqlite3_finalize(_statement);
            

        }
        sqlite3_close(_timeTableNamesDB);
    }
}

-(NSMutableArray *)getLecturers
{
    NSMutableArray *_lecturerArray = [[NSMutableArray alloc] init];
    sqlite3         *_timeTableNamesDB;

    if(sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
    {
        const char      *_sqlStatement = "select * from lecturer";
        sqlite3_stmt    *_compiledStatement;
        NSString        *_lecturerShortName;
        
        if(sqlite3_prepare_v2(_timeTableNamesDB, _sqlStatement, -1, &_compiledStatement, NULL) == SQLITE_OK)
        {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(_compiledStatement) == SQLITE_ROW)
            {
                _lecturerShortName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(_compiledStatement, 1)];
                [_lecturerArray addObject:_lecturerShortName];
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(_compiledStatement);
        sqlite3_close(_timeTableNamesDB);
    }
    //NSLog(@"_lecturerArray count: %i", [_lecturerArray count]);
    return _lecturerArray;
}


-(void) storeRooms:(NSMutableArray *)roomArray
{
    NSLog(@"storeRooms START");
    sqlite3_stmt    *_statement;
    sqlite3         *_timeTableNamesDB;

    if (sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
    {
        int roomArrayI;
        NSString *_roomName;
        NSString *_insertSQL;
        NSString *_deleteSQL = [NSString stringWithFormat:@"DELETE FROM ROOMS"];
        
        //NSLog(@"first item: %@", [_lecturerArray objectAtIndex:0]);
        //NSLog(@"last item: %@", [_lecturerArray objectAtIndex:[_lecturerArray count]-1]);
        
        sqlite3_prepare_v2(_timeTableNamesDB, [_deleteSQL UTF8String], -1, &_statement, 0);
        
        if (sqlite3_step(_statement) != SQLITE_DONE)
        {
            NSLog(@"Failed to delete rooms");
        }
        sqlite3_finalize(_statement);
        
        
        for (roomArrayI = 0; roomArrayI < [roomArray count]; roomArrayI++)
        {
            _roomName = [roomArray objectAtIndex:roomArrayI];
            _insertSQL = [NSString stringWithFormat:
                          @"INSERT INTO ROOMS (name) VALUES (\"%@\")",
                          _roomName];
            
            //NSLog(@"insert statement: %@ ", _insertSQL);
            
            sqlite3_prepare_v2(_timeTableNamesDB, [_insertSQL UTF8String],-1, &_statement, 0);
            
            if (sqlite3_step(_statement) != SQLITE_DONE)
            {
                NSLog(@"Failed to add room: %@ with statement: %d", _roomName, sqlite3_step(_statement));
            }
            sqlite3_finalize(_statement);
        }
    sqlite3_close(_timeTableNamesDB);        
    }
    NSLog(@"storeRooms FINISHED");
}

-(NSMutableArray *) getRooms
{
    NSLog(@"getRooms START");
    NSMutableArray *_roomArray = [[NSMutableArray alloc] init];
    sqlite3         *_timeTableNamesDB;

    if(sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
    {
        const char      *_sqlStatement = "select * from rooms";
        sqlite3_stmt    *_compiledStatement;
        NSString        *_roomName;
        
        if(sqlite3_prepare_v2(_timeTableNamesDB, _sqlStatement, -1, &_compiledStatement, 0) == SQLITE_OK)
        {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(_compiledStatement) == SQLITE_ROW)
            {
                _roomName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(_compiledStatement, 1)];
                [_roomArray addObject:_roomName];
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(_compiledStatement);
        sqlite3_close(_timeTableNamesDB);
    }
//    NSLog(@"_roomArray count: %i", [_roomArray count]);
    NSLog(@"getRooms FINISHED");

    return _roomArray;
}


@end

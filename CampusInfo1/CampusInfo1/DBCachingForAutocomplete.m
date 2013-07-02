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
    NSString *docsDir;
    NSArray *dirPaths;

    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];

    // Build the path to the database file
    _timeTableDBPath = [[NSString alloc]
                    initWithString: [docsDir stringByAppendingPathComponent:
                                     @"timetablenames.db"]];

    NSFileManager *filemgr = [NSFileManager defaultManager];

    if ([filemgr fileExistsAtPath: _timeTableDBPath ] == NO)
    {
        if (sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS LECTURER (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, SHORTNAME TEXT)";
        
            if (sqlite3_exec(_timeTableNamesDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
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
            NSLog(@"Failed to delete contacts");
        }
    
        sqlite3_finalize(_statement);
    
        for (lecturerArrayI = 0; lecturerArrayI < [lecturerArray count]; lecturerArrayI++)
        {
            _lecturerShortName = [lecturerArray objectAtIndex:lecturerArrayI];
            _insertSQL = [NSString stringWithFormat:
                      @"INSERT INTO LECTURER (name, shortname) VALUES (\"%@\", \"%@\")",
                      _lecturerShortName, _lecturerShortName];
        
            sqlite3_prepare_v2(_timeTableNamesDB, [_insertSQL UTF8String],-1, &_statement, NULL);
            if (sqlite3_step(_statement) != SQLITE_DONE)
            {
                NSLog(@"Failed to add contact: %@", _lecturerShortName);
            }
            sqlite3_finalize(_statement);
        }
        sqlite3_close(_timeTableNamesDB);
    }
}

-(NSMutableArray *)getLecturers
{
    NSMutableArray *_lecturerArray = [[NSMutableArray alloc] init];
    
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
    }
    sqlite3_close(_timeTableNamesDB);
    NSLog(@"_lecturerArray count: %i", [_lecturerArray count]);
    return _lecturerArray;
}


@end

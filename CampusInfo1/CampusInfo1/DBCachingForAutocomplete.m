/*
 DBCachingForAutocomplete.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header DBCachingForAutocomplete.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Handling data which is stored to database or got from there. </li>
 *      <li> Stored data is: </li>
 *      <ul>
 *          <li> lecturer acronyms </li>
 *          <li> room acronyms </li>
 *          <li> class acronyms </li>
 *          <li> course acronyms </li>
 *          <li> student acronyms </li>
 *          <li> the three last used start stations </li>
 *          <li> all station suggestions  </li>
 *      </ul>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> To store the data in the according databases it receives the following arrays: </li>
 *      <ul>
 *          <li> lecturer acronyms </li>
 *          <li> room acronyms </li>
 *          <li> class acronyms </li>
 *          <li> course acronyms </li>
 *          <li> student acronyms </li>
 *      </ul>
 *   </ul>
 *      <li> To add item by item the following data is added item by item: </li>
 *      <ul>
 *          <li> the last used start station </li>
 *          <li> the last used stop station </li>
 *      </ul>
 *      <li> The database with station suggestions is already imported and is not changed here. </li>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> Depending on the caller class the demanded arrays are returned. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "DBCachingForAutocomplete.h"

@implementation DBCachingForAutocomplete

@synthesize _timeTableDBPath;
@synthesize _connectionDBPath;

/*!
 @function createTableWithName
 Creates a new tables with given table name, if it does not exist yet.
 */
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
    //operationResult = sqlite3_step(_sqlite3stmt);
    //sqlite3_finalize(_sqlite3stmt);
    

    NSString *_stmtString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT)",tableName];
    const char *_stmtChar = [_stmtString UTF8String];
    
    if (sqlite3_exec(sqlite3DB, _stmtChar , NULL, NULL, &_errMsg) != SQLITE_OK)
    {
        NSLog(@"Failed to create table %@ with statement: %@", tableName, _stmtString);
    }
    operationResult = sqlite3_step(_sqlite3stmt);
    sqlite3_finalize(_sqlite3stmt);
}

/*!
 @function init
 Initialization of the class.
 Create tables, if they did not exist yet and sets the path strings.
 */
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
        NSLog(@"Failed to open/create time table database");
    }
    
    // for stations / public transportation autocomplete
    _connectionDBPath = [[NSBundle mainBundle]pathForResource:@"stations" ofType:@"sql"];
    //NSLog(@"_connectionDBPath = %@", _connectionDBPath);
    
    sqlite3         *_stationsDB;
    
    if (sqlite3_open([_connectionDBPath UTF8String], &_stationsDB) == SQLITE_OK)
    {
        //NSLog(@"could open stations db");
        sqlite3_close(_stationsDB);
    }
    else
    {
        NSLog(@"Failed to open/create stations database");
    }
    return self;
}

/*!
 @function storeOnTable
 Inserts given array into table of given name.
 */
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

/*!
 @function deleteFromTable
 Deletes all data from table with given name.
 */
-(void) deleteFromTable:(NSString *)tableName
{
    sqlite3_stmt    *_statement;
    sqlite3         *_timeTableNamesDB;
    
    if (sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
    {
        NSString *_deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
        
        // delete first
        sqlite3_prepare_v2(_timeTableNamesDB, [_deleteSQL UTF8String], -1, &_statement, NULL);
        if (sqlite3_step(_statement) != SQLITE_DONE)
        {
            NSLog(@"Failed to delete %@ with statement: %d",tableName, sqlite3_step(_statement));
        }
        sqlite3_finalize(_statement);
        sqlite3_close(_timeTableNamesDB);
    }
}

/*!
 @function addToTable
 Inserts string into table for given name.
 */
-(void) addToTable:(NSString *)tableName
        withString:(NSString *)stringToStore
{
    sqlite3_stmt    *_statement;
    sqlite3         *_timeTableNamesDB;
    
    if (sqlite3_open([_timeTableDBPath UTF8String], &_timeTableNamesDB) == SQLITE_OK)
    {
        NSString *_insertSQL = [NSString stringWithFormat:@"INSERT INTO %@ (name) VALUES (\"%@\")",tableName, stringToStore];
            
        sqlite3_prepare_v2(_timeTableNamesDB, [_insertSQL UTF8String],-1, &_statement, nil);
            
        if (sqlite3_step(_statement) != SQLITE_DONE)
        {
            NSLog(@"Failed to add to %@: %@ with statement: %d", tableName, stringToStore, sqlite3_step(_statement));
        }
        sqlite3_finalize(_statement);
        sqlite3_close(_timeTableNamesDB);
    }
}

/*!
 @function getNamesFromTable
 Get all data into an arry from table with given name.
 */
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

/*!
 @function storeLecturers
 Stores the given array for lecturer acronyms.
 @param lecturerArray
 */
-(void) storeLecturers:(NSMutableArray *)lecturerArray
{
    [self storeOnTable:@"LECTURER" withArray:lecturerArray];
}

/*!
 @function getLecturers
 Returns an array of lecturer acronyms.
 */
-(NSMutableArray *)getLecturers
{
    return [self getNamesFromTable:@"LECTURER"];
}

/*!
 @function storeRooms
 Stores the given array for room acronyms.
 @param roomArray
 */
-(void) storeRooms:(NSMutableArray *)roomArray
{
    //NSLog(@"storeRooms START");
    [self storeOnTable:@"ROOMS" withArray:roomArray];
    //NSLog(@"storeRooms FINISHED");
}

/*!
 @function getRooms
 Returns an array of room acronyms.
 */
-(NSMutableArray *) getRooms
{
    //NSLog(@"getRooms");
    return [self getNamesFromTable:@"ROOMS"];
}

/*!
 @function storeClasses
 Stores the given array for class acronyms.
 @param classArray
 */
-(void) storeClasses:(NSMutableArray *)classArray
{
    [self storeOnTable:@"CLASSES" withArray:classArray];
}

/*!
 @function getClasses
 Returns an array of class acronyms.
 */
-(NSMutableArray *)getClasses
{
    return [self getNamesFromTable:@"CLASSES"];
}

/*!
 @function storeCourses
 Stores the given array for course acronyms.
 @param coursesArray
 */
-(void) storeCourses:(NSMutableArray *)coursesArray
{
    [self storeOnTable:@"COURSES" withArray:coursesArray];
}

/*!
 @function getCourses
 Returns an array of course acronyms.
 */
-(NSMutableArray *)getCourses
{
    return [self getNamesFromTable:@"COURSES"];
}

/*!
 @function storeStudents
 Stores the given array for student acronyms.
 @param studentsArray
 */
-(void) storeStudents:(NSMutableArray *)studentsArray
{
    [self storeOnTable:@"STUDENTS" withArray:studentsArray];
}

/*!
 @function getStudents
 Returns an array of student acronyms.
 */
-(NSMutableArray *)getStudents
{
    return [self getNamesFromTable:@"STUDENTS"];
}

/*!
 @function getStartStations
 Returns an array of the three last used start stations.
 */
-(NSMutableArray *)getStartStations
{
    return [self getNamesFromTable:@"START_STATIONS"];
}

/*!
 @function addStartStation
 Adds a new start station to the array.
 @param startStation
 */
-(void) addStartStation:(NSString *)startStation
{
    [self addToTable:@"START_STATIONS" withString:startStation];
}

/*!
 @function deleteStartStation
 Deletes all start stations from database.
 */
-(void) deleteStartStation
{
    [self deleteFromTable:@"START_STATIONS"];
}

/*!
 @function getStopStations
 Returns an array of the three last used stop stations.
 */
-(NSMutableArray *)getStopStations
{
    return [self getNamesFromTable:@"STOP_STATIONS"];
}

/*!
 @function addStopStation
 Adds a new stop station to the array.
 @param stopStation
 */
-(void) addStopStation:(NSString *)stopStation
{
    [self addToTable:@"STOP_STATIONS" withString:stopStation];
}

/*!
 @function deleteStartStation
 Deletes all start stations from database.
 */
-(void) deleteStopStation
{
    [self deleteFromTable:@"STOP_STATIONS"];
}

/*!
 @function getDBStations
 Returns an array of all possible stations.
 */
-(NSMutableArray *)getDBStations
{
    NSMutableArray  *_nameArray = [[NSMutableArray alloc] init];
    sqlite3         *_stationsDB;
        
    if(sqlite3_open([_connectionDBPath UTF8String], &_stationsDB) == SQLITE_OK)
    {
        //NSLog(@"sqlite3 open");
        NSString    *_sqlStmtString = [NSString stringWithFormat:@"select name from stations;"];
        const char  *_sqlStmtChar   = [_sqlStmtString UTF8String];
            
        sqlite3_stmt    *_compiledStatement;
        NSString        *_namesFromTable;
            
        if(sqlite3_prepare_v2(_stationsDB, _sqlStmtChar, -1, &_compiledStatement, NULL) == SQLITE_OK)
        {
            //NSLog(@"stmt could be compiled");
            
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(_compiledStatement) == SQLITE_ROW)
            {
                //NSLog(@"_compiledStatement: %s", sqlite3_column_text(_compiledStatement, 0));
                _namesFromTable = [NSString stringWithUTF8String:(char *)sqlite3_column_text(_compiledStatement, 0)];
                //NSLog(@"_namesFromTable: %@", _namesFromTable);
                [_nameArray addObject:_namesFromTable];
            }
        }
        else
        {
            NSLog(@"stmt could not be compiled %d", sqlite3_prepare_v2(_stationsDB, _sqlStmtChar, -1, &_compiledStatement, NULL));
        }
        // Release the compiled statement from memory
        sqlite3_finalize(_compiledStatement);
        sqlite3_close(_stationsDB);
    }
    else
    {
        NSLog(@"could not open ");
    }
    //NSLog(@"_nameArray count: %i", [_nameArray count]);
    return _nameArray;
}

@end

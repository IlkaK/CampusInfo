/*
 StudentsDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header StudentsDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain all acronyms of students. </li>
 *      <li> Acronyms are stored in database, for that class DBCachingForAutocomplete is used. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives no data. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> If called it returns itself with an array of all student acronyms, gathered via server connection or from database. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "StudentsDto.h"
#import "URLConstantStrings.h"

@implementation StudentsDto
@synthesize _dbCachingForAutocomplete;
@synthesize _studentArray;
@synthesize _studentArrayFromDB;

@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;

@synthesize _generalDictionary;

/*!
 @function init
 Initializes StudentsDto and its variables.
 */
- (id)init
{
    _studentArray        = [[NSMutableArray alloc] init];
    _studentArrayFromDB  = [[NSMutableArray alloc] init];
    
    self._connectionTrials = 1;
    _generalDictionary = nil;
    
    _dbCachingForAutocomplete = [[DBCachingForAutocomplete alloc]init];
    return self;
}


//-------------------------------
// asynchronous request
//-------------------------------
/*!
 @function dataDownloadDidFinish
 Needed since TimeTableAsyncRequest is used.
 Function receives data, when download from server is finished.
 */
-(void) dataDownloadDidFinish:(NSData*) data
{
    
    self._dataFromUrl = data;
    
    // NSLog(@"dataDownloadDidFinish 1 %@",[NSThread callStackSymbols]);
    
    if (self._dataFromUrl != nil)
    {
        //NSString *_receivedString = [[NSString alloc] initWithData:self._dataFromUrl encoding:NSASCIIStringEncoding];
        //_receivedString = [_receivedString substringToIndex:100];
        //NSLog(@"dataDownloadDidFinish FOR SEARCHVIEWCONTROLLER %@", _receivedString);
        
        NSError *_error;
        
        //if (_generalDictionary == nil)
        //{
        NSArray      *_generalArrayFromServer;
        int          _generalArrayFromServerI;
        
        _generalDictionary = [NSJSONSerialization
                              JSONObjectWithData:_dataFromUrl
                              options:kNilOptions
                              error:&_error];
        
        
        for (id generalKey in _generalDictionary)
        {
            //NSLog(@"dataDownloadDidFinish generalKey:%@",generalKey);
            
            _generalArrayFromServer = [_generalDictionary objectForKey:generalKey];
            
            if ([generalKey isEqualToString:@"students"])
            {
                [_studentArray removeAllObjects];
                _generalArrayFromServer = [_generalDictionary objectForKey:generalKey];
                
                for (_generalArrayFromServerI = 0; _generalArrayFromServerI < [_generalArrayFromServer count]; _generalArrayFromServerI++)
                {
                    NSString *_student = [_generalArrayFromServer objectAtIndex:_generalArrayFromServerI];
                    //NSLog(@"students: %@",_student);
                    [_studentArray addObject:_student];
                }
                //NSLog(@"dataDownloadDidFinish studentArray count: %i", [_studentArray count]);
                
                if([_studentArrayFromDB count] != [_studentArray count])
                {
                    [_dbCachingForAutocomplete storeStudents:_studentArray];
                }
            }
        }
    }
}

/*!
 @function threadDone
 Needed since TimeTableAsyncRequest is used.
 If thread to download data is done, this function is called.
 */
-(void)threadDone:(NSNotification*)arg
{
    //NSLog(@"Thread exiting");
}

/*!
 @function downloadData
 Needed since TimeTableAsyncRequest is used.
 Function sends the request for data to server.
 */
-(void) downloadData
{
    NSString *_urlString = URLStudents;
                                                        
    //NSLog(@"urlString StudentsDto: %@", _urlString);
    
    NSURL *_url = [NSURL URLWithString:_urlString];
    [_asyncTimeTableRequest downloadData:_url];
}

/*!
 @function getDictionaryFromUrl
 Needed since TimeTableAsyncRequest is used.
 TimeTableAsyncRequest is initialized and data download is triggered here.
 If data is downloaded from server it is processed as well.
 */
- (NSDictionary *) getDictionaryFromUrl
{
    _asyncTimeTableRequest = [[TimeTableAsyncRequest alloc] init];
    _asyncTimeTableRequest._timeTableAsynchRequestDelegate = self;
    [self performSelectorInBackground:@selector(downloadData) withObject:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(threadDone:)
                                                 name:NSThreadWillExitNotification
                                               object:nil];
    
    if (_dataFromUrl == nil)
    {
        return nil;
    }
    else
    {
        //NSString *_receivedString = [[NSString alloc] initWithData:self._dataFromUrl encoding:NSASCIIStringEncoding];
        //_receivedString = [_receivedString substringToIndex:100];
        //NSLog(@"getDictionaryFromUrl studentsDto %@", _receivedString);
        
        NSError      *_error = nil;
        NSDictionary *_scheduleDictionary = [NSJSONSerialization
                                             JSONObjectWithData:_dataFromUrl
                                             options:kNilOptions
                                             error:&_error];
        return _scheduleDictionary;
        
    }
    
}

/*!
 @function getData
 Initializes StudentsDto and gets student acronym array.
 */
-(void) getData
{    
    
    self._generalDictionary = [self getDictionaryFromUrl];
    
    if (self._generalDictionary == nil)
    {
        //NSLog(@"StudentsDto: no connection");
        
        [_studentArray removeAllObjects];
            
         _studentArray           = [_dbCachingForAutocomplete getStudents];
        _studentArrayFromDB     = _studentArray;
            
    }

    //else
    //{
    //    NSLog(@"IF connection established");
    //}
    //}
}


@end

//
//  CoursesDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.08.13.
//
//

#import "CoursesDto.h"
#import "URLConstantStrings.h"

@implementation CoursesDto

@synthesize _dbCachingForAutocomplete;
@synthesize _courseArray;
@synthesize _courseArrayFromDB;

@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;

@synthesize _generalDictionary;

- (id)init
{
    _courseArray        = [[NSMutableArray alloc] init];
    _courseArrayFromDB  = [[NSMutableArray alloc] init];
    
    self._connectionTrials = 1;
    _generalDictionary = nil;
    
    _dbCachingForAutocomplete = [[DBCachingForAutocomplete alloc]init];
    
    return self;
}


//-------------------------------
// asynchronous request
//-------------------------------

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
            
            if ([generalKey isEqualToString:@"courses"])
            {
                NSDictionary    *_courseDictionary;
                NSString        *_courseDescription;
                [_courseArray removeAllObjects];
                
                for (_generalArrayFromServerI = 0; _generalArrayFromServerI < [_generalArrayFromServer count]; _generalArrayFromServerI++)
                {
                    _courseDictionary = [_generalArrayFromServer objectAtIndex:_generalArrayFromServerI];
                    for (id courseKey in _courseDictionary)
                    {
                        if ([courseKey isEqualToString:@"name"])
                        {
                            [_courseArray addObject:[_courseDictionary objectForKey:courseKey]];
                        }
                        if ([courseKey isEqualToString:@"description"])
                        {
                            _courseDescription = [_courseDictionary objectForKey:courseKey];
                        }
                    }
                }
                if([_courseArrayFromDB count] != [_courseArray count])
                {
                    [_dbCachingForAutocomplete storeCourses:_courseArray];
                }
            }
        }
    }
}


-(void)threadDone:(NSNotification*)arg
{
    //NSLog(@"Thread exiting");
}


-(void) downloadData
{
    NSString *_urlString = URLCourses;
    
    //NSLog(@"urlString CoursesDto: %@", _urlString);
    
    NSURL *_url = [NSURL URLWithString:_urlString];
    [_asyncTimeTableRequest downloadData:_url];
}


- (NSDictionary *) getDictionaryFromUrl
{
    _asyncTimeTableRequest = [[TimeTableAsyncRequest alloc] init];
    _asyncTimeTableRequest._timeTableAsynchRequestDelegate = self;
    [self performSelectorInBackground:@selector(downloadData) withObject:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(threadDone:)
                                                 name:NSThreadWillExitNotification
                                               object:nil];
    
    if (self._dataFromUrl == nil)
    {
        return nil;
    }
    else
    {
        //NSString *_receivedString = [[NSString alloc] initWithData:self._dataFromUrl encoding:NSASCIIStringEncoding];
        //_receivedString = [_receivedString substringToIndex:100];
        //NSLog(@"getDictionaryFromUrl coursesDto %@", _receivedString);
        
        NSError      *_error = nil;
        NSDictionary *_scheduleDictionary = [NSJSONSerialization
                                             JSONObjectWithData:self._dataFromUrl
                                             options:kNilOptions
                                             error:&_error];
        return _scheduleDictionary;
        
    }
    
}


-(void) getData
{
    
    self._generalDictionary = [self getDictionaryFromUrl];
    
    if (self._generalDictionary == nil)
    {
        //NSLog(@"CoursesDto: no connection");
        
        [_courseArray removeAllObjects];
        
        _courseArray           = [_dbCachingForAutocomplete getCourses];
        _courseArrayFromDB     = _courseArray;
        
    }
    
    //else
    //{
    //    NSLog(@"IF connection established");
    //}
    //}
}


@end
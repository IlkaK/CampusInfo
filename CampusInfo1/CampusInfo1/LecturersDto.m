//
//  LecturersDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.08.13.
//
//

#import "LecturersDto.h"

@implementation LecturersDto
@synthesize _dbCachingForAutocomplete;
@synthesize _lecturerArray;
@synthesize _lecturerArrayFromDB;

@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;

@synthesize _generalDictionary;

- (id)init
{
    _lecturerArray        = [[NSMutableArray alloc] init];
    _lecturerArrayFromDB  = [[NSMutableArray alloc] init];
    
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
            
            if ([generalKey isEqualToString:@"lecturers"])
            {
                [_lecturerArray removeAllObjects];
                NSDictionary    *_lecturerDictionary;
                NSString        *_lecturerName;
                NSString        *_lecturerShortName;
                
                for (_generalArrayFromServerI = 0; _generalArrayFromServerI < [_generalArrayFromServer count]; _generalArrayFromServerI++)
                {
                    _lecturerDictionary = [_generalArrayFromServer objectAtIndex:_generalArrayFromServerI];
                    for (id lecturerKey in _lecturerDictionary)
                    {
                        if ([lecturerKey isEqualToString:@"name"])
                        {
                            _lecturerName = [_lecturerDictionary objectForKey:lecturerKey];
                            //NSLog(@"lecturer name: %@", _lecturerName);
                        }
                        if ([lecturerKey isEqualToString:@"shortName"])
                        {
                            _lecturerShortName = [_lecturerDictionary objectForKey:lecturerKey];
                            //NSLog(@"lecturer shortName: %@", _lecturerShortName);
                            [_lecturerArray addObject:_lecturerShortName];
                        }
                    }
                }
                NSLog(@"dataDownloadDidFinish _lecturerArray count: %i", [_lecturerArray count]);
                
                if([_lecturerArrayFromDB count] != [_lecturerArray count])
                {
                    [_dbCachingForAutocomplete storeLecturers:_lecturerArray];
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
    NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/schedules/lecturers/"];
                                                        
    NSLog(@"urlString Lecturers: %@", _urlString);
    
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
    
    if (_dataFromUrl == nil)
    {
        return nil;
    }
    else
    {
        NSError      *_error = nil;
        //NSLog(@"getDictionaryFromUrl got some data putting it now into dictionary");
        NSDictionary *_scheduleDictionary = [NSJSONSerialization
                                             JSONObjectWithData:_dataFromUrl
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
        NSLog(@"LecturersDto: no connection");
        
        [_lecturerArray removeAllObjects];
        
        _lecturerArray           = [_dbCachingForAutocomplete getLecturers];
        _lecturerArrayFromDB     = _lecturerArray;
        
    }
    
    //else
    //{
    //    NSLog(@"IF connection established");
    //}
    //}
}


@end

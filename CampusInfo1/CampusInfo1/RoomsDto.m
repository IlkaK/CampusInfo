//
//  RoomsDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.08.13.
//
//

#import "RoomsDto.h"
#import "URLConstantStrings.h"

@implementation RoomsDto

@synthesize _dbCachingForAutocomplete;
@synthesize _roomArray;
@synthesize _roomArrayFromDB;

@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;

@synthesize _generalDictionary;

- (id)init
{
    _roomArray        = [[NSMutableArray alloc] init];
    _roomArrayFromDB  = [[NSMutableArray alloc] init];
    
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
            
            if ([generalKey isEqualToString:@"rooms"])
            {
                [_roomArray removeAllObjects];
                for (_generalArrayFromServerI = 0; _generalArrayFromServerI < [_generalArrayFromServer count]; _generalArrayFromServerI++)
                {
                    [_roomArray addObject:[_generalArrayFromServer objectAtIndex:_generalArrayFromServerI]];
                }
                if([_roomArrayFromDB count] != [_roomArray count])
                {
                    [_dbCachingForAutocomplete storeRooms:_roomArray];
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
    NSString *_urlString = URLRooms;
    
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
        //NSLog(@"getDictionaryFromUrl roomsDto %@", _receivedString);

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
        NSLog(@"RoomsDto: no connection");
        
        [_roomArray removeAllObjects];
        
        _roomArray           = [_dbCachingForAutocomplete getRooms];
        _roomArrayFromDB     = _roomArray;
        
    }
    
    //else
    //{
    //    NSLog(@"IF connection established");
    //}
    //}
}


@end
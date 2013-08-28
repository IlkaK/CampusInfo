//
//  NewsChannelDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 15.08.13.
//
//

#import "NewsChannelDto.h"

@implementation NewsChannelDto
@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;
@synthesize _generalDictionary;

@synthesize _actualStartElement;
@synthesize _actualEndElement;
@synthesize _actualValue;

@synthesize _startChannel;
@synthesize _startImage;
@synthesize _startItem;

@synthesize _dateFormatter;


@synthesize delegate;

@synthesize _description;
@synthesize _link;
@synthesize _title;
@synthesize _docs;
@synthesize _generator;
@synthesize _language;
@synthesize _lastBuildDate;

@synthesize _newsImage;
@synthesize _newsItem;
@synthesize _newsItemArray;

@synthesize _dataType;

- (id)init
{
    self._connectionTrials = 1;
    _generalDictionary = nil;
    _startChannel = NO;
    _startImage = NO;
    _startItem = NO;
    
    _dateFormatter = [[DateFormation alloc] init]; 
    _newsItemArray = [[NSMutableArray alloc] init];
    
    self._dataType = @"NEWS";
    return self;
}


// handling XML parser stuff
-   (void)parser:(NSXMLParser *)parser
 didStartElement:(NSString *)elementName
    namespaceURI:(NSString *)namespaceURI
   qualifiedName:(NSString *)qName
      attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"element start %@", elementName);
    
    _actualStartElement = elementName;
    _actualEndElement   = @"";
    
    if ([_actualStartElement isEqualToString:@"channel"])
    {
        _startChannel = YES;
        //NSLog(@"- start parsing channel");
    }
    
    if ([_actualStartElement isEqualToString:@"image"])
    {
        _startImage = YES;
        //NSLog(@"-- start parsing image");
        _newsImage = [[NewsImageDto alloc]init:nil :nil :nil :nil :nil :nil];
    }
    if ([_actualStartElement isEqualToString:@"item"])
    {
        _startItem = YES;
        //NSLog(@"-- start parsing item");
        _newsItem = [[NewsItemDto alloc]init:[NSString stringWithFormat:@""] :[NSString stringWithFormat:@""] :[NSString stringWithFormat:@""] :[NSString stringWithFormat:@""] :[NSString stringWithFormat:@""] :nil];
    }
}


-   (void)parser:(NSXMLParser *)parser
 foundCharacters:(NSString *)string
{
    //NSLog(@"some value string %@", string);
    _actualValue = string;
    if ([_actualEndElement isEqualToString:@""])
    {
        
        if (_startChannel == YES && _startImage == NO && _startItem == NO)
        {

            if ([_actualStartElement isEqualToString:@"title"])
            {
                //NSLog(@"- channel title: %@", _actualValue);
                _title = _actualValue;
            }
            if ([_actualStartElement isEqualToString:@"link"])
            {
                //NSLog(@"- channel link: %@", _actualValue);
                _link = _actualValue;
            }
            if ([_actualStartElement isEqualToString:@"description"])
            {
                //NSLog(@"- channel description: %@", _actualValue);
                _description = _actualValue;
            }
            if ([_actualStartElement isEqualToString:@"language"])
            {
                //NSLog(@"- channel language: %@", _actualValue);
                _language = _actualValue;
            }
            if ([_actualStartElement isEqualToString:@"generator"])
            {
                //NSLog(@"- channel generator: %@", _actualValue);
                _generator = _actualValue;
            }
            if ([_actualStartElement isEqualToString:@"docs"])
            {
                //NSLog(@"- channel docs: %@", _actualValue);
                _docs = _actualValue;
            }
            if ([_actualStartElement isEqualToString:@"lastBuildDate"])
            {
                //NSLog(@"- channel lastBuildDate: %@", _actualValue);
                _lastBuildDate = [_dateFormatter parseDateFromXMLString:_actualValue];
            }
        }
        if (_startImage == YES)
        {
            if ([_actualStartElement isEqualToString:@"title"])
            {
                //NSLog(@"-- image title: %@", _actualValue);
                _newsImage._title = _actualValue;
            }
            if ([_actualStartElement isEqualToString:@"url"])
            {
                //NSLog(@"-- image url: %@", _actualValue);
                _newsImage._imgURL = _actualValue;
            }
            if ([_actualStartElement isEqualToString:@"link"])
            {
                //NSLog(@"-- image link: %@", _actualValue);
                _newsImage._link = _actualValue;
            }
            if ([_actualStartElement isEqualToString:@"width"])
            {
                //NSLog(@"-- image width: %@", _actualValue);
                _newsImage._width = [_actualValue intValue];
            }
            if ([_actualStartElement isEqualToString:@"height"])
            {
                //NSLog(@"-- image height: %@", _actualValue);
                _newsImage._height = [_actualValue intValue];
            }
            if ([_actualStartElement isEqualToString:@"description"])
            {
                //NSLog(@"-- image description: %@", _actualValue);
                _newsImage._description = _actualValue;
            }
        }
        if (_startItem == YES)
        {
            if ([_actualStartElement isEqualToString:@"title"])
            {
                //NSLog(@"-- item title: %@", _actualValue);
                _newsItem._title = [NSString stringWithFormat:@"%@%@",_newsItem._title, _actualValue];
            }
            if ([_actualStartElement isEqualToString:@"link"])
            {
                //NSLog(@"-- item link: %@", _actualValue);
                _newsItem._link = [NSString stringWithFormat:@"%@%@",_newsItem._link, _actualValue];
            }
            if ([_actualStartElement isEqualToString:@"description"])
            {
                //NSLog(@"-- item description: %@", _actualValue);
                _newsItem._description = [NSString stringWithFormat:@"%@%@",_newsItem._description, _actualValue];
            }
            if ([_actualStartElement isEqualToString:@"content:encoded"])
            {
                //NSLog(@"-- item content: %@", _actualValue);
                _newsItem._content = [NSString stringWithFormat:@"%@%@",_newsItem._content, _actualValue];
            }
            if ([_actualStartElement isEqualToString:@"category"])
            {
                //NSLog(@"-- item category: %@", _actualValue);
                _newsItem._category = [NSString stringWithFormat:@"%@%@",_newsItem._category, _actualValue];
            }
            // pubDate returns weird string for events, so only works for news
            if ([_actualStartElement isEqualToString:@"pubDate"] && [_dataType isEqualToString:@"NEWS"])
            {
                //NSLog(@"-- item pubDate: %@", _actualValue);
                _newsItem._pubDate = [_dateFormatter parseDateFromXMLString:_actualValue];
            }
            
        }
    }
}

-   (void)parser:(NSXMLParser *)parser
   didEndElement:(NSString *)elementName
    namespaceURI:(NSString *)namespaceURI
   qualifiedName:(NSString *)qName
{
    _actualEndElement = elementName;
    _actualStartElement = @"";
    
    // stop parsing for channel
    if ([_actualEndElement isEqualToString:@"channel"])
    {
        _startChannel = NO;
        //NSLog(@"finished parsing channel, how many item: %i", [_newsItemArray count]);
        
        //NSLog(@"- finished parsing channel: %@ --- %@ --- %@ --- %@ --- %@ --- %@ --- %@", _title, _link, _description, _language, _generator, _docs, [[_dateFormatter _englishTimeAndDayFormatter] stringFromDate:_lastBuildDate]);

    
    }
    
    // stop parsing for image
    if ([_actualEndElement isEqualToString:@"image"])
    {
        _startImage = NO;
        //NSLog(@"- finished parsing image: %@ --- %@ --- %@ --- %@ --- %i --- %i", _newsImage._title, _newsImage._link, _newsImage._description, _newsImage._imgURL, _newsImage._width, _newsImage._height);
    }
    
    // stop parsing for item
    if ([_actualEndElement isEqualToString:@"item"])
    {
        _startItem = NO;
       [_newsItemArray addObject:_newsItem];
        //NSLog(@"- finished parsing item: %@ --- %@ --- %@ --- %@ --- %@ --- %@", _newsItem._title, _newsItem._link, _newsItem._description, _newsItem._content, _newsItem._category,[[_dateFormatter _englishTimeAndDayFormatter] stringFromDate:_newsItem._pubDate]);

    }
    
   //NSLog(@"element end %@", _actualEndElement);
    
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
        NSString *_receivedString = [[NSString alloc] initWithData:self._dataFromUrl encoding:NSASCIIStringEncoding];
        //_receivedString = [_receivedString substringToIndex:4000];
        NSLog(@"dataDownloadDidFinish FOR something %@", _receivedString);
        
        NSXMLParser *XML=[[NSXMLParser alloc] initWithData:self._dataFromUrl];
        XML.delegate = self;
        [XML parse];
        
        // Parse the XML into a dictionary
        
        NSError         *_error;
        //NSDictionary    *_xmlDictionary = [XMLReader dictionaryForXMLString:_receivedString];
        
        // Print the dictionary
        //NSLog(@"xmlDictionary: %@", [XML ]);
        
        _generalDictionary = [NSJSONSerialization
                              JSONObjectWithData:_dataFromUrl
                              options:kNilOptions
                              error:&_error];
        
    }
}


-(void)threadDone:(NSNotification*)arg
{
    //NSLog(@"Thread exiting");
}


-(void) downloadData
{
    NSString *_urlString;
    
    if ([_dataType isEqualToString:@"EVENTS"])
    {
        _urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/feeds/soe-events/feed"];
    }
    else
    {
        _urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/feeds/soe-news/feed"];
    }
        
    NSLog(@"urlString NewsChannelDto: %@", _urlString);
    
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

-(void) getNewsData
{
    self._generalDictionary = [self getDictionaryFromUrl];
    self._dataType = @"NEWS";
    
    if (self._generalDictionary == nil)
    {
        NSLog(@"NewsChannelDto: no connection");
        
    }
}

-(void) getEventData
{
    self._generalDictionary = [self getDictionaryFromUrl];
    self._dataType = @"EVENTS";
    
    if (self._generalDictionary == nil)
    {
        NSLog(@"NewsChannelDto: no connection");
        
    }
}



@end

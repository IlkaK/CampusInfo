//
//  SomethingDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import "SomethingDto.h"
#import "XMLReader.h"

@implementation SomethingDto
@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;

@synthesize _generalDictionary;

@synthesize delegate;

- (id)init
{
    self._connectionTrials = 1;
    _generalDictionary = nil;
    
    return self;
}


// handling XML parser stuff
-   (void)parser:(NSXMLParser *)parser
 didStartElement:(NSString *)elementName
    namespaceURI:(NSString *)namespaceURI
   qualifiedName:(NSString *)qName
      attributes:(NSDictionary *)attributeDict
{
    NSMutableString *value;
    
    if ([elementName isEqualToString:@" title " ])
    {
        NSLog(@"found title");
    }
    else
    {
        if([elementName isEqualToString:@" link "])
        {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            //NSString *temp=[ attributeDict valueForKey:@"id"];
            [dic setValue:value forKey:@"id"];
        }
        value=nil;
    }
}

    
-   (void)parser:(NSXMLParser *)parser
 foundCharacters:(NSString *)string
{
    NSLog(@"some string %@", string);
    /*
        if(!value)
        {
            value=[[NSMutableString alloc]init];
        }
        [value appendString:string];
     */
}

-   (void)parser:(NSXMLParser *)parser
   didEndElement:(NSString *)elementName
    namespaceURI:(NSString *)namespaceURI
   qualifiedName:(NSString *)qName
{
    NSLog(@"for elementName %@", elementName);
    
    /*
        if([elementName isEqualToString:@" catalog "])
        { // All XML file information is parse to book array // Now you can call a function in which you can use this array as you want.
            //[self print_array];
        }
        elseif([elementName isEqualToString:@" book "])
        { // Add book dictionary to book array
            //[book_array addObject:dic];
            //dic=nil;
        }
        elseif([elementName isEqualToString:@" author "])
        { // add book author in book dictionary
            //[dic setValue:value forKey:elementName];
        }
        elseif([elementName isEqualToString:@"title"])
        { // add book title to book dictionary
            //[dic setValue:value forKey:elementName];
        }
        elseif([elementName isEqualToString:@" price "])
        { // add book price to book dictionary
            //[dic setValue:value forKey:elementName];
        }
        elseif([elementName isEqualToString:@" publish_date "])
        { // add book publish date to book dictionary [dic setValue:value forKey:elementName];
        }
        elseif([elementName isEqualToString:@" description "])
        { // add book description to book dictionary
            //[dic setValue:value forKey:elementName];
        }
     */
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
        _receivedString = [_receivedString substringToIndex:500];
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
    NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/feeds/soe-news/feed"];
    
    NSLog(@"urlString SomethingDto: %@", _urlString);
    
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

-(void) getData
{
    self._generalDictionary = [self getDictionaryFromUrl];
    
    if (self._generalDictionary == nil)
    {
        NSLog(@"SomethingDto: no connection");
        
    }
}



@end
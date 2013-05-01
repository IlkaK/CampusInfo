//
//  TimeTableAsyncRequest.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 15.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeTableAsyncRequest.h"

@implementation TimeTableAsyncRequest


@synthesize _timeTableAsynchRequestDelegate;
@synthesize _receivedData;

// called by schedule.downloadData via schedule.init
-(void) downloadData:(NSURL*) url 
{  
   // NSLog(@" download data with url %@", [url absoluteString]);
    

   NSMutableURLRequest      *_request= [[NSMutableURLRequest alloc]initWithURL
                                    :url
                                        //cachePolicy
//                                    :NSURLRequestReloadIgnoringLocalCacheData  //timeoutInterval
//                                   :20.0
                                        ];

 //   NSString *userAgent = [NSString stringWithFormat:@"%@ %@",[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
   // [_request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    
    
    NSDictionary *_agent_headers = [NSDictionary dictionaryWithObject:
                             @"ZHAWCampusInfoForIPhone (http://www.init.zhaw.ch)" forKey:@"User-Agent"];
    [_request setAllHTTPHeaderFields:_agent_headers];
    
    
    //[_request setValue:userAgent forHTTPHeaderField:@"ZHAWCampusInfoForIPhone"];
    NSURLConnection   *_connection=[[NSURLConnection alloc] initWithRequest:_request delegate:self];
    
    if (_connection) 
    {
        self._receivedData        = [NSMutableData data]; 
        //NSString *_receivedString = [[NSString alloc] initWithData:_receivedData encoding:NSASCIIStringEncoding];
        //NSLog(@"2 DO downloadData %@", _receivedString);
        
        //NSString *someString = [NSString stringWithFormat:@"%@", _receivedData]; 
        //NSLog(@"2 downloadData data from url %@", someString);
    
    } else 
    {
        NSLog(@"Did not download data");
    }  
    CFRunLoopRun(); // Avoid thread exiting
} 


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
	
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
	
    // receivedData is an instance variable declared elsewhere.
    
    [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    //NSString *receivedString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //NSLog(@"3 didReceiveData %@", receivedString);
    
    [_receivedData appendData:data];
    [_timeTableAsynchRequestDelegate dataDownloadDidFinish:_receivedData];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self._receivedData = [NSMutableData data];
    
    NSString *receivedString = nil;
    receivedString = [[NSString alloc] initWithData:_receivedData encoding:NSASCIIStringEncoding];
    //NSLog(@"connectionDidFinishLoading %@", receivedString);
    
    if (receivedString == nil) {
        NSLog(@"no data this time");
    }
    else {
    //[myDelegate dataDownloadDidFinish:receivedData];
    }
    CFRunLoopStop(CFRunLoopGetCurrent());
    
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

    /*
    // inform the user
    UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc] initWithTitle: @"NSURLConnection " message: @"didFailWithError"  delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [didFailWithErrorMessage show];
    [didFailWithErrorMessage release];
	*/
    //inform the user
    NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);

    CFRunLoopStop(CFRunLoopGetCurrent());
}


- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


@end


/*
 TimeTableAsyncRequest.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header TimeTableAsyncRequest.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Handling sending requests to server asynchronously and synchronously and handling getting the data back from server. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> The class receives the url which it sends to server. </li>
 *      <li> The class receives the response from server for its request. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It sends the url request to server. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "TimeTableAsyncRequest.h"

@implementation TimeTableAsyncRequest


@synthesize _timeTableAsynchRequestDelegate;
@synthesize _receivedData;

/*!
 @function downloadData
 Url is send to server.
 @param url
 */
-(void) downloadData:(NSURL*) url 
{  
   // NSLog(@" download data with url %@", [url absoluteString]);

   NSMutableURLRequest      *_request= [[NSMutableURLRequest alloc]initWithURL
                                    :url];
    
    NSDictionary *_agent_headers = [NSDictionary dictionaryWithObject:
                             @"ZHAWCampusInfoForIPhone (http://www.init.zhaw.ch)" forKey:@"User-Agent"];
    [_request setAllHTTPHeaderFields:_agent_headers];
    
    //NSLog(@"_request all http header fields: %@", [_request allHTTPHeaderFields]);
    //NSLog(@"_request value for http header field: %@",[_request valueForHTTPHeaderField:field]);
    
    NSURLConnection   *_connection=[[NSURLConnection alloc] initWithRequest:_request delegate:self];
    
    if (_connection) 
    {
        self._receivedData        = [NSMutableData data];
    }
    else
    {
        NSLog(@"NO CONNECTION IN ASYNC REQUEST");
    }  
    CFRunLoopRun(); // Avoid thread exiting
} 

/*!
 @function didReceiveResponse
 This method is called when the server has determined that it has enough information to create the NSURLResponse.
 It can be called multiple times, for example in the case of a redirect, so each time we reset the data.
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // receivedData is an instance variable declared elsewhere.
    [_receivedData setLength:0];
}

/*!
 @function didReceiveData
 Append the new data to receivedData.
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // receivedData is an instance variable declared elsewhere.
    [_receivedData appendData:data];
    [_timeTableAsynchRequestDelegate dataDownloadDidFinish:_receivedData];
}

/*!
 @function connectionDidFinishLoading
 Is called when data is downloaded.
 */
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

/*!
 @function didFailWithError
 Is called when an error occured.
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //inform the user
    NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);
    CFRunLoopStop(CFRunLoopGetCurrent());
}

/*!
 @function canAuthenticateAgainstProtectionSpace
 Authentication is set.
 */
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

/*!
 @function didReceiveAuthenticationChallenge
 Authentication is set.
 */
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


@end


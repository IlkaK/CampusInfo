/*
 TimeTableAsyncRequest.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header TimeTableAsyncRequest.h
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

#import <Foundation/Foundation.h>

@protocol TimeTableAsyncRequestDelegate
-(void) dataDownloadDidFinish:(NSData*) data;
@end


@interface TimeTableAsyncRequest : NSObject
{
    /*! @var _receivedData Holds the data which is send back from server */
    NSMutableData                    *_receivedData;
    /*! @var _timeTableAsynchRequestDelegate Holds the delegate id for the class */
    id<TimeTableAsyncRequestDelegate> _timeTableAsynchRequestDelegate;
}

@property (nonatomic,retain) id<TimeTableAsyncRequestDelegate> _timeTableAsynchRequestDelegate;
@property (nonatomic, retain) NSMutableData                   *_receivedData;

/*!
 @function downloadData
 Url is send to server.
 @param url
 */
-(void) downloadData:(NSURL*) url ;

@end

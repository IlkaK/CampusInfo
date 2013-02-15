//
//  TimeTableAsyncRequest.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 15.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimeTableAsyncRequestDelegate
-(void) dataDownloadDidFinish:(NSData*) data;
@end


@interface TimeTableAsyncRequest : NSObject
{
    NSMutableData                    *_receivedData;
    id<TimeTableAsyncRequestDelegate> _timeTableAsynchRequestDelegate;
}

@property (nonatomic,retain) id<TimeTableAsyncRequestDelegate> _timeTableAsynchRequestDelegate;
@property (nonatomic, assign) NSMutableData                   *_receivedData;

-(void) downloadData:(NSURL*) url ;

@end

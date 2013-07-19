//
//  MensaViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import <UIKit/UIKit.h>
#import <TimeTableAsyncRequest.h>
#import <DateFormation.h>

@interface MensaViewController : UIViewController<TimeTableAsyncRequestDelegate>
{

    IBOutlet UITableView        *_mensaOverviewTable;
    IBOutlet UITableViewCell    *_mensaOverviewTableCell;

    NSDictionary                *_generalDictionary;
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    NSData                      *_dataFromUrl;
    NSString                    *_errorMessage;
    int                         _connectionTrials;
    NSMutableArray              *_gastronomyArray;
    
    NSDate                      *_actualDate;
    DateFormation               *_dateFormatter;
}

@property (nonatomic, retain) IBOutlet UITableView               *_mensaOverviewTable;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_mensaOverviewTableCell;

@property (strong, nonatomic) NSDictionary                      *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest    *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                            *_dataFromUrl;
@property (nonatomic, retain) NSString                          *_errorMessage;
@property (nonatomic, retain) NSMutableArray                    *_gastronomyArray;
@property (nonatomic, assign) int                                _connectionTrials;

@property (nonatomic, retain) NSDate                            *_actualDate;
@property (nonatomic, retain) DateFormation                     *_dateFormatter;


@end

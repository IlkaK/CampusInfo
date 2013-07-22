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
#import <LanguageTranslation.h>
#import <MensaDetailViewController.h>

@interface MensaViewController : UIViewController<TimeTableAsyncRequestDelegate, UITableViewDelegate>
{

    IBOutlet UITableView        *_mensaOverviewTable;
    IBOutlet UITableViewCell    *_mensaOverviewTableCell;
    IBOutlet UILabel            *_dateLabel;

    NSDictionary                *_generalDictionary;
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    NSData                      *_dataFromUrl;
    NSString                    *_errorMessage;
    int                         _connectionTrials;
    NSMutableArray              *_gastronomyArray;
    
    NSDate                      *_actualDate;
    DateFormation               *_dateFormatter;
    LanguageTranslation         *_translator;
    IBOutlet MensaDetailViewController *_mensaDetailVC;
}

@property (nonatomic, retain) IBOutlet UITableView               *_mensaOverviewTable;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_mensaOverviewTableCell;
@property (nonatomic, retain) IBOutlet UILabel                   *_dateLabel;

@property (strong, nonatomic) NSDictionary                      *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest    *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                            *_dataFromUrl;
@property (nonatomic, retain) NSString                          *_errorMessage;
@property (nonatomic, retain) NSMutableArray                    *_gastronomyArray;
@property (nonatomic, assign) int                                _connectionTrials;



@property (nonatomic, retain) IBOutlet MensaDetailViewController    *_mensaDetailVC;@property (nonatomic, retain) NSDate                            *_actualDate;
@property (nonatomic, retain) DateFormation                     *_dateFormatter;
@property (nonatomic, retain) LanguageTranslation               *_translator;

@end

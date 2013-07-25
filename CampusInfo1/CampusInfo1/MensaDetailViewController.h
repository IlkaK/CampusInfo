//
//  MensaDetailViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 22.07.13.
//
//

#import <UIKit/UIKit.h>
#import <GastronomicFacilityDto.h>
#import <GradientButton.h>
#import <DateFormation.h>
#import <ChooseDateViewController.h>
#import <TimeTableAsyncRequest.h>
#import <MenuDto.h>


@interface MensaDetailViewController : UIViewController <ChooseDateViewDelegate, UITableViewDataSource, UITableViewDelegate, TimeTableAsyncRequestDelegate>
{
    GastronomicFacilityDto              *_actualGastronomy;
    IBOutlet GradientButton             *_moveBackButton;
    IBOutlet UINavigationItem           *_dayNavigationItem;
    IBOutlet UILabel                    *_dateLabel;
    DateFormation                       *_dateFormatter;

    IBOutlet ChooseDateViewController   *_chooseDateVC;
    IBOutlet UITableView                *_detailTable;
    IBOutlet UITableViewCell            *_detailTableCell;
    IBOutlet UILabel                    *_gastronomyLabel;
    
    TimeTableAsyncRequest               *_asyncTimeTableRequest;
    NSData                              *_dataFromUrl;
    NSString                            *_errorMessage;
    int                                 _connectionTrials;
    
    NSMutableArray                      *_menuPlans;
    MenuDto                             *_actualMenu;
    
    NSDate                              *_actualDate;
    int                                 _actualCalendarWeek;
    IBOutlet UISwipeGestureRecognizer   *_rightSwipe;
    IBOutlet UISwipeGestureRecognizer   *_leftSwipe;
}

@property (nonatomic, retain) GastronomicFacilityDto                    *_actualGastronomy;
@property (nonatomic, retain) GradientButton                            *_moveBackButton;
@property (nonatomic, retain) IBOutlet UINavigationItem                 *_dayNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                          *_dateLabel;
@property (nonatomic, retain) DateFormation                             *_dateFormatter;

@property (nonatomic, retain) NSDate                                    *_actualDate;
@property (nonatomic, assign) int                                       _actualCalendarWeek;

@property (nonatomic, retain) IBOutlet ChooseDateViewController         *_chooseDateVC;
@property (nonatomic, retain) IBOutlet UITableView                      *_detailTable;
@property (nonatomic, retain) IBOutlet UITableViewCell                  *_detailTableCell;
@property (nonatomic, retain) IBOutlet UILabel                          *_gastronomyLabel;

@property (strong, nonatomic) NSDictionary                              *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest            *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                                    *_dataFromUrl;
@property (nonatomic, retain) NSString                                  *_errorMessage;
@property (nonatomic, assign) int                                       _connectionTrials;

@property (nonatomic, retain) NSMutableArray                            *_menuPlans;
@property (nonatomic, retain) MenuDto                                   *_actualMenu;

@property (nonatomic, retain) IBOutlet UISwipeGestureRecognizer         *_rightSwipe;
@property (nonatomic, retain) IBOutlet UISwipeGestureRecognizer         *_leftSwipe;

- (IBAction)backToMensaOverview:(id)sender;

@end

//
//  PublicTransportViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <UIKit/UIKit.h>
#import <GradientButton.h>
#import <PublicStopViewController.h>
#import <ConnectionArrayDto.h>
#import <DateFormation.h>
#import <DBCachingForAutocomplete.h>


@class PublicStopViewController;

@interface PublicTransportViewController : UIViewController<UITableViewDelegate, UITextFieldDelegate>
{
    IBOutlet UINavigationBar            *_publicTransportNavigationBar;
    IBOutlet UINavigationItem           *_publicTransportNavigationItem;
    IBOutlet UILabel                    *_publicTransportNavigationLabel;
    
    IBOutlet UITableViewCell            *_pubilcTransportOverviewTableCell;
    IBOutlet UITableView                *_publicTransportTableView;
    
    IBOutlet PublicStopViewController   *_publicStopVC;
    
    ConnectionArrayDto                  *_connectionArray;
    
    DateFormation                       *_dateFormatter;
    
    NSString                            *_startStation;
    NSString                            *_stopStation;
    BOOL                                _changedStartStation;
    BOOL                                _changedStopStation;
    
    DBCachingForAutocomplete            *_dbCachingForAutocomplete;
    NSMutableArray                      *_storedStartStationArray;
    NSMutableArray                      *_storedStopStationArray;
    
    // search part
    IBOutlet UILabel                    *_startLabel;
    BOOL                                _changeStartButtonIsActivated;
    IBOutlet UIButton                   *_lastStart1Button;
    IBOutlet UIButton                   *_lastStart2Button;
    IBOutlet UIButton                   *_chooseNewStartButton;
    
    IBOutlet UILabel                    *_stopLabel;
    BOOL                                _changeStopButtonIsActivated;
    IBOutlet UIButton                   *_lastStop1Button;
    IBOutlet UIButton                   *_lastStop2Button;
    IBOutlet UIButton                   *_chooseNewStopButton;
    
    IBOutlet GradientButton             *_searchButton;
    IBOutlet GradientButton             *_changeDirectionButton;
    
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;
}


@property (nonatomic, retain) IBOutlet UINavigationBar              *_publicTransportNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_publicTransportNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_publicTransportNavigationLabel;


@property (nonatomic, retain) IBOutlet UITableViewCell              *_pubilcTransportOverviewTableCell;
@property (nonatomic, retain) IBOutlet UITableView                  *_publicTransportTableView;

@property (nonatomic, retain) IBOutlet PublicStopViewController     *_publicStopVC;

@property (nonatomic, retain) ConnectionArrayDto                    *_connectionArray;

@property (nonatomic, retain) DateFormation                         *_dateFormatter;

@property (nonatomic, retain) NSString                              *_startStation;
@property (nonatomic, retain) NSString                              *_stopStation;
@property (nonatomic, assign) BOOL                                  _changedStartStation;
@property (nonatomic, assign) BOOL                                  _changedStopStation;

@property (nonatomic, retain) DBCachingForAutocomplete              *_dbCachingForAutocomplete;
@property (nonatomic, retain) NSMutableArray                        *_storedStartStationArray;
@property (nonatomic, retain) NSMutableArray                        *_storedStopStationArray;

@property (nonatomic, retain) IBOutlet UILabel                      *_startLabel;
@property (nonatomic, assign) BOOL                                  _changeStartButtonIsActivated;
@property (nonatomic, retain) IBOutlet UIButton                     *_lastStart1Button;
@property (nonatomic, retain) IBOutlet UIButton                     *_lastStart2Button;
@property (nonatomic, retain) IBOutlet UIButton                     *_chooseNewStartButton;

@property (nonatomic, retain) IBOutlet UILabel                      *_stopLabel;
@property (nonatomic, assign) BOOL                                  _changeStopButtonIsActivated;
@property (nonatomic, retain) IBOutlet UIButton                     *_lastStop1Button;
@property (nonatomic, retain) IBOutlet UIButton                     *_lastStop2Button;
@property (nonatomic, retain) IBOutlet UIButton                     *_chooseNewStopButton;

@property (nonatomic, retain) IBOutlet GradientButton               *_searchButton;
@property (nonatomic, retain) IBOutlet GradientButton               *_changeDirectionButton;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView      *_waitForChangeActivityIndicator;


- (IBAction)startConnectionSearch:(id)sender;

// switch start and stop
- (IBAction)changeDirection:(id)sender;

// detail button next to start label
- (IBAction)changeStart:(id)sender;

// drop down list like button for start
- (IBAction)changeStartToLast1:(id)sender;
- (IBAction)changeStartToLast2:(id)sender;
- (IBAction)chooseNewStart:(id)sender;

// detail button next to stop label
- (IBAction)changeStop:(id)sender;

// drop down list like button for stop
- (IBAction)changeStopToLast1:(id)sender;
- (IBAction)changeStopToLast2:(id)sender;
- (IBAction)chooseNewStop:(id)sender;


@end

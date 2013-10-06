//
//  MensaDetailViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 22.07.13.
//
//

#import <UIKit/UIKit.h>
#import "GastronomicFacilityDto.h"
#import "GradientButton.h"
#import "DateFormation.h"
#import "ChooseDateViewController.h"
#import "MenuDto.h"
#import "MenuPlanArrayDto.h"
#import "ColorSelection.h"
#import "GradientButton.h"

@interface MensaDetailViewController : UIViewController <ChooseDateViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    GastronomicFacilityDto              *_actualGastronomy;
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation                       *_dateFormatter;
    MenuPlanArrayDto                    *_menuPlans;
    MenuDto                             *_actualMenu;

    IBOutlet UINavigationBar            *_titleNavigationBar;
    IBOutlet UINavigationItem           *_titleNavigationItem;
    IBOutlet UILabel                    *_titleNavigationLabel;
    IBOutlet UILabel                    *_gastronomyLabel;
    
    IBOutlet UINavigationItem           *_dayNavigationItem;
    IBOutlet UINavigationBar            *_dateNavigationBar;
    IBOutlet GradientButton             *_dateButton;
    

    IBOutlet ChooseDateViewController   *_chooseDateVC;
    IBOutlet UITableView                *_detailTable;
    IBOutlet UITableViewCell            *_detailTableCell;

    NSDate                              *_actualDate;
    int                                 _actualCalendarWeek;
    
    IBOutlet UISwipeGestureRecognizer   *_rightSwipe;
    IBOutlet UISwipeGestureRecognizer   *_leftSwipe;
    
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;
    
    ColorSelection                      *_zhawColor;
}

@property (nonatomic, retain) GastronomicFacilityDto                    *_actualGastronomy;

@property (nonatomic, retain) IBOutlet UINavigationItem                 *_dayNavigationItem;
@property (nonatomic, retain) IBOutlet GradientButton                   *_dateButton;
@property (nonatomic, retain) IBOutlet UINavigationBar                  *_dateNavigationBar;

@property (nonatomic, retain) DateFormation                             *_dateFormatter;

@property (nonatomic, retain) NSDate                                    *_actualDate;
@property (nonatomic, assign) int                                       _actualCalendarWeek;

@property (nonatomic, retain) IBOutlet ChooseDateViewController         *_chooseDateVC;
@property (nonatomic, retain) IBOutlet UITableView                      *_detailTable;
@property (nonatomic, retain) IBOutlet UITableViewCell                  *_detailTableCell;


@property (nonatomic, retain) MenuPlanArrayDto                          *_menuPlans;
@property (nonatomic, retain) MenuDto                                   *_actualMenu;

@property (nonatomic, retain) IBOutlet UISwipeGestureRecognizer         *_rightSwipe;
@property (nonatomic, retain) IBOutlet UISwipeGestureRecognizer         *_leftSwipe;

@property (nonatomic, retain) IBOutlet UINavigationBar                  *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem                 *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                          *_titleNavigationLabel;
@property (nonatomic, retain) IBOutlet UILabel                          *_gastronomyLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView          *_waitForChangeActivityIndicator;

@property (nonatomic, retain) ColorSelection                            *_zhawColor;


- (IBAction)backToMensaOverview:(id)sender;
- (IBAction)moveToChooseDateView:(id)sender;

@end

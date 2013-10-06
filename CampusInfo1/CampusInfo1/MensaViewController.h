//
//  MensaViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import <UIKit/UIKit.h>
#import "DateFormation.h"
#import "LanguageTranslation.h"
#import "MensaDetailViewController.h"
#import "GastronomicFacilityDto.h"
#import "GastronomicFacilityArrayDto.h"
#import "GradientButton.h"
#import "ColorSelection.h"

@interface MensaViewController : UIViewController<UITableViewDelegate>
{

    IBOutlet UITableView                *_mensaOverviewTable;
    IBOutlet UITableViewCell            *_mensaOverviewTableCell;
    
    GastronomicFacilityArrayDto         *_gastronomyFacilityArray;
    
    NSDate                              *_actualDate;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation                       *_dateFormatter;
    LanguageTranslation                 *_translator;
    ColorSelection                      *_zhawColor;
    
    IBOutlet MensaDetailViewController  *_mensaDetailVC;

    IBOutlet UINavigationBar            *_titleNavigationBar;
    IBOutlet UINavigationItem           *_titleNavigationItem;
    IBOutlet UILabel                    *_titleNavigationLabel;
    
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;
    
    IBOutlet UINavigationBar            *_dateNavigationBar;
    IBOutlet UILabel                    *_dateLabel;
    
    IBOutlet UILabel                    *_noConnectionLabel;
    IBOutlet GradientButton             *_noConnectionButton;

    int                                 _tableRows;
}

@property (nonatomic, retain) IBOutlet UITableView                  *_mensaOverviewTable;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_mensaOverviewTableCell;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView      *_waitForChangeActivityIndicator;

@property (nonatomic, retain) GastronomicFacilityArrayDto           *_gastronomyFacilityArray;

@property (nonatomic, retain) IBOutlet MensaDetailViewController    *_mensaDetailVC;
@property (nonatomic, retain) NSDate                                *_actualDate;
@property (nonatomic, retain) DateFormation                         *_dateFormatter;
@property (nonatomic, retain) LanguageTranslation                   *_translator;
@property (nonatomic, retain) ColorSelection                        *_zhawColor;

@property (nonatomic, retain) IBOutlet UILabel                      *_dateLabel;
@property (nonatomic, retain) IBOutlet UINavigationBar              *_dateNavigationBar;

@property (nonatomic, retain) IBOutlet UILabel                      *_noConnectionLabel;
@property (nonatomic, retain) IBOutlet GradientButton               *_noConnectionButton;


@property (nonatomic, assign) int                                       _tableRows;

- (IBAction)tryConnectionAgain:(id)sender;

@end

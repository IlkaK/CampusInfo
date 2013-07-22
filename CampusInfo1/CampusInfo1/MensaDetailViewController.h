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

@interface MensaDetailViewController : UIViewController <ChooseDateViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    GastronomicFacilityDto              *_actualGastronomy;
    IBOutlet GradientButton             *_moveBackButton;
    IBOutlet UINavigationItem           *_dayNavigationItem;
    IBOutlet UILabel                    *_dateLabel;
    DateFormation                       *_dateFormatter;
    NSDate                              *_actualDate;
    IBOutlet ChooseDateViewController   *_chooseDateVC;
    IBOutlet UITableView                *_detailTable;
    IBOutlet UITableViewCell            *_detailTableCell;
    IBOutlet UILabel                    *_gastronomyLabel;
}

@property (nonatomic, retain) GastronomicFacilityDto                    *_actualGastronomy;
@property (nonatomic, retain) GradientButton                            *_moveBackButton;
@property (nonatomic, retain) IBOutlet UINavigationItem                 *_dayNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                          *_dateLabel;
@property (nonatomic, retain) DateFormation                             *_dateFormatter;
@property (nonatomic, retain) NSDate                                    *_actualDate;
@property (nonatomic, retain) IBOutlet ChooseDateViewController         *_chooseDateVC;
@property (nonatomic, retain) IBOutlet UITableView                      *_detailTable;
@property (nonatomic, retain) IBOutlet UITableViewCell                  *_detailTableCell;
@property (nonatomic, retain) IBOutlet UILabel                          *_gastronomyLabel;

- (IBAction)backToMensaOverview:(id)sender;

@end

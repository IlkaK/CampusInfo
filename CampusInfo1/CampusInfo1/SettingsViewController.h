//
//  SettingsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 13.05.13.
//
//

#import <UIKit/UIKit.h>
#import <Autocomplete.h>
#import <LanguageTranslation.h>
#import <StudentsDto.h>
#import <LecturersDto.h>
#import <TimeTableOverviewController.h>
#import <MenuOverviewController.h>

@class TimeTableOverviewController;
@class MenuOverviewController;

@protocol SettingsViewDelegate <NSObject>

@end

@interface SettingsViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField                    *_acronymTextField;
    IBOutlet UITableView                    *_acronymAutocompleteTableView;
    IBOutlet UILabel                        *_timetableSettingsTitle;

    NSMutableArray                          *_suggestions;
    Autocomplete                            *_autocomplete;
    StudentsDto                             *_students;
    LecturersDto                            *_lecturers;
    
    IBOutlet TimeTableOverviewController    *_timeTableVC;
    IBOutlet MenuOverviewController         *_menuOverviewVC;
    
    IBOutlet UINavigationBar                *_titleNavigationBar;
    IBOutlet UINavigationItem               *_titleNavigationItem;
    IBOutlet UILabel                        *_titleNavigationLabel;
}


@property (nonatomic, retain) IBOutlet UITextField                  *_acronymTextField;
@property (nonatomic, retain) IBOutlet UITableView                  *_acronymAutocompleteTableView;
@property (nonatomic, retain) IBOutlet UILabel                      *_timetableSettingsTitle;

@property (strong, nonatomic) NSMutableArray                        *_suggestions;
@property (strong, nonatomic) Autocomplete                          *_autocomplete;
@property (nonatomic, retain) StudentsDto                           *_students;
@property (nonatomic, retain) LecturersDto                          *_lecturers;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet TimeTableOverviewController  *_timeTableVC;
@property (nonatomic, retain) IBOutlet MenuOverviewController       *_menuOverviewVC;

- (IBAction)acronymTextFieldChanged:(id)sender;
- (IBAction)moveBackToMenuOverview:(id)sender;

@end

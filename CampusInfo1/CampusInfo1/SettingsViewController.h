//
//  SettingsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 13.05.13.
//
//

#import <UIKit/UIKit.h>
#import <GradientButton.h>
#import <Autocomplete.h>
#import <LanguageTranslation.h>
#import <StudentsDto.h>
#import <LecturersDto.h>

@protocol SettingsViewDelegate <NSObject>

@end

@interface SettingsViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField                *_acronymTextField;
    IBOutlet GradientButton             *_backToScheduleButton;
    
    IBOutlet UITableView                *_acronymAutocompleteTableView;

    NSMutableArray                      *_suggestions;
    Autocomplete                        *_autocomplete;
    StudentsDto                         *_students;
    LecturersDto                        *_lecturers;
    
    LanguageTranslation                 *_translator;

    IBOutlet UILabel                    *_timetableSettingsTitle;
    
}


@property (nonatomic, retain) IBOutlet UITextField              *_acronymTextField;
@property (nonatomic, retain) IBOutlet GradientButton           *_backToScheduleButton;

@property (nonatomic, retain) IBOutlet UITableView              *_acronymAutocompleteTableView;

@property (strong, nonatomic) NSMutableArray                    *_suggestions;
@property (strong, nonatomic) Autocomplete                      *_autocomplete;
@property (nonatomic, retain) StudentsDto                       *_students;
@property (nonatomic, retain) LecturersDto                      *_lecturers;

@property (nonatomic, retain) LanguageTranslation               *_translator;

@property (nonatomic, retain) IBOutlet UILabel                  *_timetableSettingsTitle;

- (IBAction)moveToTimeTable:(id)sender;
- (IBAction)acronymTextFieldChanged:(id)sender;
- (IBAction)moveBackToMenuOverview:(id)sender;

@end

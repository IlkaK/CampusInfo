//
//  SettingsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 13.05.13.
//
//

#import <UIKit/UIKit.h>
#import <GradientButton.h>
#import <DBCachingForAutocomplete.h>
#import <Autocomplete.h>
#import <TimeTableAsyncRequest.h>
#import <LanguageTranslation.h>

@interface SettingsViewController : UIViewController<UITextFieldDelegate, TimeTableAsyncRequestDelegate>
{
    IBOutlet UITextField        *_acronymTextField;
    IBOutlet UILabel            *_warningLabel;
    IBOutlet GradientButton     *_backToScheduleButton;
    
    IBOutlet UITableView        *_acronymAutocompleteTableView;
    DBCachingForAutocomplete    *_dbCachingForAutocomplete;    
    NSMutableArray              *_suggestions;
    Autocomplete                *_autocomplete;
    
    NSMutableArray              *_lecturerArray;
    NSMutableArray              *_lecturerArrayFromDB;
    NSMutableArray              *_studentArray;
    NSMutableArray              *_studentArrayFromDB;
    
    NSDictionary                *_generalDictionary;
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    NSData                      *_dataFromUrl;
    NSString                    *_errorMessage;
    int                         _connectionTrials;
    
    LanguageTranslation         *_translator;
    NSString                    *_searchType;
}


@property (nonatomic, retain) IBOutlet UITextField          *_acronymTextField;
@property (nonatomic, retain) IBOutlet UILabel              *_warningLabel;
@property (nonatomic, retain) IBOutlet GradientButton       *_backToScheduleButton;

@property (nonatomic, retain) IBOutlet UITableView          *_acronymAutocompleteTableView;
@property (nonatomic, retain) DBCachingForAutocomplete      *_dbCachingForAutocomplete;
@property (strong, nonatomic) NSMutableArray                *_suggestions;
@property (strong, nonatomic) Autocomplete                  *_autocomplete;

@property (strong, nonatomic) NSMutableArray                *_lecturerArray;
@property (strong, nonatomic) NSMutableArray                *_lecturerArrayFromDB;
@property (strong, nonatomic) NSMutableArray                *_studentArray;
@property (strong, nonatomic) NSMutableArray                *_studentArrayFromDB;

@property (strong, nonatomic) NSDictionary                   *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                         *_dataFromUrl;
@property (nonatomic, retain) NSString                       *_errorMessage;
@property (nonatomic, assign) int                             _connectionTrials;

@property (nonatomic, retain) LanguageTranslation            *_translator;

@property (nonatomic, retain) NSString                       *_searchType;

- (IBAction)moveToTimeTable:(id)sender;
- (IBAction)acronymTextFieldChanged:(id)sender;

@end

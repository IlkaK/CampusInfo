//
//  PublicStopViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 28.08.13.
//
//

#import <UIKit/UIKit.h>
#import <StationArrayDto.h>
#import <StationDto.h>
#import <GradientButton.h>
#import <DBCachingForAutocomplete.h>
#import <Autocomplete.h>

@interface PublicStopViewController : UIViewController<UITextFieldDelegate>
{
    StationArrayDto                     *_stationArray;
    NSString                            *_acutalStationName;
    NSString                            *_actualStationName;
    
    IBOutlet UINavigationBar            *_titleNavigationBar;
    IBOutlet UINavigationItem           *_titleNavigationItem;
    IBOutlet UILabel                    *_titleNavigationLabel;
    
    IBOutlet UITableView                *_publicStopTableView;
    
    IBOutlet UITextField                *_publicStopTextField;
    NSString                            *_publicStopTextFieldString;
    
    DBCachingForAutocomplete            *_dbCachingForAutocomplete;
    NSMutableArray                      *_suggestions;
    Autocomplete                        *_autocomplete;
}

@property (nonatomic, retain) StationArrayDto                       *_stationArray;
@property (nonatomic, retain) NSString                              *_actualStationType;
@property (nonatomic, retain) NSString                              *_actualStationName;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet UITableView                  *_publicStopTableView;

@property (nonatomic, retain) IBOutlet UITextField                  *_publicStopTextField;
@property (nonatomic, retain) NSString                              *_publicStopTextFieldString;

@property (nonatomic, retain) DBCachingForAutocomplete              *_dbCachingForAutocomplete;
@property (strong, nonatomic) NSMutableArray                        *_suggestions;
@property (strong, nonatomic) Autocomplete                          *_autocomplete;

- (IBAction)publicStopTextFieldChanged:(id)sender;

@end

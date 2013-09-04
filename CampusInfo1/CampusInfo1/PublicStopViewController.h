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

@interface PublicStopViewController : UIViewController<UITextFieldDelegate>
{
    StationArrayDto                     *_stationArray;
    StationDto                          *_actualStation;
    NSString                            *_actualStationType;
    
    IBOutlet UINavigationBar            *_titleNavigationBar;
    IBOutlet UINavigationItem           *_titleNavigationItem;
    IBOutlet UILabel                    *_titleNavigationLabel;
    
    IBOutlet UITableView                *_publicStopTableView;
    IBOutlet GradientButton             *_actualizeButton;
    
    IBOutlet UITextField                *_publicStopTextField;
    NSString                            *_publicStopTextFieldString;
}

@property (nonatomic, retain) StationArrayDto                       *_stationArray;
@property (nonatomic, retain) StationDto                            *_actualStation;
@property (nonatomic, retain) NSString                              *_actualStationType;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet UITableView                  *_publicStopTableView;
@property (nonatomic, retain) IBOutlet GradientButton               *_actualizeButton;

@property (nonatomic, retain) IBOutlet UITextField                  *_publicStopTextField;
@property (nonatomic, retain) NSString                              *_publicStopTextFieldString;


- (IBAction)actualizeSuggestions:(id)sender;
- (IBAction)publicStopTextFieldChanged:(id)sender;

@end

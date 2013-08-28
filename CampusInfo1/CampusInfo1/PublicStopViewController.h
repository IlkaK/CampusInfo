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

@interface PublicStopViewController : UIViewController 
{
    StationArrayDto                     *_stationArray;
    StationDto                          *_actualStation;
    NSString                            *_actualStationType;
    
    IBOutlet UINavigationBar            *_titleNavigationBar;
    IBOutlet UINavigationItem           *_titleNavigationItem;
    IBOutlet UILabel                    *_titleNavigationLabel;
    
    IBOutlet UITableView                *_publicStopTableView;
    
    IBOutlet UILabel                    *_noConnectionLabel;
    IBOutlet GradientButton             *_noConnectionButton;
}

@property (nonatomic, retain) StationArrayDto                       *_stationArray;
@property (nonatomic, retain) StationDto                            *_actualStation;
@property (nonatomic, retain) NSString                              *_actualStationType;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet UITableView                  *_publicStopTableView;

@property (nonatomic, retain) IBOutlet UILabel                      *_noConnectionLabel;
@property (nonatomic, retain) IBOutlet GradientButton               *_noConnectionButton;

- (IBAction)tryConnectionAgain:(id)sender;

@end

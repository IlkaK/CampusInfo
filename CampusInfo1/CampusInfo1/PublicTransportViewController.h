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

@class PublicStopViewController;

@interface PublicTransportViewController : UIViewController<UITableViewDelegate>
{
    IBOutlet UINavigationBar            *_publicTransportNavigationBar;
    IBOutlet UINavigationItem           *_publicTransportNavigationItem;
    IBOutlet UILabel                    *_publicTransportNavigationLabel;
    
    IBOutlet GradientButton             *_fromButton;
    IBOutlet GradientButton             *_toButton;
    IBOutlet GradientButton             *_searchButton;
    
    IBOutlet UITableViewCell            *_pubilcTransportOverviewTableCell;
    IBOutlet PublicStopViewController   *_publicStopVC;

}

@property (nonatomic, retain) IBOutlet UINavigationBar              *_publicTransportNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_publicTransportNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_publicTransportNavigationLabel;

@property (nonatomic, retain) IBOutlet GradientButton               *_fromButton;
@property (nonatomic, retain) IBOutlet GradientButton               *_toButton;
@property (nonatomic, retain) IBOutlet GradientButton               *_searchButton;

@property (nonatomic, retain) IBOutlet UITableViewCell              *_pubilcTransportOverviewTableCell;

@property (nonatomic, retain) IBOutlet PublicStopViewController     *_publicStopVC;

- (IBAction)moveToFromStopController:(id)sender;
- (IBAction)moveToToStopController:(id)sender;
- (IBAction)startConnectionSearch:(id)sender;

@end

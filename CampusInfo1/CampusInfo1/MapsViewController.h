//
//  MapsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import <UIKit/UIKit.h>
#import <GradientButton.h>
#import <TechnikumViewController.h>
#import <ZurichViewController.h>

@class TechnikumViewController;
@class ZurichViewController;

@interface MapsViewController : UIViewController
{

    IBOutlet UILabel                    *_titleLabel;
    IBOutlet GradientButton             *_technikumButton;
    IBOutlet GradientButton             *_zurichButton;
    
    IBOutlet TechnikumViewController    *_technikumVC;
    IBOutlet ZurichViewController       *_zurichVC;
}

@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;
@property (nonatomic, retain) IBOutlet GradientButton               *_technikumButton;
@property (nonatomic, retain) IBOutlet GradientButton               *_zurichButton;

@property (nonatomic, retain) IBOutlet TechnikumViewController      *_technikumVC;
@property (nonatomic, retain) IBOutlet ZurichViewController         *_zurichVC;


- (IBAction)moveBackToMenuOverview:(id)sender;
- (IBAction)moveToZurichMap:(id)sender;
- (IBAction)moveToTechnikumMap:(id)sender;

@end

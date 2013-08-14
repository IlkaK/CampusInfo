//
//  ChooseDateViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 13.05.13.
//
//

#import <UIKit/UIKit.h>
#import <GradientButton.h>

@protocol ChooseDateViewDelegate <NSObject>

-(void) setActualDate:(NSDate *)newDate;
@end

@interface ChooseDateViewController : UIViewController
{

    IBOutlet UILabel                    *_titleLabel;

    IBOutlet GradientButton             *_cancelButton;
    IBOutlet GradientButton             *_todayButton;
    IBOutlet GradientButton             *_doneButton;

    NSDate                              *_actualDate;
    IBOutlet UIDatePicker               *_datePicker;
    
    id                                  _chooseDateViewDelegate;
    
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;
}


@property (nonatomic, retain) IBOutlet UILabel                  *_titleLabel;

@property (nonatomic, retain) IBOutlet GradientButton           *_cancelButton;
@property (nonatomic, retain) IBOutlet GradientButton           *_todayButton;
@property (nonatomic, retain) IBOutlet GradientButton           *_doneButton;

@property (nonatomic, retain) NSDate                            *_actualDate;
@property (nonatomic, retain) IBOutlet UIDatePicker             *_datePicker;

@property (nonatomic, retain) id<ChooseDateViewDelegate>        _chooseDateViewDelegate;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView  *_waitForChangeActivityIndicator;

- (IBAction)setPickerToToday:(id)sender;
- (IBAction)cancelDateChoice:(id)sender;
- (IBAction)acceptDateChoice:(id)sender;

@end

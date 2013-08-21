//
//  ChooseDateViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 13.05.13.
//
//

#import <UIKit/UIKit.h>

@protocol ChooseDateViewDelegate <NSObject>

-(void) setActualDate:(NSDate *)newDate;
@end

@interface ChooseDateViewController : UIViewController
{

    IBOutlet UILabel                    *_titleLabel;

    NSDate                              *_actualDate;
    IBOutlet UIDatePicker               *_datePicker;
    
    id                                  _chooseDateViewDelegate;
    
    IBOutlet UISegmentedControl         *_chooseDateSegmentedControl;
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;
}


@property (nonatomic, retain) IBOutlet UILabel                  *_titleLabel;

@property (nonatomic, retain) NSDate                            *_actualDate;
@property (nonatomic, retain) IBOutlet UIDatePicker             *_datePicker;

@property (nonatomic, retain) id<ChooseDateViewDelegate>        _chooseDateViewDelegate;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView  *_waitForChangeActivityIndicator;
@property (nonatomic, retain) IBOutlet UISegmentedControl       *_chooseDateSegmentedControl;

- (IBAction)setPickerToToday:(id)sender;
- (IBAction)cancelDateChoice:(id)sender;
- (IBAction)acceptDateChoice:(id)sender;
- (IBAction)moveToChooseDateSegmentedControl:(id)sender;

@end

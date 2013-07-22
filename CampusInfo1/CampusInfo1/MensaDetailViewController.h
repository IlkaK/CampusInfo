//
//  MensaDetailViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 22.07.13.
//
//

#import <UIKit/UIKit.h>
#import <GastronomicFacilityDto.h>

@interface MensaDetailViewController : UIViewController
{
    GastronomicFacilityDto *_actualGastronomy;
}

@property (nonatomic, retain) GastronomicFacilityDto                    *_actualGastronomy;

- (IBAction)backToMensaOverview:(id)sender;

@end

//
//  ServiceDeskViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 26.08.13.
//
//

#import <UIKit/UIKit.h>
#import "ColorSelection.h"

@interface ServiceDeskViewController : UIViewController<UITableViewDelegate>
{
    IBOutlet UINavigationBar        *_titleNavigationBar;
    IBOutlet UINavigationItem       *_titleNavigationItem;
    IBOutlet UILabel                *_titleNavigationLabel;

    IBOutlet UITableViewCell        *_serviceDeskTableCell;

    NSString                        *_currentEmail;
    NSString                        *_currentPhoneNumber;
    
    ColorSelection                  *_zhawColors;
}

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet UITableViewCell              *_serviceDeskTableCell;

@property (nonatomic, retain) NSString                              *_currentEmail;
@property (nonatomic, retain) NSString                              *_currentPhoneNumber;

@property (nonatomic, retain) ColorSelection                        *_zhawColors;

@end

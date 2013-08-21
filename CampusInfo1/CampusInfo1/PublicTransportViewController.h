//
//  PublicTransportViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <UIKit/UIKit.h>

@interface PublicTransportViewController : UIViewController
{
    IBOutlet UINavigationBar        *_publicTransportNavigationBar;
    IBOutlet UINavigationItem       *_publicTransportNavigationItem;
    IBOutlet UILabel                *_publicTransportNavigationLabel;
}

@property (nonatomic, retain) IBOutlet UINavigationBar              *_publicTransportNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_publicTransportNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_publicTransportNavigationLabel;


@end

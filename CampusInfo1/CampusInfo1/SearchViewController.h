//
//  SecondViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchViewController : UIViewController {
    
    IBOutlet UITextField *_searchTextField;
}

- (IBAction)_startSearch:(id)sender;

@end

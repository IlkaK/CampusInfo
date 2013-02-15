//
//  AcronymViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AcronymViewDelegate <NSObject>

-(void) setAcronymLabel:(NSString *)newAcronym;
@end

@interface AcronymViewController : UIViewController 
{    
    UITextField               *_acronymTextField;
    id                         _acronymViewDelegate;
    
    IBOutlet UILabel          *_warningLabel;
    IBOutlet UINavigationItem *_acronymNavigationItem;
}

@property (nonatomic, assign) id<AcronymViewDelegate>      _acronymViewDelegate;
@property (nonatomic, retain) IBOutlet UITextField        *_acronymTextField;
@property (nonatomic, retain) IBOutlet UINavigationItem   *_acronymNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel            *_warningLabel;



@end

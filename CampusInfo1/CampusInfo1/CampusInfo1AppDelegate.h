//
//  CampusInfo1AppDelegate.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CampusInfo1AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> 
{
    
}

@property (nonatomic, retain) IBOutlet UIWindow           *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

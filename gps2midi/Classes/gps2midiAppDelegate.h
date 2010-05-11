//
//  gps2midiAppDelegate.h
//  gps2midi
//
//  Created by Bryan Summersett on 5/11/10.
//  Copyright Student 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <lo/lo.h>

@interface gps2midiAppDelegate : NSObject <UIApplicationDelegate,CLLocationManagerDelegate> {
    UIWindow *window;
    CLLocationManager *locationManager;
    lo_address          loClient;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) CLLocationManager *locationManager;  

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;
@end


//
//  CLController.h
//  gps2midi
//
//  Created by Bryan Summersett on 5/11/10.
//  Copyright 2010 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <lo/lo.h>

@interface CLController : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
    lo_address          loClient;
}

@property (nonatomic, retain) CLLocationManager *locationManager;  

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;

@end

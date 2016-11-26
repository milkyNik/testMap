//
//  ViewController.h
//  MapHomeWork
//
//  Created by iMac on 04.09.16.
//  Copyright © 2016 MilNik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)actionChangeMapType:(UISegmentedControl *)sender;


@end


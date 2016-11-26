//
//  ViewController.m
//  MapHomeWork
//
//  Created by iMac on 04.09.16.
//  Copyright © 2016 MilNik. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "MNStudent.h"
#import "UIView+MKAnnotationView.h"

@interface ViewController ()

//@property (strong, nonatomic) NSDictionary* dict;
@property (strong, nonatomic) CLGeocoder* geoCoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.geoCoder = [[CLGeocoder alloc] init];
    
    
    //self.dict = @{@"1" : @"1", @"2" : @"2", @"3" : @"3", @"4" : @"4", @"5" : @"5"};
    
    //NSLog(@"%@", [self mixDictionary:self.dict]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
}

#pragma mark - Func

- (NSDictionary*) mixDictionary:(NSDictionary*) dictionary {
    
    NSMutableArray* keysArray = [NSMutableArray arrayWithArray:[dictionary allKeys]];
    
    NSInteger count = [keysArray count];
    
    NSMutableDictionary* mixDictionary = [NSMutableDictionary dictionary];
    
    for (int i = 1; i <= count; i++) {
        
        NSInteger index = arc4random_uniform([keysArray count]);
        
        [mixDictionary setObject:[dictionary objectForKey:keysArray[index]] forKey:[NSString stringWithFormat:@"%d", i]];
        
        [keysArray removeObjectAtIndex:index];
        
    }
    
    return mixDictionary;
    
}

#pragma mark - Actions

- (IBAction)actionChangeMapType:(UISegmentedControl *)sender {
    
    self.mapView.mapType = sender.selectedSegmentIndex;
}

- (void) actionDescription:(UIButton*) sender {
 
    MNStudent* annotation = [sender superAnnotationView].annotation;

    
    DetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailController.modalPresentationStyle = UIModalPresentationPopover;
    
    
    
    CLLocationCoordinate2D coordinate = annotation.coordinate;
    CLLocation* location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark* placemark = [placemarks firstObject];

        [self presentViewController:detailController animated:YES completion:nil];
        
        detailController.firstName.text = annotation.firstName;
        detailController.lastName.text = annotation.lastName;
        detailController.lastName.text = annotation.lastName;
        detailController.gender.text = annotation.gender? @"Women":@"Man";
        detailController.dateOfBirth.text = [annotation getDateOfBirth];
        detailController.address.text = [NSString stringWithFormat:@"%@", placemark.addressDictionary];
    }];

    UIPopoverPresentationController *popController = [detailController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.sourceView = sender;
    
    
}


- (void) actionAdd:(UIBarButtonItem*) sender {
    
    for (int i = 0; i < 20; i++) {
        [self.mapView addAnnotation:[MNStudent randomStudent]];
    }
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        MNStudent* pin = annotation;
        
        CLLocationCoordinate2D location = pin.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 20000;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
        
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(50, 50, 50, 50)
                           animated:YES];
    
}

#pragma mark - MKMapViewDelegate

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
        
    UIBarButtonItem* addStudents = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(actionAdd:)];
    [self.navigationItem setRightBarButtonItem:addStudents animated:YES];
    
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* identifier = @"Annotation";
    
    MKAnnotationView* pin = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.canShowCallout = YES;
        
        MNStudent* studentAnnotation = pin.annotation;
        
        if (studentAnnotation.gender) {
            pin.image = [UIImage imageNamed:@"women_small"];
        } else {
            pin.image = [UIImage imageNamed:@"man_small"];
        }
        
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        [infoButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
        
        pin.rightCalloutAccessoryView = infoButton;
        
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
}


@end

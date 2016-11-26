//
//  MNStudent.m
//  SearchHomeWork
//
//  Created by iMac on 24.07.16.
//  Copyright © 2016 MilNik. All rights reserved.
//

#import "MNStudent.h"

#define MAIN_LATITUDE 49.99722f
#define MAIN_LONGITUDE 36.23333f

@implementation MNStudent

static NSString* firstName[] = {@"Nik", @"Kostik", @"Vetal", @"Alex", @"Ivan", @"Oxana", @"Yuliya", @"Vika", @"Katya", @"Tanya"};

static NSString* lastName[] = {@"Milko", @"Konovalenko", @"Potenko", @"Sinitko", @"Rembo", @"Tarasenko" , @"Zejda", @"Pavluk", @"Schemchuk", @"Kiryuch"};

static NSInteger namesCount = 10;





+ (MNStudent*) randomStudent {
    
    MNStudent* student = [[MNStudent alloc] init];
    
    if (student) {
        student.firstName = firstName[arc4random() % namesCount];
        student.lastName = lastName[arc4random() % namesCount];
        student.dateOfBirth = [[NSDate alloc] initWithTimeIntervalSinceNow:arc4random()];
        student.coordinate = [student randomCoordinate];
        student.title = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        student.subtitle = [student getDateOfBirth];
        student.gender = arc4random_uniform(2);
        
    }
    return student;
}


- (NSString*) getDateOfBirth {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    
    return [NSString stringWithFormat:@"%@", [formatter stringFromDate:self.dateOfBirth]];
    
}

#pragma mark - Support methods

- (CLLocationCoordinate2D) randomCoordinate{
    
    CLLocationCoordinate2D randomCoordinate;
    
    float deltaX = [self generatorDeltaCoordinate];
    float deltaY = [self generatorDeltaCoordinate];
    
    //#define MAIN_LATITUDE 49.99722f
    //#define MAIN_LONGITUDE 36.23333f
    
    randomCoordinate.latitude = arc4random() % 2 ? MAIN_LATITUDE + deltaX : MAIN_LATITUDE - deltaX;
    randomCoordinate.longitude = arc4random() % 2 ? MAIN_LONGITUDE + deltaY : MAIN_LONGITUDE - deltaY;
    
    return randomCoordinate;
}

- (double) generatorDeltaCoordinate {
    
    double max = 0.2f;
    double min = -0.2f;
    return ((double)arc4random() / UINT32_MAX) * (max - min) + min;
}

@end

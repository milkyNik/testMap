//
//  MNStudent.h
//  SearchHomeWork
//
//  Created by iMac on 24.07.16.
//  Copyright © 2016 MilNik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
    MNStudentGenderMan,
    MNStudentGenderWomen
} MNStudentGender;

@interface MNStudent : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSDate* dateOfBirth;
@property (assign, nonatomic) MNStudentGender gender;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

+ (MNStudent*) randomStudent;
- (CLLocationCoordinate2D) randomCoordinate;
- (NSString*) getDateOfBirth;

@end

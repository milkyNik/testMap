//
//  DetailViewController.h
//  MapHomeWork
//
//  Created by iMac on 26.09.16.
//  Copyright © 2016 MilNik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirth;

@property (weak, nonatomic) IBOutlet UITextView *address;

@end

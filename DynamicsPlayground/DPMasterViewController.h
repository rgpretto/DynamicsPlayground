//
//  DPMasterViewController.h
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/10/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPDetailViewController;

@interface DPMasterViewController : UITableViewController

@property (strong, nonatomic) DPDetailViewController *detailViewController;

@end

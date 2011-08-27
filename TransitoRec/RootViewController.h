//
//  RootViewController.h
//  TransitoRec
//
//  Created by Luiz Tiago Alves de Oliveira on 27/08/11.
//  Copyright 2011 iR4 Consultoria Web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
    UIActivityIndicatorView *activityIndicator;
    NSArray *items;
}

@property (retain, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) NSArray *items;

@end

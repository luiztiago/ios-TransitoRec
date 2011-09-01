//
//  DetailViewController.h
//  TransitoRec
//
//  Created by Luiz Tiago Alves de Oliveira on 27/08/11.
//  Copyright 2011 iR4 Consultoria Web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface DetailViewController : UIViewController {
    NSString *descricao;
    NSString *latitude;
    NSString *longitude;
    NSString *imagem;
    UIImage *imageFromBundle;
    UIWebView *imgUrl;
    MKMapView *mapUrl;
    UIImageView *photo;
}
@property (nonatomic, retain) NSString *descricao;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *imagem;
@property (nonatomic, retain) UIImage *imageFromBundle;
@property (nonatomic, retain) IBOutlet UIWebView *imgUrl;
@property (nonatomic, retain) IBOutlet MKMapView *mapUrl;
@property (nonatomic, retain) IBOutlet UIImageView *photo;

@end
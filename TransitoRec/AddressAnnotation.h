//
//  AddressAnnotation.h
//  TransitoRec
//
//  Created by Luiz Tiago Alves de Oliveira on 01/09/11.
//  Copyright 2011 iR4 Consultoria Web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
}

@end
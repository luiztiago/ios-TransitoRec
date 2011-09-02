//
//  AddressAnnotation.m
//  TransitoRec
//
//  Created by Luiz Tiago Alves de Oliveira on 01/09/11.
//  Copyright 2011 iR4 Consultoria Web. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation
@synthesize coordinate;

- (NSString *)subtitle{
	return nil;
}

- (NSString *)title{
	return nil;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	return self;
}

@end
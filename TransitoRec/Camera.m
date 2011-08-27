//
//  Camera.m
//  TransitoRec
//
//  Created by Luiz Tiago Alves de Oliveira on 27/08/11.
//  Copyright 2011 iR4 Consultoria Web. All rights reserved.
//

#import "Camera.h"

@implementation Camera
@synthesize descricao;
@synthesize sentido;
@synthesize imgUrl;
@synthesize latitude;
@synthesize longitude;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end

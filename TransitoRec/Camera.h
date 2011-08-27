//
//  Camera.h
//  TransitoRec
//
//  Created by Luiz Tiago Alves de Oliveira on 27/08/11.
//  Copyright 2011 iR4 Consultoria Web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Camera : NSObject {
    NSString *descricao;
    NSString *sentido;
    NSString *imgUrl;
    NSNumber *latitude;
    NSNumber *longitude;
}

@property (nonatomic, retain) NSString *descricao;
@property (nonatomic, retain) NSString *sentido;
@property (nonatomic, retain) NSString *imgUrl;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;

@end

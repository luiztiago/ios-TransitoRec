//
//  Parser.h
//  RssSample
//
//  Created by Richardson Oliveira on 11-08-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ParserDelegate <NSObject>
- (void)receivedItems:(NSArray *)theItems;
@end

@interface Parser : NSObject <NSXMLParserDelegate>{
    
    id _delegate;
    
    NSMutableData *responseData;
    NSMutableArray *items;
    
    NSMutableDictionary *item;
    NSString *currentElement;
    NSMutableString *currentDescricao, *currentSentido, *currentImgUrl, *currentLatitude, *currentLongitude;
    
}

@property (retain, nonatomic) NSMutableData *responseData;
@property (retain, nonatomic) NSMutableArray *items;

@property (retain, nonatomic) NSMutableDictionary *item;
@property (retain, nonatomic) NSString *currentElement;
@property (retain, nonatomic) NSMutableString *currentDescricao;
@property (retain, nonatomic) NSMutableString *currentSentido;
@property (retain, nonatomic) NSMutableString *currentImgUrl;
@property (retain, nonatomic) NSMutableString *currentLatitude;
@property (retain, nonatomic) NSMutableString *currentLongitude;


- (void)parseRssFeed:(NSString *)url withDelegate:(id)aDelegate;

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@end

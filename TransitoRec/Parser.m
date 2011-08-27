//
//  Parser.m
//  RssSample
//
//  Created by Richardson Oliveira on 11-08-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Parser.h"


@implementation Parser
@synthesize responseData;
@synthesize items;
@synthesize item;
@synthesize currentElement;
@synthesize currentDescricao;
@synthesize currentSentido;
@synthesize currentImgUrl;
@synthesize currentLatitude;
@synthesize currentLongitude;


//Método que inicia o parser
- (void)parseRssFeed:(NSString *)url withDelegate:(id)aDelegate
{
    [self setDelegate:aDelegate];
    
	responseData = [[NSMutableData data] retain];
	NSURL *baseURL = [[NSURL URLWithString:url] retain];
	
	
	NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
	
	[[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
}

//Métodos para tratar os eventos de Conexão.
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    [responseData appendData:data];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString * errorString = [NSString stringWithFormat:@"Não foi possivel fazer download dos dados (Erro %i )", [error code]];
	
    UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error no carregamento dos dados" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	self.items = [[NSMutableArray alloc] init];
	
	NSXMLParser *rssParser = [[NSXMLParser alloc] initWithData:responseData];
	
	[rssParser setDelegate:self];
	
	[rssParser parse];
}
//Implementa métodos do NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
    NSLog(@"Start");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	currentElement = [elementName copy];
	
    if ([elementName isEqualToString:@"Ponto"]) {
        item = [[NSMutableDictionary alloc] init];
        self.currentDescricao = [[NSMutableString alloc] init];
        self.currentSentido = [[NSMutableString alloc] init];
        self.currentImgUrl = [[NSMutableString alloc] init];
		self.currentLatitude = [[NSMutableString alloc] init];
        self.currentLongitude = [[NSMutableString alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
    if ([elementName isEqualToString:@"Ponto"]) {
        [item setObject:self.currentDescricao forKey:@"Descricao"];
        [item setObject:self.currentSentido forKey:@"Sentido"];
        [item setObject:self.currentImgUrl forKey:@"ImgVisWEB"];
		[item setObject:self.currentLatitude forKey:@"Latitude"];
        [item setObject:self.currentLongitude forKey:@"Longitude"];

		////*currentDescricao, *currentSentido, *currentImgUrl, *currentLatitude, *currentLongitude;
        
        [items addObject:[item copy]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([currentElement isEqualToString:@"Descricao"]) {
        [self.currentDescricao appendString:string];
    } else if ([currentElement isEqualToString:@"Sentido"]) {
        [self.currentSentido appendString:string];
    } else if ([currentElement isEqualToString:@"ImgVisWEB"]) {
        [self.currentImgUrl appendString:string];
    } else if ([currentElement isEqualToString:@"Latitude"]) {
		[self.currentLatitude appendString:string];
    } else if ([currentElement isEqualToString:@"Longitude"]) {
		[self.currentLongitude appendString:string];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	if ([_delegate respondsToSelector:@selector(receivedItems:)])
        [_delegate receivedItems:items];
    else
    { 
        [NSException raise:NSInternalInconsistencyException
					format:@"Delegate não implementou receivedItems:"];
    }
}

//Get e Set do delegate
- (id)delegate
{
    return _delegate; 
}

- (void)setDelegate:(id)new_delegate
{
    _delegate = new_delegate;
}

- (void)dealloc {
	[items release];
	[responseData release];
	[super dealloc];
}

@end

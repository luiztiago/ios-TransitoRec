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
@synthesize currentTitle;
@synthesize currentLink;
@synthesize currentContent;
@synthesize currentDescription;


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
    NSString * errorString = [NSString stringWithFormat:@"Não foi possivel fazer donwload dos dados (Erro %i )", [error code]];
	
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
	
    if ([elementName isEqualToString:@"item"]) {
        item = [[NSMutableDictionary alloc] init];
        self.currentTitle = [[NSMutableString alloc] init];
        self.currentDescription = [[NSMutableString alloc] init];
        self.currentLink = [[NSMutableString alloc] init];
		self.currentContent = [[NSMutableString alloc] init];
    }
	
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
    if ([elementName isEqualToString:@"item"]) {
        [item setObject:self.currentTitle forKey:@"title"];
        [item setObject:self.currentLink forKey:@"link"];
        [item setObject:self.currentDescription forKey:@"description"];
		[item setObject:self.currentContent forKey:@"content"];

		
        [items addObject:[item copy]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([currentElement isEqualToString:@"title"]) {
        [self.currentTitle appendString:string];
    } else if ([currentElement isEqualToString:@"link"]) {
        [self.currentLink appendString:string];
    } else if ([currentElement isEqualToString:@"description"]) {
        [self.currentDescription appendString:string];
    } else if ([currentElement isEqualToString:@"content"]) {
		[self.currentContent appendString:string];
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

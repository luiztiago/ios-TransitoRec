//
//  DetailViewController.m
//  TransitoRec
//
//  Created by Luiz Tiago Alves de Oliveira on 27/08/11.
//  Copyright 2011 iR4 Consultoria Web. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "AddressAnnotation.h"

@implementation DetailViewController
@synthesize descricao;
@synthesize latitude;
@synthesize longitude;
@synthesize imagem;
@synthesize imgUrl;
@synthesize mapUrl;
@synthesize photo;
@synthesize rec_ad;
@synthesize imageFromBundle;
@synthesize bannerIsVisible;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setTitle:descricao];
    [self.navigationItem setTitle:descricao];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Voltar"                                            
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(backHome)];
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton release];
    
    /*UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"F5"                                            
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(refreshView)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    [refreshButton release];*/
    
    CLLocationCoordinate2D location = self.mapUrl.userLocation.coordinate;
    location.latitude = [self.latitude doubleValue];
    location.longitude = [self.longitude doubleValue];
    
    MKCoordinateSpan span = {.latitudeDelta = 0.01, .longitudeDelta = 0.01};
    MKCoordinateRegion region = {location, span};
    
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
    [mapUrl addAnnotation:addAnnotation];
    [addAnnotation release];
    
    [self.mapUrl setRegion:region];
    
    // URL
    
    NSString *pattern = @"http://www.recife.pe.gov.br/transito/imagensCTTU/jpg/";
    NSString *url = [NSString stringWithFormat:@"%@%@", pattern, self.imagem];
    
    NSString *trimmedString = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSURL *urlText = [NSURL URLWithString:trimmedString];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlText];
    [self.imgUrl loadRequest:request];
    
    NSData *imageData = [NSData dataWithContentsOfURL:urlText];
    imageFromBundle = [[UIImage alloc] initWithData:imageData];
    [self.photo setImage:imageFromBundle];
    
    //ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    rec_ad.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    
    [self.view addSubview:rec_ad];
    
    // Do any additional setup after loading the view from its nib.
}
                                   
- (void)backHome {
    //RootViewController *rootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    //[self.navigationController pushViewController:rootViewController animated:YES];
    //[rootViewController release];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        [banner setDelegate:self];
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        rec_ad.frame = CGRectOffset(rec_ad.frame, 0, -rec_ad.frame.size.height);
        [UIView commitAnimations];
        rec_ad.hidden = false;
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [banner setDelegate:self];
    if (self.bannerIsVisible)
    {
        
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        rec_ad.frame = CGRectOffset(rec_ad.frame, 0, rec_ad.frame.size.height);
        [UIView commitAnimations];
        rec_ad.hidden = true;
        self.bannerIsVisible = NO;
    }
}

- (void)refreshView {

    [self.photo setImage:nil];
    [self.photo setImage:imageFromBundle];
    
}

- (void)viewDidUnload
{
    [self setLongitude:nil];
    [self setLatitude:nil];
    [self setImagem:nil];
    [self setImgUrl:nil];
    [self setMapUrl:nil];
    [self setPhoto:nil];
    [self setRec_ad:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    [longitude release];
    [latitude release];
    [imagem release];
    [imgUrl release];
    [mapUrl release];
    [photo release];
    [rec_ad release];
    [super dealloc];
}
@end

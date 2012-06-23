#import "WebController.h"


@interface WebController ()
@property(nonatomic,retain)NSURL *url;
@end


@implementation WebController

@synthesize url;

- (id)initWithURL:(NSURL *)theURL {
    [super initWithNibName:@"WebView" bundle:nil];
	self.url = theURL;
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [url absoluteString];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:activityView] autorelease];
	// Start loading the website
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	[webView loadRequest:request];
	[request release];
}

- (void)dealloc {
	[self webViewDidFinishLoad:webView];
	[webView stopLoading];
	webView.delegate = nil;
	[url release];
	[activityView release];
	[webView release];
    [super dealloc];
}

- (void)viewWillDisappear:(BOOL)animated {
	[webView stopLoading];
	webView.delegate = nil;
	[super viewWillDisappear:animated];
}

#pragma mark WebView

- (void)webViewDidStartLoad:(UIWebView *)webview {
	[activityView startAnimating];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webview {
	[activityView stopAnimating];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
	[activityView stopAnimating];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark Autorotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

@end

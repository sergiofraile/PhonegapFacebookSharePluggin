//
//  FacebookPlugin.m
//  FacebookPlugin
//
//  Created by Sergio Fraile on 15/04/13.
//

#import "FacebookPlugin.h"
#import <Cordova/JSONKit.h>
#import <Cordova/CDVAvailability.h>

@implementation FacebookPlugin


- (void)available:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options {
    BOOL avail = false;
    
    if ([SLRequest class] != nil) {
        avail = true;
    }
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:avail];
    [self writeJavascript:[pluginResult toSuccessCallbackString:[arguments objectAtIndex:0]]];
}

- (void) shareFacebookWall:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options{
    // arguments: callback, tweet text, url attachment, image attachment
    NSString *callbackId = [arguments objectAtIndex:0];
    NSString *text = [options objectForKey:@"text"];
    NSString *urlAttach = [options objectForKey:@"urlAttach"];
    NSString *imageAttach = [options objectForKey:@"imageAttach"];
    
    SLComposeViewController *facebookViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    BOOL ok = YES;
    NSString *errorMessage;
    
    if(text != nil){
        ok = [facebookViewController setInitialText:text];
        // if(!ok){
        //     errorMessage = @"Tweet is too long";
        // }
    }
    

    
    if(imageAttach != nil){
        // Note that the image is loaded syncronously
        if([imageAttach hasPrefix:@"http://"]){
            UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageAttach]]];
            ok = [facebookViewController addImage:img];
            [img release];
        }
        else{
            ok = [facebookViewController addImage:[UIImage imageNamed:imageAttach]];
        }
        if(!ok){
            errorMessage = @"Image could not be added";
        }
    }
    
    if(urlAttach != nil){
        ok = [facebookViewController addURL:[NSURL URLWithString:urlAttach]];
        if(!ok){
            errorMessage = @"URL too long";
        }
    }

    
    
    if(!ok){        
        [super writeJavascript:[[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR 
                                               messageAsString:errorMessage] toErrorCallbackString:callbackId]];
    }
    else{
        
#if TARGET_IPHONE_SIMULATOR
        NSString *simWarning = @"Test FacebookPlugin on Real Hardware. Tested on Cordova 2.0.0";
        //EXC_BAD_ACCESS occurs on simulator unable to reproduce on real device
        //running iOS 5.1 and Cordova 1.6.1
        NSLog(@"%@",simWarning);
#endif
        
        [facebookViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultDone:
                    [super writeJavascript:[[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] toSuccessCallbackString:callbackId]];
                    break;
                case SLComposeViewControllerResultCancelled:
                default:
                    [super writeJavascript:[[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR 
                                                           messageAsString:@"Cancelled"] toErrorCallbackString:callbackId]];
                    break;
            }
            
            [super.viewController dismissModalViewControllerAnimated:YES];
            
        }];
        
        [super.viewController presentModalViewController:facebookViewController animated:YES];
    }
    
    //[facebookViewController release];
}

@end

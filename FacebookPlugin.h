//
//  FacebookPlugin.h
//  FacebookPlugin
//
//  Created by Sergio Fraile on 15/04/13.
//

    #import <Foundation/Foundation.h>
    #import <Social/Social.h>
    #import <Accounts/Accounts.h>
    #import <Cordova/CDVPlugin.h>

@interface FacebookPlugin : CDVPlugin{
}

- (void)available:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

- (void) shareFacebookWall:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end

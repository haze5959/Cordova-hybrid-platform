//
//  PDFViewerPlugin.h
//  bizMOB3_OQ_Project
//
//  Created by 권오규 on 2017. 3. 15..
//  Copyright © 2017년 MOBILE C&C. All rights reserved.
//

#import <Cordova/CDVPlugin.h>

@interface PDFViewerPlugin : CDVPlugin

- (void)showPDF:(CDVInvokedUrlCommand*)command;

@property CDVInvokedUrlCommand* command;
@property UINavigationController* navController;
    
@end

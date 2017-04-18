//
//  PDFViewerPlugin.m
//  bizMOB3_OQ_Project
//
//  Created by 권오규 on 2017. 3. 15..
//  Copyright © 2017년 MOBILE C&C. All rights reserved.
//

#import "PDFViewerPlugin.h"
#import "PDFViewController.h"
#import <Cordova/CDV.h>

@implementation PDFViewerPlugin

- (void)showPDF:(CDVInvokedUrlCommand*)command{
   
    PDFViewController *pdfViewController = [PDFViewController viewController];
    pdfViewController.delegate = self;
    self.command = command;
    //번들에 있는 모든 PDF파일을 가져온다
    NSArray *pdfs = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];
    //파일 없다면 바로 알람, 파일 경로를 뿌려준다
    pdfViewController.filePath = [pdfs firstObject];
    assert(pdfViewController.filePath != nil);
    
    self.navController = [[UINavigationController alloc]init];
    self.navController.navigationBarHidden = YES;
    [self.navController pushViewController:pdfViewController animated:YES];
    [self.viewController.view addSubview:self.navController.view];
    
}
    
#pragma mark - PDFViewerControllerDelegate
- (void) closePlugin:(NSString *)temp{

    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"테스트!!"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.command.callbackId];
    
    [self.navController.view removeFromSuperview];
}


@end
